import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/updateCompanyProfile/updateCompanyProfile.dart';
import 'package:osol/Company/businessLogicLayer/profilecompanyCubit/profile_company_cubit.dart';
import 'package:osol/Shared/constants.dart';

class CompanyProfileScreen extends StatefulWidget {
  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  TextEditingController companyTypeController = TextEditingController();

  TextEditingController companyEmailController = TextEditingController();

  TextEditingController companyNameController = TextEditingController();

  TextEditingController companyRegisterNumberController =
      TextEditingController();

  TextEditingController companyAddressController = TextEditingController();

  initState() {
    ProfileCompanyCubit.get(context).getProfileCompany();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCompanyCubit, ProfileCompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProfileCompanyCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.WhiteScreen,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorManager.WhiteScreen,
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black54,
                size: 28,
              ),
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            centerTitle: true,
            title: Text(
              "Profile",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          body: state is LoadingGetProfileDataStatus
              ? Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 5),
                        child: CustomIInformationCompanies(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: CustomLabelCompanyProfile(
                          text: "${cubit.type}",
                          width: 0,
                          hint: "Change Type",
                          title: "Company type",
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: CustomLabelCompanyProfile(
                          text: "${cubit.name}",
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
                        child: CustomLabelCompanyProfile(
                          hint: "Change Email",
                          title: "Email",
                          width: 0,
                          text: "${cubit.email}",
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomLabelCompanyProfile(
                              text: "${cubit.branchesNum}",
                              hint: "Number",
                              title: "Number of branches",
                              width: sizeFromWidth(2.4),
                            ),
                            CustomLabelCompanyProfile(
                              text: "${cubit.regestrationNum}",
                              hint: "Number",
                              title: "Registration Number",
                              width: sizeFromWidth(2.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: CustomLabelCompanyProfile(
                          text: "${cubit.country} / ${cubit.city}",
                          hint: "Number",
                          title: "Country / Region",
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
                        child: CustomLabelCompanyProfile(
                          width: 0,
                          hint: "Change Address",
                          title: "Address",
                          text: "${cubit.address}",
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: CustomLabelCompanyProfile(
                          text: "${cubit.phone}",
                          hint: "Phone Number",
                          title: "Phone Number",
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
                        child: CustomLabelCompanyProfile(
                          text: "www.facebookcom/5050",
                          hint: "Phone Number",
                          title: "Social Account",
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
                        child: CustomTxtFieldAboutCompany(
                          text: "${cubit.about}",
                          hint: "some details about company",
                          title: "About Company",
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class CustomIInformationCompanies extends StatelessWidget {
  const CustomIInformationCompanies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCompanyCubit, ProfileCompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProfileCompanyCubit.get(context);
        return Container(
          height: sizeFromHeight(8),
          width: 327.w,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      sizeFromWidth(11),
                    ),
                    border:
                        Border.all(color: ColorManager.onboardingColorDots)),
                child: CircleAvatar(
                  radius: sizeFromWidth(12),
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                    "${cubit.image}",
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14.0, horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${cubit.name}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${cubit.regestrationNum}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorManager.WhiteScreen,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => UpdateCompanyScreen()));
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.pen,
                      color: ColorManager.onboardingColorDots,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ],
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
  TextEditingController controller;

  CustomTxtFieldCompanyProfile(
      {required this.controller,
      required this.title,
      required this.hint,
      required this.width});

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
  String text;

  CustomTxtFieldAboutCompany({
    required this.title,
    required this.hint,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6),
      width: double.infinity,
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
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08)),
              color: ColorManager.CompareConatainer,
            ),
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "$text",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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

  CustomTxtFieldComplexNumber({required this.title, required this.hint});

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

class CustomLabelCompanyProfile extends StatelessWidget {
  String hint;
  String title;
  double width;
  String text;

  CustomLabelCompanyProfile(
      {required this.text,
      required this.title,
      required this.hint,
      required this.width});

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
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: ColorManager.AppBarIconcolorGrey.withOpacity(0.08)),
              color: ColorManager.CompareConatainer.withOpacity(0.5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
              child: Text(
                "$text",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
