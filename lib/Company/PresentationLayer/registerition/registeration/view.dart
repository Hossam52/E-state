import 'dart:developer';
import 'dart:io';

import 'package:flrx_validator/flrx_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/businessLogicLayer/authCompany/auth_company_cubit.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CompanyRegisterationScreen extends StatefulWidget {
  const CompanyRegisterationScreen({Key? key}) : super(key: key);

  @override
  State<CompanyRegisterationScreen> createState() =>
      _CompanyRegisterationScreenState();
}

class _CompanyRegisterationScreenState
    extends State<CompanyRegisterationScreen> {
  TextEditingController companyNameController = TextEditingController();

  TextEditingController companyEmailController = TextEditingController();

  TextEditingController companyPassController = TextEditingController();

  TextEditingController companyConPassController = TextEditingController();

  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  TextEditingController companyBranchNumController = TextEditingController();

  TextEditingController companyAboutController = TextEditingController();

  TextEditingController companyAddressController = TextEditingController();

  TextEditingController companyTypeController = TextEditingController();

  TextEditingController companyRegisterNumController = TextEditingController();

  GlobalKey<FormState> myForm = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    companyNameController.dispose();
    companyEmailController.dispose();
    companyPassController.dispose();
    companyConPassController.dispose();

    companyPhoneController.dispose();
    countryController.dispose();
    companyBranchNumController.dispose();
    companyAboutController.dispose();
    companyAddressController.dispose();
    companyAddressController.dispose();
    companyTypeController.dispose();
    companyRegisterNumController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        leadingWidth: 30,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black54,
              size: 28,
            ),
          ),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        centerTitle: false,
        title: const Text(
          "Company Register",
        ),
      ),
      body: Form(
        key: myForm,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
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
                  validator: Validator(rules: [
                    RequiredRule(
                        validationMessage:
                            "You must enter the type of your company"),
                  ]),
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
                  validator: Validator(rules: [
                    RequiredRule(
                        validationMessage:
                            "You must enter the name of your company"),
                  ]),
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
                  validator: Validator(rules: [
                    EmailRule(),
                  ]),
                  controller: companyEmailController,
                  hint: "Change Email",
                  title: "Email",
                  width: 0,
                  textInputType: TextInputType.emailAddress,
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
                  obSecure: true,
                  controller: companyPassController,
                  validator: Validator(rules: [
                    RequiredRule(
                        validationMessage: "You must enter correct Password"),
                    MinLengthRule(8,
                        validationMessage: "You must enter correct Password")
                  ]),
                  hint: "Enter Your Password",
                  title: "Password",
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
                  obSecure: true,
                  controller: companyConPassController,
                  validator: Validator(rules: [
                    RequiredRule(
                        validationMessage: "You must enter correct Password"),
                    MinLengthRule(8,
                        validationMessage: "You must enter correct Password")
                  ]),
                  hint: "Enter Your confirm Password",
                  title: "confirm Password",
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputType: TextInputType.number,
                  controller: companyRegisterNumController,
                  validator: Validator(rules: [
                    RequiredRule(
                        validationMessage:
                            "You must enter Your Registration Number"),
                  ]),
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomSelectListRegister(
                              myList: cubit.countryData,
                              title: "Country",
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: CustomSelectListCities(
                              myList: cubit.cityData,
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
                  validator: Validator(rules: [
                    RequiredRule(
                        validationMessage: "You must enter correct Address"),
                  ]),
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
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  textInputType: TextInputType.number,
                  controller: companyBranchNumController,
                  validator: (String? v) {
                    return null;
                  },
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textInputType: TextInputType.number,
                    countryController: countryController,
                    controller: companyPhoneController,
                    validator: Validator(rules: [
                      RequiredRule(
                          validationMessage:
                              "You must enter correct phone Number"),
                      MinLengthRule(8,
                          validationMessage:
                              "You must enter correct phone Number")
                    ]),
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
                  validator: Validator(rules: [
                    RequiredRule(
                        validationMessage:
                            "You must enter some Information About Your Company"),
                    MinLengthRule(8,
                        validationMessage:
                            "You must enter some Information About Your Company")
                  ]),
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
                              const NavigationDrawerCompany(),
                        ),
                      );
                    },
                    child: BlocConsumer<AuthCompanyCubit, AuthCompanyState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        var cubit = AuthCompanyCubit.get(context);
                        return state is LoadingRegisterCompanyState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : InkWell(
                                onTap: () async {
                                  cubit.emailRegister =
                                      companyEmailController.text;
                                  if (myForm.currentState!.validate()) {
                                    cubit.registerAsCompany(
                                      context: context,
                                      email: companyEmailController.text,
                                      about: companyAboutController.text,
                                      address: companyAddressController.text,
                                      branchNum:
                                          companyBranchNumController.text,
                                      registerationNum:
                                          companyRegisterNumController.text,
                                      type: companyTypeController.text,
                                      phone: companyPhoneController.text,
                                      countryCode: countryController.text,
                                      name: companyNameController.text,
                                      password: companyPassController.text,
                                      confirmPassword:
                                          companyConPassController.text,
                                      cityId: CommonCubit.get(context)
                                          .cityIndex
                                          .toString(),
                                      countryId: CommonCubit.get(context)
                                          .valueCountryId,
                                    );
                                  } else {
                                    log("Error In Register");
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: ColorManager.OnBoardingScreen,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ColorManager.AppBarIconcolorGrey
                                            .withOpacity(0.08),
                                      )),
                                  child: const Center(
                                    child: Text(
                                      "Register",
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
    );
  }
}

class CustomIAddLogoCompanies extends StatefulWidget {
  const CustomIAddLogoCompanies({Key? key}) : super(key: key);

  @override
  State<CustomIAddLogoCompanies> createState() =>
      _CustomIAddLogoCompaniesState();
}

class _CustomIAddLogoCompaniesState extends State<CustomIAddLogoCompanies> {
  File? image;

  Future ImagePick(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
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
    return BlocBuilder<AuthCompanyCubit, AuthCompanyState>(
      builder: (context, state) {
        var cubit = AuthCompanyCubit.get(context);

        return InkWell(
          onTap: () => ImagePick(context).then((value) {
            image != null
                ? cubit.changeImageData(imageFile: image)
                : debugPrint("Image Null data");
          }),
          child: SizedBox(
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
                          foregroundImage: FileImage(
                            image!,
                          ))
                      : CircleAvatar(
                          radius: sizeFromWidth(12),
                          child: image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  "assets/images/upimage.svg",
                                )),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Icon(Icons.add),
                ),
                const Text(
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
  final String hint;
  final String title;
  final double width;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final bool obSecure;

  final List<TextInputFormatter>? inputFormatters;
  const CustomTxtFieldCompanyProfile({
    Key? key,
    required this.title,
    required this.hint,
    required this.width,
    required this.validator,
    this.textInputType,
    this.obSecure = false,
    this.inputFormatters,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
              child: Text(
                title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
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
                obscureText: obSecure,
                inputFormatters: inputFormatters,
                keyboardType: textInputType,
                controller: controller,
                validator: validator,
                decoration: InputDecoration(
                    hintText: hint,
                    border: const OutlineInputBorder(
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
    return SizedBox(
      height: sizeFromHeight(5.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
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
                hintText: hint,
                border: const OutlineInputBorder(
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
  final String hint;
  final String title;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextEditingController countryController;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTxtFieldComplexNumber({
    Key? key,
    required this.title,
    required this.hint,
    required this.validator,
    required this.countryController,
    required this.controller,
    this.textInputType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeFromHeight(8.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
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
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        inputFormatters: inputFormatters,
                        keyboardType: textInputType,
                        controller: countryController,
                        decoration: const InputDecoration(
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
                      padding: const EdgeInsets.only(top: 15),
                      child: TextFormField(
                        inputFormatters: inputFormatters,
                        keyboardType: textInputType,
                        validator: validator,
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: hint,
                            border: const OutlineInputBorder(
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
// class CustomTxtFieldSocialCompany extends StatelessWidget {
//   String hint;
//   String title;
//
//   CustomTxtFieldSocialCompany({required this.title, required this.hint});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: sizeFromHeight(7),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//                 color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
//           ),
//           Container(
//             height: sizeFromHeight(12),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(6),
//                 color: ColorManager.CompareConatainer,
//                 border: Border.all(
//                     color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08))),
//             child: Center(
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     hintText: hint,
//                     suffixIcon: const Padding(
//                       padding: EdgeInsets.only(top: 8.0),
//                       child: FaIcon(FontAwesomeIcons.link),
//                     ),
//                     border: const OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                     )),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class CustomTxtFieldSuffixIcon extends StatelessWidget {
//   String hint;
//   String title;
//
//   CustomTxtFieldSuffixIcon({required this.title, required this.hint});
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: sizeFromHeight(6.5),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//                 color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
//           ),
//           Container(
//             height: sizeFromHeight(10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               color: ColorManager.CompareConatainer,
//             ),
//             child: Center(
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     hintText: hint,
//                     suffixIcon: const Padding(
//                       padding: EdgeInsets.only(top: 8.0),
//                       child: FaIcon(FontAwesomeIcons.link),
//                     ),
//                     border: const OutlineInputBorder(
//                       borderSide: BorderSide.none,
//                     )),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class CustomSelectListProfile extends StatelessWidget {
//   String title = "";
//   double width;
//
//   CustomSelectListProfile(
//       this.width,
//       this.title,
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: sizeFromHeight(7),
//       width: width == 0 ? double.infinity : width,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16),
//               ),
//             ],
//           ),
//           Container(
//             height: sizeFromHeight(12),
//             width: double.infinity,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               border: Border.all(
//                   color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08)),
//               color: ColorManager.CompareConatainer,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 8.0,
//               ),
//               child: DropdownButton<String>(
//                 isExpanded: true,
//                 underline: const SizedBox(),
//                 hint: const Text("Select"),
//                 items: <String>['1', '2', '3'].map((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//                 onChanged: (_) {},
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
