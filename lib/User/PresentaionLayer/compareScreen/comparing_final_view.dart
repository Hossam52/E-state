import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/PresentaionLayer/DawerScreen/view.dart';

class ComparingScreen extends StatefulWidget {
  @override
  State<ComparingScreen> createState() => _ComparingScreenState();
}

class _ComparingScreenState extends State<ComparingScreen> {
  @override
  void initState() {
    super.initState();
    UnitClientCubit.get(context).secondUnit.isEmpty ||
            UnitClientCubit.get(context).firstUnit.isEmpty
        ? UnitClientCubit.get(context).getAllData.call()
        : print("${UnitClientCubit.get(context).unitDetectedId[1]}");
  }

  onWillPopFunction(context) {
    UnitClientCubit.get(context).secondUnit.clear();
    UnitClientCubit.get(context).firstUnit.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UnitClientCubit.get(context);
        return WillPopScope(
          onWillPop: () => onWillPopFunction(context),
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 80,
              leading: IconButton(
                onPressed: () async {
                  await cubit.newIndex == 0;
                  cubit.compareList == 0;
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => NavigationDrawer(token: "")));
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                ),
              ),
              centerTitle: true,
              title: Text(
                "Compare",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            body: cubit.secondUnit.isEmpty || cubit.firstUnit.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView(
                    children: [
                      Container(
                        height: 110.h,
                        color: ColorManager.onboardingColorDots,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Feature",
                              style: TextStyle(
                                color: ColorManager.WhiteScreen,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    "${cubit.secondUnit[0].companyName == null ? "Owner" : cubit.firstUnit[0].companyName}",
                                    style: TextStyle(
                                      color: ColorManager.WhiteScreen,
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                    height: sizeFromHeight(10),
                                    width: sizeFromWidth(7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            sizeFromHeight(20))),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        "${cubit.secondUnit[0].companyLogo == null ? "https://royalmazad.com/public/estate_gps/public/uploads/logo.png" : cubit.firstUnit[0].companyLogo}",
                                      ),
                                    ))
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${cubit.firstUnit[0].companyName == null ? "Owner" : cubit.secondUnit[0].companyName}",
                                  style: TextStyle(
                                    color: ColorManager.WhiteScreen,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Container(
                                    height: sizeFromHeight(10),
                                    width: sizeFromWidth(7),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            sizeFromHeight(20))),
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        "${cubit.firstUnit[0].companyLogo == null ? "https://royalmazad.com/public/estate_gps/public/uploads/logo.png" : cubit.secondUnit[0].companyLogo}}",
                                      ),
                                    ))
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Location",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: cubit.secondUnit[0] == "true"
                                      ? const FaIcon(
                                          FontAwesomeIcons.solidCheckCircle,
                                          color: Colors.lightGreen,
                                        )
                                      : cubit.secondUnit[0] == "false"
                                          ? FaIcon(
                                              FontAwesomeIcons.solidTimesCircle,
                                              color: ColorManager.redHeartcolor,
                                            )
                                          : Text(
                                              "${cubit.secondUnit[0].city},${cubit.secondUnit[0].country}"
                                                          .toString() ==
                                                      "true"
                                                  ? "mostafa"
                                                  : cubit.secondUnit[0]
                                                              .toString() ==
                                                          "false"
                                                      ? "mo"
                                                      : "${cubit.secondUnit[0].city},${cubit.secondUnit[0].country}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                              textAlign: TextAlign.center,
                                            ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: cubit.firstUnit[0] == "true"
                                      ? const FaIcon(
                                          FontAwesomeIcons.solidCheckCircle,
                                          color: Colors.lightGreen,
                                        )
                                      : cubit.firstUnit[0] == "false"
                                          ? FaIcon(
                                              FontAwesomeIcons.solidTimesCircle,
                                              color: ColorManager.redHeartcolor,
                                            )
                                          : Text(
                                              "${cubit.firstUnit[0].city},${cubit.secondUnit[0].country}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline3,
                                              textAlign: TextAlign.center,
                                            ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Price (EGP)",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.secondUnit[0].price == null ? 0 : cubit.secondUnit[0].price}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.firstUnit[0].price == null ? 0 : cubit.firstUnit[0].price}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Area",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.secondUnit[0].area == null ? 0 : cubit.secondUnit[0].area} m2",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.firstUnit[0].area == null ? 0 : cubit.firstUnit[0].area} m2",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Rooms",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.secondUnit[0].rooms == null ? 0 : cubit.secondUnit[0].rooms} ",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.firstUnit[0].rooms == null ? 0 : cubit.firstUnit[0].rooms} ",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Floor",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.secondUnit[0].floor == null ? 0 : cubit.secondUnit[0].floor} ",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.firstUnit[0].floor == null ? 0 : cubit.firstUnit[0].floor} ",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Bathrooms",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.secondUnit[0].bathroom == null ? 0 : cubit.secondUnit[0].bathroom}",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.firstUnit[0].bathroom == null ? 0 : cubit.firstUnit[0].bathroom} ",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Finishes",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.secondUnit[0].finishedType == null ? "Ignore" : cubit.secondUnit[0].finishedType} ",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.firstUnit[0].finishedType == null ? "Ignore" : cubit.secondUnit[0].finishedType} ",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Build Year",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.secondUnit[0].yearBuild == null ? 0 : cubit.secondUnit[0].yearBuild} ",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.firstUnit[0].yearBuild == null ? 0 : cubit.firstUnit[0].yearBuild} ",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "View",
                                    style:
                                    Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.secondUnit[0].view == null ? "Not Detected" : cubit.secondUnit[0].view}",
                                    style:
                                    Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "${cubit.firstUnit[0].view == null ? "Not Detected" : cubit.firstUnit[0].view} ",
                                    style:
                                    Theme.of(context).textTheme.headline3,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Parking",
                                    style:
                                    Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: cubit.secondUnit[0].parking == "on"
                                        ? const FaIcon(
                                            FontAwesomeIcons.solidCheckCircle,
                                            color: Colors.lightGreen,
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.solidTimesCircle,
                                            color: ColorManager.redHeartcolor,
                                          )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: cubit.firstUnit[0].parking == "on"
                                        ? const FaIcon(
                                            FontAwesomeIcons.solidCheckCircle,
                                            color: Colors.lightGreen,
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.solidTimesCircle,
                                            color: ColorManager.redHeartcolor,
                                          )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Reception",
                                    style:
                                    Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: cubit.secondUnit[0].recption == "on"
                                        ? const FaIcon(
                                            FontAwesomeIcons.solidCheckCircle,
                                            color: Colors.lightGreen,
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.solidTimesCircle,
                                            color: ColorManager.redHeartcolor,
                                          )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: cubit.firstUnit[0].recption == "on"
                                        ? const FaIcon(
                                            FontAwesomeIcons.solidCheckCircle,
                                            color: Colors.lightGreen,
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.solidTimesCircle,
                                            color: ColorManager.redHeartcolor,
                                          )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 110.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    "Security",
                                    style:
                                    Theme.of(context).textTheme.headline2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: cubit.secondUnit[0].security == "on"
                                        ? const FaIcon(
                                            FontAwesomeIcons.solidCheckCircle,
                                            color: Colors.lightGreen,
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.solidTimesCircle,
                                            color: ColorManager.redHeartcolor,
                                          )),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: cubit.firstUnit[0].security == "on"
                                        ? const FaIcon(
                                            FontAwesomeIcons.solidCheckCircle,
                                            color: Colors.lightGreen,
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.solidTimesCircle,
                                            color: ColorManager.redHeartcolor,
                                          )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
