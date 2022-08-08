import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osol/Shared/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WalletView extends StatelessWidget {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: sizeFromHeight(2.5),
            child: Column(
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      child: CarouselSlider.builder(
                        itemCount: 4,
                        itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) =>
                            Column(
                          children: [
                            Container(
                              height: sizeFromHeight(3.43),
                              decoration: BoxDecoration(
                                color: ColorManager.onboardingColorDots,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "UnKnown text",
                                          style: TextStyle(
                                            color: ColorManager.WhiteScreen,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "UnKnown tet",
                                          style: TextStyle(
                                            color: ColorManager.WhiteScreen,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Container(
                                          height: sizeFromHeight(15),
                                          width: sizeFromWidth(6),
                                          decoration: BoxDecoration(
                                              color: ColorManager.WhiteScreen,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        Container(
                                          color: Colors.black45,
                                          width: sizeFromWidth(1.8),
                                          height: 1,
                                        ),
                                        Text(
                                          "**** **** **** *089",
                                          style: TextStyle(
                                            color: ColorManager.WhiteScreen,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        Text(
                                          "User Name",
                                          style: TextStyle(
                                            color: ColorManager.WhiteScreen,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: sizeFromHeight(18),
                                            width: sizeFromWidth(12),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/hologram.png"),
                                            )),
                                        Container(
                                            height: sizeFromHeight(18),
                                            width: sizeFromWidth(8),
                                            child: Image(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  "assets/images/chip.png"),
                                            )),
                                        Container(
                                            height: sizeFromHeight(18),
                                            width: sizeFromWidth(12),
                                            child: Image(
                                              image: AssetImage(
                                                  "assets/images/visa.png"),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        options: CarouselOptions(
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 0.9,
                          aspectRatio: 2.0,
                          initialPage: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SmoothPageIndicator(
                    controller: controller,
                    count: 4,
                    effect: WormEffect(
                      dotHeight: 6,
                      dotWidth: 6,
                      activeDotColor: ColorManager.onboardingColorDots,
                      dotColor: ColorManager.onboardingColorDotsNotActive,
                      type: WormType.thin,
                      // strokeWidth: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: sizeFromHeight(7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: sizeFromHeight(10),
                  width: sizeFromHeight(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SvgPicture.asset("assets/images/saved.svg"),
                  ),
                  decoration: BoxDecoration(
                      color: ColorManager.onboardingColorDots,
                      borderRadius: BorderRadius.circular(8)),
                ),
                Container(
                  height: sizeFromHeight(10),
                  width: sizeFromHeight(10),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SvgPicture.asset("assets/images/payhistory.svg"),
                  ),
                  decoration: BoxDecoration(
                      color: ColorManager.onboardingColorDots,
                      borderRadius: BorderRadius.circular(8)),
                ),
                Container(
                  height: sizeFromHeight(10),
                  width: sizeFromHeight(10),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SvgPicture.asset("assets/images/precentage.svg"),
                  ),
                  decoration: BoxDecoration(
                      color: ColorManager.onboardingColorDots,
                      borderRadius: BorderRadius.circular(8)),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: sizeFromHeight(1.5),
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                  appBar: TabBar(
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: ColorManager.WhiteScreen,
                          width: 3,
                        ),
                      ),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: ColorManager.WhiteScreen,
                    tabs: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Tab(
                          text: "Saved Cards",
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Tab(
                          text: "Payment History",
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Tab(
                          text: "A visable Package",
                        ),
                      ),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.CompareConatainer,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: sizeFromHeight(2.5),
                            decoration: BoxDecoration(
                                color: ColorManager.WhiteScreen,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: sizeFromHeight(10),
                                      width: sizeFromHeight(10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                            "assets/images/visa.svg"),
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: Text(
                                        "Visa Master Card",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    subtitle: Text(
                                      "**** **** **** *152",
                                      style: TextStyle(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black87,
                                    height: 1,
                                    indent: 10,
                                    thickness: 1,
                                  ),
                                  ListTile(
                                    leading: Container(
                                      height: sizeFromHeight(10),
                                      width: sizeFromHeight(10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                            "assets/images/visa.svg"),
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: Text(
                                        "Visa Master Card",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    subtitle: Text(
                                      "**** **** **** *152",
                                      style: TextStyle(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.CompareConatainer,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: sizeFromHeight(2.5),
                            decoration: BoxDecoration(
                                color: ColorManager.WhiteScreen,
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ListTile(
                                    leading: Container(
                                      height: sizeFromHeight(10),
                                      width: sizeFromHeight(10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                            "assets/images/visa.svg"),
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15.0),
                                      child: Text(
                                        "Visa Master Card",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    subtitle: Text(
                                      "**** **** **** *152",
                                      style: TextStyle(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black87,
                                    height: 1,
                                    indent: 10,
                                    thickness: 1,
                                  ),
                                  ListTile(
                                    leading: Container(
                                      height: sizeFromHeight(10),
                                      width: sizeFromHeight(10),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                            "assets/images/visa.svg"),
                                      ),
                                      decoration: BoxDecoration(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                    ),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15.0),
                                      child: Text(
                                        "Visa Master Card",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    subtitle: Text(
                                      "**** **** **** *152",
                                      style: TextStyle(
                                          color:
                                              ColorManager.onboardingColorDots,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: ColorManager.CompareConatainer,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: ListView(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: sizeFromHeight(10),
                                  width: sizeFromHeight(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        "assets/images/precentage.svg"),
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorManager.onboardingColorDots,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Normal User Package",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                subtitle: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Package for 3 month usage",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorManager.onboardingColorDots,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  height: sizeFromHeight(10),
                                  width: sizeFromHeight(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        "assets/images/precentage.svg"),
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorManager.onboardingColorDots,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Normal User Package",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                subtitle: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Package for 3 month usage",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorManager.onboardingColorDots,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  height: sizeFromHeight(10),
                                  width: sizeFromHeight(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        "assets/images/precentage.svg"),
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorManager.onboardingColorDots,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Normal User Package",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                subtitle: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Package for 3 month usage",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorManager.onboardingColorDots,
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Container(
                                  height: sizeFromHeight(10),
                                  width: sizeFromHeight(10),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SvgPicture.asset(
                                        "assets/images/precentage.svg"),
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorManager.onboardingColorDots,
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "Normal User Package",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                subtitle: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    "Package for 3 month usage",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: ColorManager.onboardingColorDots,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        )
      ],
    ));
  }
}
