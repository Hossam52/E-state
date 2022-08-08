import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/authCubit/auth_cubit.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/countryModel/modelOfData.dart';

class SignUpView extends StatefulWidget {
  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController conPassController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  GlobalKey<FormState> myForm = GlobalKey();

  var cityIndex;
  var countryIndex;
  var gendrValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.onboardingColorDots,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorManager.onboardingColorDots,
        toolbarHeight: 80,
        leadingWidth: 30,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        centerTitle: false,
        title: Text(
          "Personal Register",
        ),
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 4.0,
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          // InkWell(
          //   onTap:()=> Navigator.pop(context),
          //   child: Padding(
          //     padding: const EdgeInsets.all(5.0),
          //     child: Container(
          //       child: Row(
          //         children: [
          //           Text(
          //             "Skip",
          //             style: TextStyle(
          //               color: ColorManager.WhiteScreen,
          //             ),
          //           ),
          //           Icon(
          //             Icons.arrow_forward_ios,
          //             color: ColorManager.WhiteScreen,
          //             size: 22,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: sizeFromHeight(4),
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage("assets/images/estatehomee.png"),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: sizeFromHeight(0.7),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorManager.WhiteScreen,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: myForm,
                    child: Column(
                      children: [
                        CustomTxtEditing(
                          hint: "User Name",
                          controller: nameController,
                          validate: (String? v) {
                            if (v!.isEmpty) {
                              return "Enter Your Name";
                            }
                            return null;
                          },
                          txtInputType: TextInputType.name,
                          suffixIcon: null,
                          obscure: false,
                        ),
                        CustomTxtEditing(
                          hint: "Email",
                          controller: emailController,
                          validate: (String? v) {
                            if (!v!.contains("@") || v.isEmpty) {
                              return "Enter Correct Email";
                            }
                            return null;
                          },
                          txtInputType: TextInputType.emailAddress,
                          suffixIcon: null,
                          obscure: false,
                        ),
                        CustomTxtEditing(
                          hint: "Password",
                          controller: passController,
                          validate: (String? v) {
                            if ((v!.length < 8) || v.isEmpty) {
                              return "Password should contain more than 7 characters";
                            }
                            return null;
                          },
                          txtInputType: TextInputType.visiblePassword,
                          obscure: false,
                          suffixIcon: null,
                        ),
                        CustomTxtEditing(
                          hint: "Confirm Password",
                          controller: conPassController,
                          validate: (String? v) {
                            if ((v!.length < 8) || v.isEmpty) {
                              if (v != passController.text || v.isEmpty) {
                                return " this field should typically equal password";
                              }
                              return "Password should contain more than 7 characters";
                            }
                            return null;
                          },
                          txtInputType: TextInputType.visiblePassword,
                          suffixIcon: null,
                          obscure: false,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8),
                          child: CustomSelectListGender(
                            title: "Gender",
                            myList: ["Male", "Female"],
                          ),
                        ),
                        BlocBuilder<CommonCubit, CommonState>(
                          builder: (context, state) {
                            var cubit = CommonCubit.get(context);
                            return Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
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
                        CustomTxtEditing(
                          hint: "Phone Number",
                          controller: phoneController,
                          validate: (String? v) {
                            if (v!.isEmpty) {
                              return "Enter valid phone number";
                            }
                            return null;
                          },
                          txtInputType: TextInputType.number,
                          suffixIcon: null,
                          obscure: false,
                        ),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            var cubit = AuthCubit.get(context);
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: state is LoadingRegisterUserState
                                    ? CircularProgressIndicator()
                                    : ElevatedButton(
                                        onPressed: () async {
                                          cubit.emailRegister =
                                              emailController.text;
                                          if (myForm.currentState!.validate()) {
                                            cubit.registerAsUser(
                                              context: context,
                                              email: emailController.text,
                                              phone: phoneController.text,
                                              name: nameController.text,
                                              password: passController.text,
                                              confirmPassword:
                                                  conPassController.text,
                                              gender: gendrValue == "Male"
                                                  ? "0"
                                                  : "1",
                                              cityId:
                                                  await CommonCubit.get(context)
                                                      .cityIndex
                                                      .toString(),
                                              countryId:
                                                  CommonCubit.get(context)
                                                      .valueCountryId,
                                            );
                                          } else {
                                            print("Error In Register");
                                          }
                                        },
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          minimumSize:
                                              Size(double.infinity, 50),
                                          primary:
                                              ColorManager.onboardingColorDots,
                                        ),
                                      ));
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text("OR"),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                child: FaIcon(
                                  FontAwesomeIcons.twitter,
                                  color: ColorManager.WhiteScreen,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                child: SvgPicture.asset(
                                  "assets/images/google.svg",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: ColorManager.circleFB,
                                child: FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  color: ColorManager.WhiteScreen,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 5,
                                width: sizeFromWidth(2),
                                decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTxtEditing extends StatefulWidget {
  TextEditingController controller;
  String hint;
  TextInputType txtInputType;
  String? Function(String?) validate;
  bool obscure = false;
  IconButton? suffixIcon;

  CustomTxtEditing({
    required this.obscure,
    required this.suffixIcon,
    required this.controller,
    required this.hint,
    required this.txtInputType,
    required this.validate,
  });

  @override
  State<CustomTxtEditing> createState() => _CustomTxtEditingState();
}

class _CustomTxtEditingState extends State<CustomTxtEditing> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.CompareConatainer,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextFormField(
          toolbarOptions: ToolbarOptions(
            paste: true,
            selectAll: true,
            copy: true,
            cut: true,
          ),
          controller: widget.controller,
          obscureText: widget.obscure,
          decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              hintText: widget.hint,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              )),
          validator: widget.validate,
        ),
      ),
    );
  }
}

class CustomSelectListRegister extends StatelessWidget {
  String title = "";
  List myList;

  CustomSelectListRegister({
    required this.myList,
    required this.title,
  });

  Countries? dropDownMenuCountry;
  int? countryId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CommonCubit.get(context);
        return Container(
          height: sizeFromHeight(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.CompareConatainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8,
            ),
            child: DropdownButton(
              isExpanded: true,
              value: cubit.dropDownCountryValue,
              underline: SizedBox(),
              hint: Text("${title}"),
              items: myList.map((dynamic value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (dynamic value) {
                cubit.changeCountryValue(value);
                print(value);
                dropDownMenuCountry = value;
                cubit.newValue = null;
                cubit.selectedCountry = value.id;
                cubit.city = value.cities;
                cubit.getCityData(value.id);
                cubit.valueCountryId = value.id;
                print(value.id);
                cubit.areasData.clear();
              },
            ),
          ),
        );
      },
    );
  }
}

class CustomSelectListCities extends StatelessWidget {
  String title = "";
  List<Cities> myList;

  CustomSelectListCities({
    required this.myList,
    required this.title,
  });

  String? dropDownMenuCities;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CommonCubit.get(context);
        return Container(
          height: sizeFromHeight(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.CompareConatainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8,
            ),
            child: DropdownButton<Cities>(
              isExpanded: true,
              value: cubit.newValue,
              underline: SizedBox(),
              hint: Text("${title}"),
              items: myList.map((Cities value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name!),
                );
              }).toList(),
              onChanged: (dynamic value) {
                cubit.areasData.clear();
                cubit.changeSelectedCites(value);
                cubit.cityIndex = value.id;
                value.areas.forEach((element) {
                  cubit.changeSelectedAreas(element);
                  cubit.changeSelectedAreasId(element.id);
                  cubit
                      .getAreaData(element.id)
                      .then((value) => print("${cubit.areasData}"));
                  print("id:${cubit.newAreasIdValue}");
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class CustomSelectListAreas extends StatelessWidget {
  String title = "";
  List<Cities> myList;

  CustomSelectListAreas({
    required this.myList,
    required this.title,
  });

  String? dropDownMenuCities;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CommonCubit.get(context);
        return Container(
          height: sizeFromHeight(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.CompareConatainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8,
            ),
            child: DropdownButton<Cities>(
              isExpanded: true,
              value: cubit.newValue,
              underline: SizedBox(),
              hint: Text("${title}"),
              items: myList.map((Cities value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name!),
                );
              }).toList(),
              onChanged: (value) {
                cubit.changeSelectedCites(value);
                cubit.cityIndex = value?.id;
              },
            ),
          ),
        );
      },
    );
  }
}

class CustomSelectListGender extends StatelessWidget {
  String title = "";
  List<String> myList;

  CustomSelectListGender({
    required this.myList,
    required this.title,
  });

  String? dropDownMenuCities;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Container(
          height: sizeFromHeight(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.CompareConatainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8,
            ),
            child: DropdownButton<String>(
              isExpanded: true,
              value: cubit.genderValue,
              underline: SizedBox(),
              hint: Text("${title}"),
              items: myList.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                cubit.changeGenderValue(value);
                cubit.genderValue = value;
              },
            ),
          ),
        );
      },
    );
  }
}
