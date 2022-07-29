import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/view.dart';
import 'package:osol/User/PresentaionLayer/compniesScreen/units.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';
import 'package:readmore/readmore.dart';

import '../../BussinssLogic/authCubit/auth_cubit.dart';
import '../../BussinssLogic/homeCubit/home_cubit.dart';

class CompanyDetailsScreen extends StatefulWidget {
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
    CompanyCubit.get(context).zeroId();
    CompanyCubit.get(context).dataOfCompanyReview.clear();
    super.initState();
    CompanyCubit.get(context).getCompanyById();
    AuthCubit.get(context).userToken == null &&
            HomeCubit.get(context).token == null
        ? null
        : CompanyCubit.get(context).getReviewsForDetectedCompany();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        debugPrint("$state");
      },
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.WhiteScreen,
          appBar: state is! SuccessGetDetectedCompany ||
                  state is LoadingGetAllReviews
              ? null
              : AppBar(
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
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  centerTitle: true,
                  title: Text(
                    "${cubit.companyDetectedData[0].name}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
          body: state is ErrorGetDetectedCompany
              ? CupertinoAlertDialog(
                  title: Text(
                    "Error On Get Data try again letter",
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Ok"))
                  ],
                )
              : cubit.companyDetectedData.isEmpty
                  ? Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, bottom: 15, left: 20),
                            child: Container(
                              height: sizeFromHeight(3.5),
                              width: sizeFromWidth(1.5),
                              child: ListViewCmpanyDetails(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    cubit.companyDetectedData[0].image
                                        .toString(),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                txt: cubit.companyDetectedData[0].name
                                    .toString(),
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 5),
                            child: CustomIInformationCompanies(
                              companyName:
                                  cubit.companyDetectedData[0].name.toString(),
                              creationDate:
                                  cubit.companyDetectedData[0].date.toString(),
                              img: '${cubit.companyDetectedData[0].image}',
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
                              about:
                                  cubit.companyDetectedData[0].about.toString(),
                              companyType:
                                  cubit.companyDetectedData[0].type.toString(),
                              email:
                                  cubit.companyDetectedData[0].email.toString(),
                              phone:
                                  cubit.companyDetectedData[0].phone.toString(),
                              regiserNum: cubit
                                  .companyDetectedData[0].regestrationNum
                                  .toString(),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: CustomDescriptionCompanies(
                            phone:
                                cubit.companyDetectedData[0].phone.toString(),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: CustomAboutDeveloperCompanies(
                            branches: cubit.companyDetectedData[0].branchesNum
                                .toString(),
                          ),
                        ),
                        cubit.companyDetectedData[0].myBranches!.isEmpty
                            ? SliverToBoxAdapter()
                            : SliverToBoxAdapter(
                                child: Container(
                                  height: sizeFromHeight(5),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                      height: sizeFromHeight(5),
                                      width: sizeFromWidth(1),
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: cubit
                                              .companyDetectedData[0]
                                              .myBranches
                                              ?.length,
                                          itemBuilder: (context, index) {
                                            return HorizontalScrollBranches(
                                              index: index,
                                              img: cubit.companyDetectedData[0]
                                                  .myBranches![index].image
                                                  .toString(),
                                              city: cubit.companyDetectedData[0]
                                                  .myBranches![index].city
                                                  .toString(),
                                              country: cubit
                                                  .companyDetectedData[0]
                                                  .myBranches![index]
                                                  .country
                                                  .toString(),
                                              branchName: cubit
                                                  .companyDetectedData[0]
                                                  .myBranches![index]
                                                  .name
                                                  .toString(),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                        SliverToBoxAdapter(
                          child: CompanyProjectsText(),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                                height: sizeFromHeight(5),
                                width: sizeFromWidth(1),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "There are no projects",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                )
                                // ListView.builder(
                                //     scrollDirection: Axis.horizontal,
                                //     physics: BouncingScrollPhysics(),
                                //     itemBuilder: (context, index) {
                                //       return Padding(
                                //         padding: EdgeInsets.only(
                                //           left: 8,
                                //           right: 8,
                                //           top: 10,
                                //         ),
                                //         child: CompanyProjects(),
                                //       );
                                //     }),
                                ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: CompanyListingText(),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Container(
                              height: sizeFromHeight(5),
                              width: sizeFromWidth(1),
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      // onTap: () => Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (_) => UnitsDetailsScreen(),
                                      //   ),
                                      // ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          elevation: 5,
                                          child: Container(
                                              width: sizeFromWidth(1.2),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5.0,
                                                              vertical: 5),
                                                      child: Container(
                                                        width: 80.w,
                                                        decoration:
                                                            BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/images/pic4.png"),
                                                              fit:
                                                                  BoxFit.cover),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 5,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 8.0,
                                                              vertical: 8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                "Duplex Appartment",
                                                                style:
                                                                    TextStyle(
                                                                  color: ColorManager
                                                                      .TextHomeColor,
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 25,
                                                                width: 25,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                5),
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.red,
                                                                          width:
                                                                              1,
                                                                        )),
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .solidHeart,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Container(
                                                            width: 130.w,
                                                            child: Row(
                                                              children: [
                                                                Icon(
                                                                  OsolIcon
                                                                      .location,
                                                                  color: ColorManager
                                                                      .AppBarIconcolorGrey,
                                                                  size: 9.w,
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Text(
                                                                  "5th settelment , New Cairo",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          9.sp),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Text.rich(TextSpan(
                                                              children: [
                                                                TextSpan(
                                                                  text:
                                                                      "\$ 240 ",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          9,
                                                                      color: ColorManager
                                                                          .OnBoardingScreen),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      "\\ Mnth",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          9,
                                                                      color: Colors
                                                                          .lightBlueAccent),
                                                                )
                                                              ])),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                "3.4",
                                                                style: TextStyle(
                                                                    color: ColorManager
                                                                        .TextHomeColor,
                                                                    fontSize:
                                                                        9),
                                                              ),
                                                              FaIcon(
                                                                FontAwesomeIcons
                                                                    .solidStar,
                                                                color: ColorManager
                                                                    .starColor,
                                                                size: 9,
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Container(
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                FaIcon(
                                                                  OsolIcon
                                                                      .square_,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                  size: 10,
                                                                ),
                                                                Text(
                                                                  "122 m²",
                                                                  style: TextStyle(
                                                                      color: ColorManager
                                                                          .TextHomeColor,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .bath,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                  size: 10,
                                                                ),
                                                                Text(
                                                                  "2",
                                                                  style: TextStyle(
                                                                      color: ColorManager
                                                                          .TextHomeColor,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                FaIcon(
                                                                  FontAwesomeIcons
                                                                      .bed,
                                                                  size: 10,
                                                                  color: Colors
                                                                          .grey[
                                                                      400],
                                                                ),
                                                                Text(
                                                                  "4",
                                                                  style: TextStyle(
                                                                      color: ColorManager
                                                                          .TextHomeColor,
                                                                      fontSize:
                                                                          10),
                                                                ),
                                                                SizedBox(
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
    );
  }
}

class CompanyListingText extends StatelessWidget {
  const CompanyListingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: sizeFromHeight(15),
        width: sizeFromWidth(1.5),
        child: Padding(
          padding: const EdgeInsets.only(
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
      child: Container(
        height: sizeFromHeight(14),
        width: sizeFromWidth(1.5),
        child: Padding(
          padding: const EdgeInsets.only(
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
  String city;
  String country;
  String branchName;
  String img;
  int index;

  HorizontalScrollBranches({
    required this.img,
    required this.country,
    required this.city,
    required this.branchName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CompanyCubit.get(context).changeNextCompanyId(CompanyCubit.get(context)
            .companyDetectedData[0]
            .myBranches![index]
            .id
            .toString());
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CompanyDetailsScreen(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 5,
          child: Container(
              width: sizeFromWidth(1.2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
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
                                  SizedBox(
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
                                  SizedBox(
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
                          SizedBox(
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5.0),
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
  const CompanyProjects({Key? key}) : super(key: key);

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
            child: Container(
              height: sizeFromHeight(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image(
                  image: AssetImage(
                    "assets/images/BG.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Text(
              "Villa in the North Coast",
              style: TextStyle(
                  color: ColorManager.TextHomeColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
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
                SizedBox(
                  width: 5,
                ),
                Text(
                  "5th settelment , New Cairo",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
