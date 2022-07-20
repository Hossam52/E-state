import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/addUnit/view.dart';
import 'package:osol/Company/PresentationLayer/updateUnit/updateUnit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/units.dart';

class UnitDetailsCompanyScreen extends StatelessWidget {
  List<HomeScreenSliderModel> unitDetails = [
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "50%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "70%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "60%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "20%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "60%"),
  ];
  List<String> details = [
    "Status",
    "Details",
    "Description",
    "Developer",
    "Other Data",
    "Video",
    "Contacts"
  ];

  @override
  Widget build(BuildContext context) {
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
          "Unit details",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => UpdateUnitInCompanyScreen(),
                  ),
                );
              },
              icon: FaIcon(
                FontAwesomeIcons.pen,
                size: 20,
                color: ColorManager.onboardingColorDots,
              ),
            ),
          )
        ],
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: sizeFromHeight(3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManager.startgraidentCompany,
                      ColorManager.endgraidentCompany,
                      Colors.lightBlueAccent,
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.7, 0.0),
                  ),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Total leads",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "12",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Total Seen",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "12",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            "assets/images/touch.svg",
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Total Opened",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          "12",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15, left: 20),
              child: Container(
                height: sizeFromHeight(3.5),
                width: sizeFromWidth(1.5),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: unitDetails.length,
                    itemBuilder: (context, index) {
                      return ListDetailsCompany(
                        image: unitDetails[index].image,
                      );
                    }),
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: DetailsLocatioAndNameUnits(),
          // ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(
          //       vertical: 15.0,
          //       horizontal: 20,
          //     ),
          //     child: CustomUnitdetailsOfUnits(),
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: CustomDescription(),
          // ),
          SliverToBoxAdapter(
            child: CustomOtherDataCompany(),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: CustomVideo(),
            ),
          ),
        ],
      ),
    );
  }
}

class ListDetailsCompany extends StatelessWidget {
  String image;

  ListDetailsCompany({required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20.0),
      child: Container(
        height: sizeFromHeight(3.5),
        width: sizeFromWidth(1.3),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage("${image}"), fit: BoxFit.cover),
              ),
              height: sizeFromHeight(3),
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomOtherDataCompany extends StatelessWidget {
  const CustomOtherDataCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Container(
        height: sizeFromHeight(1.7),
        width: sizeFromWidth(1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                "Other Data",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: sizeFromHeight(2),
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) => Container(
                  height: sizeFromHeight(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: Text(
                          "Distance",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Container(
                                    height: sizeFromHeight(3),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Metro",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager
                                                  .onboardingColorDots,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          "Train",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager
                                                  .onboardingColorDots,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          "Bus",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager
                                                .onboardingColorDots,
                                          ),
                                        ),
                                        Text(
                                          "Pharmacy",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: ColorManager
                                                .onboardingColorDots,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "Beach",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager
                                                  .onboardingColorDots,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeFromHeight(3),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "100 m",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "150 m",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "300 m",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "500 m",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                      Text(
                                        "No",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              color: Colors.grey,
                              width: 2,
                              height: sizeFromHeight(3.2),
                            ),
                            Container(
                              height: sizeFromHeight(3),
                              alignment: Alignment.topCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Container(
                                      height: sizeFromHeight(6.5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Bakary",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager
                                                    .onboardingColorDots,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "Restaurant",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: ColorManager
                                                    .onboardingColorDots,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            "Coffe",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager
                                                  .onboardingColorDots,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: sizeFromHeight(6.5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "120 m",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          "100 m",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          "50 m",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
