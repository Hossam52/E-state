import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/view.dart';

import '../../BussinssLogic/AppSettingCubit/app_setting_cubit.dart';
import '../../BussinssLogic/authCubit/auth_cubit.dart';
import '../../BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';

class HorizontalScrollList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    var cubit2 = ProfileCubit.get(context);
    var cubit3 = AuthCubit.get(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          final populars = cubit.popularUnits;
          return Container(
            height: sizeFromHeight(5.6),
            alignment: Alignment.bottomCenter,
            child: ListView.builder(
                controller: cubit.scrollController,
                shrinkWrap: true,
                itemCount: populars.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: cubit3.userToken == null && cubit.myToken == null
                        ? () {}
                        : () {
                            UnitClientCubit.get(context)
                                .getUnitId(populars[index].id);
                            debugPrint("${populars[index].view}");
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => UnitsDetailsScreen(
                                    unitId: populars[index].id!),
                              ),
                            );
                          },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 2),
                      child: BlocBuilder<AppSettingCubit, AppSettingState>(
                        builder: (context, state) {
                          return Container(
                              decoration: BoxDecoration(
                                  color: AppSettingCubit.get(context).isDark
                                      ? ColorManager.DarkThemeBlackGround2
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              width: sizeFromWidth(1.4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.0, vertical: 5),
                                      child: Container(
                                        width: 80.w,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  "${populars[index].images![0]}"),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${populars[index].type}",
                                                style: TextStyle(
                                                  color: ColorManager
                                                      .TextHomeColor,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: FaIcon(
                                                    populars[index]
                                                                .authFavourite ==
                                                            "true"
                                                        ? FontAwesomeIcons
                                                            .solidBookmark
                                                        : FontAwesomeIcons
                                                            .bookmark,
                                                    color: ColorManager
                                                        .OnBoardingScreen,
                                                    size: 16,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                OsolIcon.location,
                                                color: ColorManager
                                                    .AppBarIconcolorGrey,
                                                size: 10.w,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                "${populars[index].city} , ${populars[index].country}",
                                                style:
                                                    TextStyle(fontSize: 10.sp),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text.rich(TextSpan(children: [
                                                TextSpan(
                                                  text:
                                                      "\$ ${populars[index].price == null ? 0 : populars[index].price} ",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: ColorManager
                                                          .OnBoardingScreen),
                                                ),
                                                TextSpan(
                                                  text: "\\ Mnth",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors
                                                          .lightBlueAccent),
                                                )
                                              ])),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "3.4",
                                                style: TextStyle(
                                                    color: ColorManager
                                                        .TextHomeColor,
                                                    fontSize: 10),
                                              ),
                                              FaIcon(
                                                FontAwesomeIcons.solidStar,
                                                color: ColorManager.starColor,
                                                size: 10,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                FaIcon(
                                                  OsolIcon.square_,
                                                  color: Colors.grey[400],
                                                  size: 10,
                                                ),
                                                Text(
                                                  "${populars[index].area} m²",
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .TextHomeColor,
                                                      fontSize: 10),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.bath,
                                                  color: Colors.grey[400],
                                                  size: 10,
                                                ),
                                                Text(
                                                  "${populars[index].bathroom}",
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .TextHomeColor,
                                                      fontSize: 10),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                FaIcon(
                                                  FontAwesomeIcons.bed,
                                                  size: 10,
                                                  color: Colors.grey[400],
                                                ),
                                                Text(
                                                  "${populars[index].bedrooms}",
                                                  style: TextStyle(
                                                      color: ColorManager
                                                          .TextHomeColor,
                                                      fontSize: 10),
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
                              ));
                        },
                      ),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}
