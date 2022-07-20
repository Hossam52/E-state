import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';

import '../User/PresentaionLayer/compareScreen/view.dart';
import 'constants.dart';

AppBar CustomAppBar(context, txt, cubit) {
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
      "$txt",
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          cubit.unitDetectedId.add(cubit.getUnitByIdList[0].id);
          Fluttertoast.showToast(
            msg: "this unit added to compare List",
            backgroundColor: Colors.green,
          );
          debugPrint(cubit.getUnitByIdList[0].id.toString());
          cubit.addCompareToList(
              CompareUnitDetails(
                id: cubit.getUnitByIdList[0].id,
                city: cubit.getUnitByIdList[0].city.toString(),
                country: cubit.getUnitByIdList[0].country.toString(),
                image: "${cubit.getUnitByIdList[0].images![0]}",
                txt: cubit.getUnitByIdList[0].type.toString(),
              ),
              id: cubit.getUnitByIdList[0].id);
        },
        icon: Icon(
          OsolIcon.images,
          color: ColorManager.AppBarIconcolorGrey,
          size: 20,
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
          FontAwesomeIcons.solidBookmark,
          color: ColorManager.OnBoardingScreen,
          size: 16,
        ),
      )
    ],
  );
}
