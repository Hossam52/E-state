import 'dart:io';
import 'package:osol/Company/businessLogicLayer/profilecompanyCubit/profile_company_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/PresentationLayer/HomeScreen/HomeScreenView.dart';
import 'package:osol/Company/businessLogicLayer/authCompany/auth_company_cubit.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';

class UpdateCompanyScreen extends StatefulWidget {
  @override
  State<UpdateCompanyScreen> createState() => _UpdateCompanyScreenState();
}

class _UpdateCompanyScreenState extends State<UpdateCompanyScreen> {
  TextEditingController companyNameController = TextEditingController();

  TextEditingController companyEmailController = TextEditingController();

  TextEditingController companyPhoneController = TextEditingController();

  TextEditingController companyBranchNumController = TextEditingController();

  TextEditingController companyAboutController = TextEditingController();

  TextEditingController companyAddressController = TextEditingController();

  TextEditingController companyTypeController = TextEditingController();

  TextEditingController companyRegisterNumController = TextEditingController();

  GlobalKey<FormState> myForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCompanyCubit, ProfileCompanyState>(
      listener: (context, state) {
        if (state is SuccessUpdateCompanyProfile) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => NavigationDrawerCompany()));
        }
      },
      child: Scaffold(
        backgroundColor: ColorManager.WhiteScreen,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorManager.WhiteScreen,
          toolbarHeight: 80,
          leadingWidth: 30,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black54,
                size: 28,
              ),
            ),
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          ),
          centerTitle: false,
          title: Text(
            "Edit Company Profile",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Form(
          key: myForm,
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  child: CustomIAddLogoCompanies(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: CustomTxtFieldCompanyProfile(
                    controller: companyTypeController,
                    validator: (String? v) {
                      if (v!.isEmpty) {
                        return "You must enter the type of your company";
                      }
                      return null;
                    },
                    hint: "change Type",
                    title: "Company Type",
                    width: 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: CustomTxtFieldCompanyProfile(
                    controller: companyNameController,
                    validator: (String? v) {
                      if (v!.isEmpty) {
                        return "You must enter the name of your company";
                      }
                      return null;
                    },
                    hint: "Change Name",
                    title: "Company Name",
                    width: 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: CustomTxtFieldCompanyProfile(
                    controller: companyRegisterNumController,
                    validator: (String? v) {
                      if (v!.isEmpty) {
                        return "You must enter Your Registration Number";
                      }
                      return null;
                    },
                    hint: "Number",
                    title: "Registration Number",
                    width: sizeFromWidth(2.4),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: BlocBuilder<CommonCubit, CommonState>(
                    builder: (context, state) {
                      var cubit = CommonCubit.get(context);
                      return Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomSelectListRegister(
                                myList: cubit.countryData == null
                                    ? []
                                    : cubit.countryData,
                                title: "Country",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: CustomSelectListCities(
                                myList: cubit.cityData == null
                                    ? []
                                    : cubit.cityData,
                                title: "City",
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: CustomTxtFieldCompanyProfile(
                    width: 0,
                    hint: "Change Address",
                    title: "Address",
                    controller: companyAddressController,
                    validator: (String? v) {
                      if (v!.isEmpty) {
                        return "You must enter correct Address";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: CustomTxtFieldCompanyProfile(
                    controller: companyBranchNumController,
                    validator: (String? v) {},
                    hint: "number",
                    title: "Number Of branches",
                    width: 0,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: CustomTxtFieldComplexNumber(
                      controller: companyPhoneController,
                      validator: (String? v) {
                        if (v!.isEmpty || v.length < 8) {
                          return "You must enter correct phone Number";
                        }
                        return null;
                      },
                      title: 'Phone Number',
                      hint: "1011153207",
                    )),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: CustomTxtFieldAboutCompany(
                    controller: companyAboutController,
                    validator: (String? v) {
                      if (v!.isEmpty || v.length < 8) {
                        return "You must enter some Information About Your Company";
                      }
                      return null;
                    },
                    hint: "some details about company",
                    title: "About Company",
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                NavigationDrawerCompany(),
                          ),
                        );
                      },
                      child: BlocConsumer<ProfileCompanyCubit,
                          ProfileCompanyState>(
                        listener: (context, state) {
                          // TODO: implement listener
                        },
                        builder: (context, state) {
                          var cubit = ProfileCompanyCubit.get(context);
                          return state is LoadingpdateCompanyProfile
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : InkWell(
                                  onTap: () async {
                                    if (myForm.currentState!.validate()) {
                                      cubit.UpddateProfileCompany(
                                        about: companyAboutController.text,
                                        address: companyAddressController.text,
                                        branchNum:
                                            companyBranchNumController.text,
                                        registerNum:
                                            companyRegisterNumController.text,
                                        type: companyTypeController.text,
                                        phone: companyPhoneController.text,
                                        name: companyNameController.text,
                                        cityId: await CommonCubit.get(context)
                                            .cityIndex
                                            .toString(),
                                        countryId:
                                            await CommonCubit.get(context)
                                                .valueCountryId
                                                .toString(),
                                      );
                                    } else {
                                      print("Error In Register");
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.OnBoardingScreen,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color:
                                              ColorManager.AppBarIconcolorGrey
                                                  .withOpacity(0.08),
                                        )),
                                    child: Center(
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    height: sizeFromHeight(12),
                                    width: double.infinity,
                                  ),
                                );
                        },
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomIAddLogoCompanies extends StatefulWidget {
  @override
  State<CustomIAddLogoCompanies> createState() =>
      _CustomIAddLogoCompaniesState();
}

class _CustomIAddLogoCompaniesState extends State<CustomIAddLogoCompanies> {
  File? image;

  Future ImagePick() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: "${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCompanyCubit, ProfileCompanyState>(
      builder: (context, state) {
        var cubit = ProfileCompanyCubit.get(context);

        return InkWell(
          onTap: () => ImagePick().then((value) {
            image != null
                ? cubit.changeImageData(imageFile: image)
                : debugPrint("Image Null data");
          }),
          child: Container(
            height: sizeFromHeight(8),
            width: 327.w,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        sizeFromWidth(11),
                      ),
                      border: image != null
                          ? null
                          : Border.all(
                              color: ColorManager.onboardingColorDots)),
                  child: image != null
                      ? CircleAvatar(
                          radius: sizeFromWidth(12),
                          backgroundColor: ColorManager.WhiteScreen,
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ))
                      : CircleAvatar(
                          radius: sizeFromWidth(12),
                          backgroundColor: ColorManager.WhiteScreen,
                          child: image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  "assets/images/upimage.svg",
                                )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Icon(Icons.add),
                ),
                Text(
                  "Upload Company Logo",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomTxtFieldCompanyProfile extends StatelessWidget {
  String hint;
  String title;
  double width;
  String? Function(String?)? validator;
  TextEditingController controller;

  CustomTxtFieldCompanyProfile({
    required this.title,
    required this.hint,
    required this.width,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(7),
      width: width == 0 ? double.infinity : width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              ),
            ),
          ),
          Container(
            height: sizeFromHeight(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08)),
              color: ColorManager.CompareConatainer,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: TextFormField(
                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                    hintText: "${hint}",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTxtFieldSuffixIcon extends StatelessWidget {
  String hint;
  String title;

  CustomTxtFieldSuffixIcon({required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Container(
            height: sizeFromHeight(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "${hint}",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FaIcon(FontAwesomeIcons.link),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSelectListProfile extends StatelessWidget {
  String title = "";
  double width;

  CustomSelectListProfile(
    this.width,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(7),
      width: width == 0 ? double.infinity : width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
          Container(
            height: sizeFromHeight(12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08)),
              color: ColorManager.CompareConatainer,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: SizedBox(),
                hint: Text("Select"),
                items: <String>['1', '2', '3'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTxtFieldSocialCompany extends StatelessWidget {
  String hint;
  String title;

  CustomTxtFieldSocialCompany({required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Container(
            height: sizeFromHeight(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ColorManager.CompareConatainer,
                border: Border.all(
                    color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08))),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "${hint}",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FaIcon(FontAwesomeIcons.link),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTxtFieldAboutCompany extends StatelessWidget {
  String hint;
  String title;
  TextEditingController controller;
  String? Function(String?)? validator;

  CustomTxtFieldAboutCompany({
    required this.title,
    required this.hint,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(5.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08)),
              color: ColorManager.CompareConatainer,
            ),
            height: 100,
            child: TextFormField(
              controller: controller,
              validator: validator,
              decoration: InputDecoration(
                hintText: "$hint",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTxtFieldComplexNumber extends StatelessWidget {
  String hint;
  String title;
  String? Function(String?)? validator;
  TextEditingController controller;

  CustomTxtFieldComplexNumber({
    required this.title,
    required this.hint,
    required this.validator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(8.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Container(
            height: sizeFromHeight(12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: ColorManager.CompareConatainer,
                border: Border.all(
                    color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08))),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "+20",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.only(top: 15),
                      child: TextFormField(
                        validator: validator,
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: "${hint}",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
