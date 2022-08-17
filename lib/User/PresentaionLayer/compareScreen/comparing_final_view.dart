
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';

class ComparingScreen extends StatefulWidget {
  const ComparingScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<ComparingScreen> createState() => _ComparingScreenState();
}

class _ComparingScreenState extends State<ComparingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UnitClientCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () async {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 28,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              title: const Text(
                "Compare",
              
              ),
            ),
            body: cubit.comparedUnits.isEmpty
                ? Center(
                    child: Text(
                      'No compared units selected',
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  )
                : cubit.comparedUnits.length == 1
                    ? Center(
                        child: Text(
                          'Compared units must be exactly 1',
                          style: TextStyle(fontSize: 18.sp),
                        ),
                      )
                    : Builder(builder: (context) {
                        final firstUnit = cubit.comparedUnits[0];
                        final secondUnit = cubit.comparedUnits[1];
                        return ListView(
                          children: [
                            Container(
                              height: 110.h,
                              color: ColorManager.onboardingColorDots,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "${secondUnit.companyName == null ? "Owner" : firstUnit.companyName}",
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      sizeFromHeight(20))),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                              "${secondUnit.companyLogo == null ? "https://royalmazad.com/public/estate_gps/public/uploads/logo.png" : firstUnit.companyLogo}",
                                            ),
                                          ))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "${firstUnit.companyName == null ? "Owner" : secondUnit.companyName}",
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
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      sizeFromHeight(20))),
                                          child: CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                              "${firstUnit.companyLogo == null ? "https://royalmazad.com/public/estate_gps/public/uploads/logo.png" : secondUnit.companyLogo}}",
                                            ),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: secondUnit == "true"
                                            ? const FaIcon(
                                                FontAwesomeIcons
                                                    .solidCheckCircle,
                                                color: Colors.lightGreen,
                                              )
                                            : secondUnit == "false"
                                                ? FaIcon(
                                                    FontAwesomeIcons
                                                        .solidTimesCircle,
                                                    color: ColorManager
                                                        .redHeartcolor,
                                                  )
                                                : Text(
                                                    "${secondUnit.city},${secondUnit.country}"
                                                                .toString() ==
                                                            "true"
                                                        ? "mostafa"
                                                        : secondUnit.toString() ==
                                                                "false"
                                                            ? "mo"
                                                            : "${secondUnit.city},${secondUnit.country}",
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
                                        child: firstUnit == "true"
                                            ? const FaIcon(
                                                FontAwesomeIcons
                                                    .solidCheckCircle,
                                                color: Colors.lightGreen,
                                              )
                                            : firstUnit == "false"
                                                ? FaIcon(
                                                    FontAwesomeIcons
                                                        .solidTimesCircle,
                                                    color: ColorManager
                                                        .redHeartcolor,
                                                  )
                                                : Text(
                                                    "${firstUnit.city},${secondUnit.country}",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "Price (EGP)",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${secondUnit.price ?? 0}",
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
                                        child: Text(
                                          "${firstUnit.price ?? 0}",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${secondUnit.area ?? 0} m2",
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
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${firstUnit.area ?? 0} m2",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${secondUnit.rooms ?? 0} ",
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
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${firstUnit.rooms ?? 0} ",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${secondUnit.floor ?? 0} ",
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
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${firstUnit.floor ?? 0} ",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${secondUnit.bathroom ?? 0}",
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
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${firstUnit.bathroom ?? 0} ",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${secondUnit.finishedType ?? "Ignore"} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${firstUnit.finishedType == null ? "Ignore" : secondUnit.finishedType} ",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${secondUnit.yearBuild ?? 0} ",
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
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${firstUnit.yearBuild ?? 0} ",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          secondUnit.view ?? "Not Detected",
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
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${firstUnit.view ?? "Not Detected"} ",
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
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: secondUnit.parking == "on"
                                              ? const FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: Colors.lightGreen,
                                                )
                                              : FaIcon(
                                                  FontAwesomeIcons
                                                      .solidTimesCircle,
                                                  color: ColorManager
                                                      .redHeartcolor,
                                                )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: firstUnit.parking == "on"
                                              ? const FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: Colors.lightGreen,
                                                )
                                              : FaIcon(
                                                  FontAwesomeIcons
                                                      .solidTimesCircle,
                                                  color: ColorManager
                                                      .redHeartcolor,
                                                )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: secondUnit.recption == "on"
                                              ? const FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: Colors.lightGreen,
                                                )
                                              : FaIcon(
                                                  FontAwesomeIcons
                                                      .solidTimesCircle,
                                                  color: ColorManager
                                                      .redHeartcolor,
                                                )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: firstUnit.recption == "on"
                                              ? const FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: Colors.lightGreen,
                                                )
                                              : FaIcon(
                                                  FontAwesomeIcons
                                                      .solidTimesCircle,
                                                  color: ColorManager
                                                      .redHeartcolor,
                                                )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 110.h,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: secondUnit.security == "on"
                                              ? const FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: Colors.lightGreen,
                                                )
                                              : FaIcon(
                                                  FontAwesomeIcons
                                                      .solidTimesCircle,
                                                  color: ColorManager
                                                      .redHeartcolor,
                                                )),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: firstUnit.security == "on"
                                              ? const FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: Colors.lightGreen,
                                                )
                                              : FaIcon(
                                                  FontAwesomeIcons
                                                      .solidTimesCircle,
                                                  color: ColorManager
                                                      .redHeartcolor,
                                                )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
          ),
        );
      },
    );
  }
}
