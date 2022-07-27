import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/map/unit_map_location.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/unit_crud_view.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/custom_video_player.dart';
import 'package:osol/Shared/unit_facilities.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/units.dart';
import 'package:osol/common_models/unit_model.dart';
import 'package:osol/shared/Customicon.dart';

class UnitDetailsCompanyScreen extends StatelessWidget {
  const UnitDetailsCompanyScreen({Key? key, required this.unit})
      : super(key: key);
  final UnitModel unit;

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
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black54,
            size: 28,
          ),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        centerTitle: true,
        title: const Text(
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
                    builder: (_) => UnitCrudView(unit: unit),
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
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _UnitStatistics(
              unit: unit,
            ),
          ),
          SliverToBoxAdapter(
            child: _UnitImages(unit: unit),
          ),
          SliverToBoxAdapter(
            child: _DetailsLocatioAndNameUnit(
              unit: unit,
            ),
          ),
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
            child: _CustomOtherDataCompany(unit: unit),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: CustomVideoPlayer(
                videoUrl: unit.video!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitImages extends StatelessWidget {
  const _UnitImages({
    Key? key,
    required this.unit,
  }) : super(key: key);

  final UnitModel unit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0, bottom: 15, left: 20),
      child: SizedBox(
          height: sizeFromHeight(3.5),
          width: sizeFromWidth(1.5),
          child: CarouselSlider.builder(
              itemCount: unit.images?.length ?? 0,
              itemBuilder: (context, _, index) {
                return ListDetailsCompany(
                  image: unit.images![index],
                );
              },
              options: CarouselOptions(
                enableInfiniteScroll: false,
              ))),
    );
  }
}

class _UnitStatistics extends StatelessWidget {
  const _UnitStatistics({
    Key? key,
    required this.unit,
  }) : super(key: key);
  final UnitModel unit;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            statItem(
                title: 'Total leads',
                value: unit.leadNum.toString(),
                icon: Icons.phone),
            statItem(
                title: 'Total seen',
                value: unit.watchNum.toString(),
                icon: Icons.visibility),
            statItem(
                title: 'Total Opened',
                value: unit.openedNum.toString(),
                svgPath: 'assets/images/touch.svg'),
          ],
        ),
      ),
    );
  }

  ListTile statItem(
      {required String title,
      required String value,
      IconData? icon,
      String? svgPath}) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: svgPath != null
              ? SvgPicture.asset(
                  svgPath,
                  height: 25,
                  width: 25,
                )
              : icon != null
                  ? Icon(
                      icon,
                      color: Colors.white,
                    )
                  : Container(),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      trailing: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
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
      padding: const EdgeInsets.only(right: 20.0),
      child: SizedBox(
        height: sizeFromHeight(3.5),
        width: sizeFromWidth(1.3),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: CachedNetworkImageProvider("${image}"),
                    fit: BoxFit.cover),
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

class _CustomOtherDataCompany extends StatelessWidget {
  const _CustomOtherDataCompany({Key? key, required this.unit})
      : super(key: key);
  final UnitModel unit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: SizedBox(
        // height: sizeFromHeight(1.8),
        width: sizeFromWidth(1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Other Data",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            UnitFacilities(
              unit: unit,
              height: sizeFromHeight(2),
            )
          ],
        ),
      ),
    );
  }
}

class _DetailsLocatioAndNameUnit extends StatelessWidget {
  const _DetailsLocatioAndNameUnit({Key? key, required this.unit})
      : super(key: key);
  final UnitModel unit;
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
                  unit.title!,
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
                      const FaIcon(
                        FontAwesomeIcons.bath,
                        color: Colors.grey,
                        size: 12,
                      ),
                      Text(getText(unit.bathroom)),
                      const SizedBox(
                        width: 5,
                      ),
                      const FaIcon(
                        FontAwesomeIcons.bed,
                        size: 12,
                        color: Colors.grey,
                      ),
                      Text(getText(unit.bedrooms)),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        OsolIcon.square_,
                        size: 12,
                        color: Colors.grey,
                      ),
                      Text("${unit.area} m²"),
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
                      "${getText(unit.price)} EGP",
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: sizeFromHeight(30),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: ColorManager.onboardingColorDots),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => UnitMapLocation(
                                  lat: double.tryParse(unit.lat!) ?? 0,
                                  lng: double.tryParse(unit.long!) ?? 0)));
                    },
                    child: Row(
                      children: const [
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

  String getText(dynamic text) {
    return text?.toString() ?? 'N/A';
  }
}
