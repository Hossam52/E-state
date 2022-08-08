import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/dataLayer/dataModel/projectsOfCompany/ProjectsofCompany.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/view.dart';
import 'package:osol/User/PresentaionLayer/compniesScreen/units.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';
import 'package:osol/common_models/unit_model.dart';
import 'package:readmore/readmore.dart';

import '../../BussinssLogic/authCubit/auth_cubit.dart';
import '../../BussinssLogic/homeCubit/home_cubit.dart';

class CompanyDetailsScreen extends StatefulWidget {
  final String companyId;

  const CompanyDetailsScreen({Key? key, required this.companyId})
      : super(key: key);
  @override
  State<CompanyDetailsScreen> createState() => _CompanyDetailsScreenState();
}

class _CompanyDetailsScreenState extends State<CompanyDetailsScreen> {
  List<HomeScreenSliderModel> unitDetails = [
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "50%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "70%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "60%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "20%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "60%"),
  ];

  void initState() {
    // CompanyCubit.get(context).zeroId();
    // CompanyCubit.get(context).dataOfCompanyReview.clear();
    // super.initState();
    // CompanyCubit.get(context).getCompanyById();
    // AuthCubit.get(context).userToken == null &&
    //         HomeCubit.get(context).token == null
    //     ? null
    //     : CompanyCubit.get(context).getReviewsForDetectedCompany();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CompanyCubit(companyId: widget.companyId)..loadCompany(),
      child: BlocBuilder<CompanyCubit, CompanyState>(
        builder: (context, state) {
          var cubit = CompanyCubit.get(context);
          return Scaffold(
            appBar: state is LoadingGetDetectedCompany
                ? null
                : AppBar(
                    elevation: 0,
                    toolbarHeight: 80,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    ),
                    shape: const ContinuousRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10)),
                    ),
                    centerTitle: true,
                    title: Text(
                      "${cubit.company!.name}",
                    ),
                  ),
            body: state is ErrorGetDetectedCompany
                ? CupertinoAlertDialog(
                    title: const Text(
                      "Error On Get Data try again letter",
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Ok"))
                    ],
                  )
                : state is LoadingGetDetectedCompany
                    ? const Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.blue,
                        ),
                      )
                    : CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15, left: 20),
                              child: SizedBox(
                                height: sizeFromHeight(3.5),
                                width: sizeFromWidth(1.5),
                                child: ListViewCmpanyDetails(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      cubit.company!.image.toString(),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  txt: cubit.company!.name.toString(),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 5),
                              child: CustomIInformationCompanies(
                                companyName: cubit.company!.name.toString(),
                                creationDate: cubit.company!.date.toString(),
                                img: '${cubit.company!.image}',
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 20,
                              ),
                              child: CustomdetailsOfCompanies(
                                about: cubit.company!.about.toString(),
                                companyType: cubit.company!.type.toString(),
                                email: cubit.company!.email.toString(),
                                phone: cubit.company!.phone.toString(),
                                regiserNum:
                                    cubit.company!.regestrationNum.toString(),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: CustomDescriptionCompanies(
                              phone: cubit.company!.phone.toString(),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: CustomAboutDeveloperCompanies(
                              branches: cubit.company!.branchesNum.toString(),
                            ),
                          ),
                          cubit.company!.myBranches!.isEmpty
                              ? const SliverToBoxAdapter()
                              : SliverToBoxAdapter(
                                  child: SizedBox(
                                    height: sizeFromHeight(5),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 18.0),
                                      child: SizedBox(
                                        height: sizeFromHeight(5),
                                        width: sizeFromWidth(1),
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: cubit
                                                .company!.myBranches?.length,
                                            itemBuilder: (context, index) {
                                              return HorizontalScrollBranches(
                                                companyId: cubit.company!
                                                    .myBranches![index].id
                                                    .toString(),
                                                index: index,
                                                img: cubit.company!
                                                    .myBranches![index].image
                                                    .toString(),
                                                city: cubit.company!
                                                    .myBranches![index].city
                                                    .toString(),
                                                country: cubit.company!
                                                    .myBranches![index].country
                                                    .toString(),
                                                branchName: cubit.company!
                                                    .myBranches![index].name
                                                    .toString(),
                                              );
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                          const SliverToBoxAdapter(
                            child: CompanyProjectsText(),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: SizedBox(
                                height: sizeFromHeight(3),
                                width: sizeFromWidth(1),
                                child: cubit.isProjectsLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : cubit.projects.isEmpty
                                        ? const _CustomText(text: 'No Projects')
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: cubit.projects.length,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 10,
                                                ),
                                                child: CompanyProjects(
                                                    project:
                                                        cubit.projects[index]),
                                              );
                                            }),
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: CompanyListingText(),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: SizedBox(
                                height: sizeFromHeight(5),
                                width: sizeFromWidth(1),
                                child: cubit.isUnitsLoading
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : cubit.units.isEmpty
                                        ? const _CustomText(text: 'No Units')
                                        : ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            itemCount: cubit.units.length,
                                            itemBuilder: (context, index) {
                                              return CompanyUnitItem(
                                                unit: cubit.units[index],
                                              );
                                            }),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: CustomReviewCompanies(),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: CustomWriteReviewCompanies(),
                            ),
                          ),
                        ],
                      ),
          );
        },
      ),
    );
  }
}

class _CustomText extends StatelessWidget {
  const _CustomText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class CompanyUnitItem extends StatelessWidget {
  const CompanyUnitItem({
    Key? key,
    required this.unit,
  }) : super(key: key);
  final UnitModel unit;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => UnitsDetailsScreen(unitId: unit.id!),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 5,
          child: SizedBox(
              width: sizeFromWidth(1.2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: 80.w,
                          decoration: const BoxDecoration(),
                          child: CachedNetworkImage(
                              imageUrl: unit.images!.first,
                              height: double.infinity,
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${unit.type}',
                                // "Duplex Appartment",
                                style: TextStyle(
                                  color: ColorManager.TextHomeColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: Colors.red,
                                      width: 1,
                                    )),
                                child: FaIcon(
                                  unit.authFavourite!
                                      ? FontAwesomeIcons.solidHeart
                                      : FontAwesomeIcons.heart,
                                  color: Colors.red,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 130.w,
                            child: Row(
                              children: [
                                Icon(
                                  OsolIcon.location,
                                  color: ColorManager.AppBarIconcolorGrey,
                                  size: 9.w,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  '${unit.city} , ${unit.country}',
                                  style: TextStyle(fontSize: 9.sp),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: unit.price?.toString() ?? 'N/A',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: ColorManager.OnBoardingScreen),
                            ),
                            const TextSpan(
                              text: "\ Mnth",
                              style: TextStyle(
                                  fontSize: 9, color: Colors.lightBlueAccent),
                            )
                          ])),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "3.4 static",
                                style: TextStyle(
                                    color: ColorManager.TextHomeColor,
                                    fontSize: 9),
                              ),
                              FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: ColorManager.starColor,
                                size: 9,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FaIcon(
                                  OsolIcon.square_,
                                  color: Colors.grey[400],
                                  size: 10,
                                ),
                                Text(
                                  "${unit.area} m²",
                                  style: TextStyle(
                                      color: ColorManager.TextHomeColor,
                                      fontSize: 10),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.bath,
                                  color: Colors.grey[400],
                                  size: 10,
                                ),
                                Text(
                                  "${unit.bathroom}",
                                  style: TextStyle(
                                      color: ColorManager.TextHomeColor,
                                      fontSize: 10),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                FaIcon(
                                  FontAwesomeIcons.bed,
                                  size: 10,
                                  color: Colors.grey[400],
                                ),
                                Text(
                                  "${unit.bedrooms}",
                                  style: TextStyle(
                                      color: ColorManager.TextHomeColor,
                                      fontSize: 10),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class CompanyListingText extends StatelessWidget {
  const CompanyListingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: sizeFromHeight(15),
        width: sizeFromWidth(1.5),
        child: const Padding(
          padding: EdgeInsets.only(
            top: 10,
          ),
          child: Text(
            "Company listing",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class CompanyProjectsText extends StatelessWidget {
  const CompanyProjectsText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: sizeFromHeight(14),
        width: sizeFromWidth(1.5),
        child: const Padding(
          padding: EdgeInsets.only(
            top: 15,
          ),
          child: Text(
            "Company projects",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class HorizontalScrollBranches extends StatelessWidget {
  String companyId;
  String city;
  String country;
  String branchName;
  String img;
  int index;

  HorizontalScrollBranches({
    Key? key,
    required this.companyId,
    required this.img,
    required this.country,
    required this.city,
    required this.branchName,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CompanyCubit.get(context).changeNextCompanyId(CompanyCubit.get(context)
            .company!
            .myBranches![index]
            .id
            .toString());
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CompanyDetailsScreen(
              companyId: companyId,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 5,
          child: SizedBox(
              width: sizeFromWidth(1.2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5.0, vertical: 5),
                      child: Container(
                        width: 80.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("$img"), fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$branchName",
                                style: TextStyle(
                                  color: ColorManager.TextHomeColor,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  Icon(
                                    OsolIcon.location,
                                    color: ColorManager.redHeartcolor,
                                    size: 10.w,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "$city , $country",
                                    style: TextStyle(fontSize: 10.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Row(
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.clock,
                                    size: 10.w,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "9 AM To 12 Pm ",
                                    style: TextStyle(fontSize: 10.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Container(
                            height: sizeFromHeight(19),
                            width: sizeFromWidth(2.5),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: SvgPicture.asset(
                                        "assets/images/map.svg"),
                                  ),
                                  Text(
                                    "Go to Location",
                                    style: TextStyle(
                                        color: ColorManager.TextHomeColor,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

class CompanyProjects extends StatelessWidget {
  const CompanyProjects({Key? key, required this.project}) : super(key: key);
  final DataOfProjects project;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sizeFromWidth(1.2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              height: sizeFromHeight(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: project.image!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Text(
              project.title!,
              style: TextStyle(
                  color: ColorManager.TextHomeColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(
                  OsolIcon.location,
                  color: ColorManager.redHeartcolor,
                  size: 16,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  '${project.city} , ${project.country}',
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
