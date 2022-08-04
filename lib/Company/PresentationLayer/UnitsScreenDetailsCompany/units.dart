import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';
import 'package:readmore/readmore.dart';

class AppBarUnitsDetails extends StatelessWidget {
  const AppBarUnitsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SearchScreen()));
          },
          icon: Icon(
            Icons.compare_arrows,
            color: ColorManager.AppBarIconcolorGrey,
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => SearchScreen()));
          },
          icon: FaIcon(
            FontAwesomeIcons.shareNodes,
            color: ColorManager.AppBarIconcolorGrey,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.heart,
            color: ColorManager.redHeartcolor,
          ),
        )
      ],
    );
  }
}

///End
class DetailsLocatioAndNameUnits extends StatelessWidget {
  const DetailsLocatioAndNameUnits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        height: sizeFromHeight(6),
        width: sizeFromWidth(1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Villa in the North Coast",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: sizeFromWidth(3.5),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "12,000,000 EGP",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: sizeFromHeight(30),
                    ),
                    Row(
                      children: [
                        FaIcon(
                          OsolIcon.location,
                          color: ColorManager.redHeartcolor,
                          size: 14,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "North Coast, Egypt",
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        )
                      ],
                    )
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorManager.onboardingColorDots),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          OsolIcon.location,
                          color: Colors.white,
                          size: 12,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Show On Map",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        )
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

///End DetailsLocatioAndNameUnits
class CustomFloatingIcon extends StatelessWidget {
  const CustomFloatingIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 80),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.onboardingColorDots,
        ),
        height: sizeFromHeight(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: ColorManager.WhiteScreen,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.phone),
              ),
            ),
            CircleAvatar(
              backgroundColor: ColorManager.WhiteScreen,
              radius: 25,
              child: IconButton(
                onPressed: () {},
                icon: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: ColorManager.onboardingColorDots,
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: ColorManager.WhiteScreen,
              radius: 25,
              child: IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.solidMessage),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///End custom Floating Icon
class CustomWriteReview extends StatelessWidget {
  const CustomWriteReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Write A review",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: sizeFromHeight(12),
                          width: sizeFromWidth(1.37),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey, width: 2),
                              color: ColorManager.WhiteScreen,
                              borderRadius: BorderRadius.circular(
                                10,
                              )),
                          child: TextFormField(
                            cursorColor: Colors.grey[500],
                            cursorHeight: sizeFromHeight(17),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                bottom: 15,
                                left: 10,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: FaIcon(
                            FontAwesomeIcons.telegram,
                            color: ColorManager.onboardingColorDots,
                            size: 50,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///End custom write review
class CustomReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Reviews",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: sizeFromHeight(3),
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 20,
                itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Container(
                        height: sizeFromHeight(3.1),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: sizeFromHeight(12),
                                    width: sizeFromWidth(8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            sizeFromHeight(20))),
                                    child: Image.asset(
                                      "assets/images/avatar.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: sizeFromHeight(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Ahmed Mohamed",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        "12-12-2021",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("3/5"),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: sizeFromHeight(7),
                                child: Text(
                                  "Here is the our cstomer review about this service"
                                  "conatin the rating and information about the customer"
                                  "conatin the rating and information about the and information about the customer",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                            RatingBar.builder(
                              itemSize: 20,
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )
                          ],
                        ),
                      ),
                    )),
          )
        ],
      ),
    );
  }
}

///End custom review
class CustomVideo extends StatelessWidget {
  const CustomVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Video",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            height: sizeFromHeight(4),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                "assets/images/videos.svg",
              ),
            ),
          )
        ],
      ),
    );
  }
}

///End custom video
class CustomAboutDeveloper extends StatelessWidget {
  const CustomAboutDeveloper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Container(
        height: sizeFromHeight(1.2),
        width: sizeFromWidth(1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "About Developer",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              height: sizeFromHeight(7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 2, color: ColorManager.onboardingColorDots)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: sizeFromHeight(9),
                      width: sizeFromWidth(6),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          "assets/images/deve.svg",
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.onboardingColorDots,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Real estate Company",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            FaIcon(
                              OsolIcon.location,
                              color: ColorManager.redHeartcolor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "North Coast, Egypt",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
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
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: sizeFromHeight(2.2),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                              color: Colors.black,
                                              fontSize: 14),
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
                                              color: Colors.black,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          "No",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

///End custom about developer
class CustomDescription extends StatelessWidget {
  const CustomDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: sizeFromHeight(7),
        width: sizeFromWidth(1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Description",
              style: TextStyle(
                  color: ColorManager.onboardingColorDots, fontSize: 18),
            ),
            ReadMoreText(
              "Great area view for Latakia flat don’t miss it "
              "Great area view for Latakia flat don’t miss it"
              " Great area view for Latakia flat don’t miss it ",
              style: TextStyle(fontSize: 16),
              trimLines: 2,
              colorClickableText: ColorManager.onboardingColorDots,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Read more',
              trimExpandedText: "Read less",
              moreStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                decorationStyle: TextDecorationStyle.wavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///End custom description
class CustomUnitdetailsOfUnits extends StatelessWidget {
  const CustomUnitdetailsOfUnits({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(2),
      width: sizeFromWidth(1.2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Status",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Rooms",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Floor",
                style: TextStyle(
                  color: ColorManager.onboardingColorDots,
                ),
              ),
              Text(
                "Baths",
                style: TextStyle(
                  color: ColorManager.onboardingColorDots,
                  fontSize: 18,
                ),
              ),
              Text(
                "Year-build",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Finish-type",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Area",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "View",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Seller",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
              Text(
                "Payment method",
                style: TextStyle(
                    color: ColorManager.onboardingColorDots, fontSize: 18),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Resale",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                "5",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                "2",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              Text(
                "1",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                "2005",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                "Lux",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                "120 m²",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                "Front view",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                width: sizeFromWidth(3),
              ),
              Text(
                "Ahly company",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                width: sizeFromWidth(3),
              ),
              Text(
                "Cash",
                style: TextStyle(color: Colors.black, fontSize: 18),
              )
            ],
          )
        ],
      ),
    );
  }
}

///End custom unit details of units
class CustomUnitIInformation extends StatelessWidget {
  const CustomUnitIInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                border: Border.all(color: ColorManager.onboardingColorDots)),
            child: CircleAvatar(
              radius: sizeFromWidth(12),
              backgroundColor: ColorManager.WhiteScreen,
              child: Image.asset(
                "assets/images/companyname.png",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Real estate Company",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "12-12-2021",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: FaIcon(
              FontAwesomeIcons.ellipsisVertical,
              color: Colors.grey,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

///End custom unit information
