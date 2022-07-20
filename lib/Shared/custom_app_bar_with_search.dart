import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/shared/constants.dart';

import 'Customicon.dart';
import 'custom_search_bar.dart';

class CustomAppBarWithPreferredSizeInHomeScreen extends StatelessWidget with PreferredSizeWidget {
  CustomAppBarWithPreferredSizeInHomeScreen({
    required this.title,
    this.colorAB = Colors.black,
    this.withFilter = false,
  });

  void Function()? onPressed;
  final String title;
  Color colorAB;
  final bool withFilter;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(70),
      child: AppBar(
        elevation: 0,
        backgroundColor: colorAB,
        toolbarHeight: 100,
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Transform.scale(
            scale: 0.8,
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: ColorManager.AppBarHomeColorIcon, width: 2),
                ),
                child: Icon(
                  OsolIcon.menu,
                  color: ColorManager.AppBarHomeColorIcon,
                ),
              ),
            ),
          ),
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              OsolIcon.search,
              color: ColorManager.AppBarIconcolorGrey,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              OsolIcon.bell,
              color: ColorManager.AppBarIconcolorGrey,
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
