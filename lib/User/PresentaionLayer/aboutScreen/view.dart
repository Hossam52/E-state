import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';

import 'mapTest.dart';

class AboutView extends StatelessWidget {
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
          "About App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: double.infinity,
              height: sizeFromHeight(6),
              child: Text(
                "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: sizeFromHeight(3),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco poriti laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in uienply voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat norin proident, sunt in "
                "culpa qui officia deserunt mollit anim id est laborum.",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 17,
                ),
              ),
            ),
            Container(
              height: sizeFromHeight(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.clock,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("June 2, 2017"),
                    ],
                  ),
                  FaIcon(
                    FontAwesomeIcons.ellipsisVertical,
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                "More",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                primary: ColorManager.onboardingColorDots,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
