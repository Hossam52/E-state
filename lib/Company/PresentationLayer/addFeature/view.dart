import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/PresentationLayer/companyProfile/view.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/units.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';
import 'package:readmore/readmore.dart';

class AddFeatureInCompanyScreen extends StatelessWidget {
  List<HomeScreenSliderModel> unitDetails = [
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "50%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "70%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "60%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "20%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "60%"),
  ];
  TextEditingController depositeController = TextEditingController();

  TextEditingController numberOfYearController = TextEditingController();

  navigateFun(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => NavigationDrawerCompany()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return navigateFun(context);
      },
      child: Scaffold(
        backgroundColor: ColorManager.WhiteScreen,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorManager.WhiteScreen,
          toolbarHeight: 80,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      NavigationDrawerCompany()));
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
            "Add Feature",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 15, left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300]),
                  height: sizeFromHeight(3),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child:
                              SvgPicture.asset("assets/images/imageunit.svg")),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: DetailsOfContains(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: CustomTxtFieldAddUnit(
                  hint: 'change name',
                  title: "Main Title",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: CustomTxtFieldAddUnit(
                  hint: 'change name',
                  title: "Description",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: CustomSelectList(
                  "Select Purpose",
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
                    Expanded(
                      flex: 1,
                      child: CustomTxtFieldCompanyProfile(
                        controller: depositeController,
                        hint: "Deposite",
                        title: "Deposite",
                        width: sizeFromWidth(2.4),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomTxtFieldCompanyProfile(
                        hint: "1",
                        title: "Number Of Years",
                        width: sizeFromWidth(2.4),
                        controller: numberOfYearController,
                      ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomSelectList(
                        "Address",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(flex: 1, child: CustomSelectList("")),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 20,
                  ),
                  child: CustomGetLocation("Location")),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomSelectNumber(
                        "Rooms",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(flex: 1, child: CustomSelectNumber("Bathroom")),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomSelectNumber(
                        "Floor",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(flex: 1, child: CustomSelectNumber("Year build")),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomSelectNumber(
                        "Area",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(flex: 1, child: CustomSelectNumber("Bedrooms")),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomSelectListAvailable(
                        "Available",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: CustomSelectList("Delivery date"),
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
                child: CustomSelectList(
                  "Finish Type",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: CustomTxtFieldYoutubeAddUnit(
                  hint: "Enter the Link",
                  title: "Youtube Video Url",
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: CustomOtherDataAddInCompany(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Container(
                  height: sizeFromHeight(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        maximumSize: Size(double.infinity, 50)),
                    onPressed: () {},
                    child: Text(
                      "Publish",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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

class CustomOtherDataAddInCompany extends StatelessWidget {
  const CustomOtherDataAddInCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Container(
        height: sizeFromHeight(1.1),
        width: sizeFromWidth(1.5),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black54,
                width: 1,
              )),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                height: sizeFromHeight(1.1),
                child: PageView.builder(itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Distance",
                          style: TextStyle(
                              color: ColorManager.onboardingColorDots,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        ListTile(
                          leading: SvgPicture.asset("assets/images/train.svg"),
                          title: Text("Metro"),
                          trailing: Container(
                            height: 40,
                            width: sizeFromWidth(4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black54,
                                      )),
                                  height: sizeFromHeight(18),
                                  width: sizeFromWidth(5.5),
                                  child: TextFormField(
                                    cursorColor: Colors.black54,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset("assets/images/train.svg"),
                          title: Text("Metro"),
                          trailing: Container(
                            height: 40,
                            width: sizeFromWidth(4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black54,
                                      )),
                                  height: sizeFromHeight(18),
                                  width: sizeFromWidth(5.5),
                                  child: TextFormField(
                                    cursorColor: Colors.black54,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset("assets/images/train.svg"),
                          title: Text("Metro"),
                          trailing: Container(
                            height: 40,
                            width: sizeFromWidth(4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black54,
                                      )),
                                  height: sizeFromHeight(18),
                                  width: sizeFromWidth(5.5),
                                  child: TextFormField(
                                    cursorColor: Colors.black54,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset("assets/images/train.svg"),
                          title: Text("Metro"),
                          trailing: Container(
                            height: 40,
                            width: sizeFromWidth(4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black54,
                                      )),
                                  height: sizeFromHeight(18),
                                  width: sizeFromWidth(5.5),
                                  child: TextFormField(
                                    cursorColor: Colors.black54,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset("assets/images/train.svg"),
                          title: Text("Metro"),
                          trailing: Container(
                            height: 40,
                            width: sizeFromWidth(4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black54,
                                      )),
                                  height: sizeFromHeight(18),
                                  width: sizeFromWidth(5.5),
                                  child: TextFormField(
                                    cursorColor: Colors.black54,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset("assets/images/train.svg"),
                          title: Text("Metro"),
                          trailing: Container(
                            height: 40,
                            width: sizeFromWidth(4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black54,
                                      )),
                                  height: sizeFromHeight(18),
                                  width: sizeFromWidth(5.5),
                                  child: TextFormField(
                                    cursorColor: Colors.black54,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          leading: SvgPicture.asset("assets/images/train.svg"),
                          title: Text("Metro"),
                          trailing: Container(
                            height: 40,
                            width: sizeFromWidth(4),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: Colors.black54,
                                      )),
                                  height: sizeFromHeight(18),
                                  width: sizeFromWidth(5.5),
                                  child: TextFormField(
                                    cursorColor: Colors.black54,
                                    cursorHeight: 20,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "M",
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.black54,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DetailsOfContains extends StatelessWidget {
  const DetailsOfContains({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        height: sizeFromHeight(30),
        width: sizeFromWidth(1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: sizeFromWidth(2.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FaIcon(
                    FontAwesomeIcons.bath,
                    color: Colors.grey,
                    size: 12,
                  ),
                  Text("3"),
                  SizedBox(
                    width: 5,
                  ),
                  FaIcon(
                    FontAwesomeIcons.bed,
                    size: 12,
                    color: Colors.grey,
                  ),
                  Text("4"),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    OsolIcon.square_,
                    size: 12,
                    color: Colors.grey,
                  ),
                  Text("125 m²"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTxtFieldAddUnit extends StatelessWidget {
  String hint;
  String title;

  CustomTxtFieldAddUnit({required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              Text(
                "0/150",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Container(
            height: sizeFromHeight(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "${hint}",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSelectList extends StatelessWidget {
  String title = "";

  CustomSelectList(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      width: sizeFromWidth(2.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            height: sizeFromHeight(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: DropdownButton<String>(
                underline: SizedBox(),
                isExpanded: true,
                hint: Text("Select"),
                items:
                    <String>['Sale', 'Rent', 'Installment'].map((String value) {
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

class CustomSelectListAvailable extends StatelessWidget {
  String title = "";

  CustomSelectListAvailable(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      width: sizeFromWidth(2.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            height: sizeFromHeight(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text("Select"),
                items: <String>['available now', "In Progress"]
                    .map((String value) {
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

class CustomGetLocation extends StatelessWidget {
  String title = "";

  CustomGetLocation(
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            height: sizeFromHeight(10),
            decoration: BoxDecoration(
                color: ColorManager.onboardingColorDots,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "PickUp Location",
                    style: TextStyle(
                        color: ColorManager.WhiteScreen, fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: SvgPicture.asset("assets/images/map.svg"),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomSelectNumber extends StatefulWidget {
  String title = "";

  CustomSelectNumber(
    this.title,
  );

  @override
  State<CustomSelectNumber> createState() => _CustomSelectNumberState();
}

class _CustomSelectNumberState extends State<CustomSelectNumber> {
  @override
  Widget build(BuildContext context) {
    int num = 1;
    return Container(
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
          Container(
            height: sizeFromHeight(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "$num",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            num++;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.chevronUp,
                          color: Colors.black54,
                          size: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            num++;
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.chevronDown,
                          color: Colors.black54,
                          size: 14,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTxtFieldYoutubeAddUnit extends StatelessWidget {
  String hint;
  String title;

  CustomTxtFieldYoutubeAddUnit({required this.title, required this.hint});

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
