import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/common_models/unit_model.dart';
import 'package:osol/shared/constants.dart';

class UnitBookmark extends StatelessWidget {
  const UnitBookmark({Key? key, required this.unit}) : super(key: key);
  final UnitModel unit;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: FaIcon(
            unit.authFavourite!
                ? FontAwesomeIcons.solidBookmark
                : FontAwesomeIcons.bookmark,
            color: ColorManager.OnBoardingScreen,
            size: 16,
          )),
    );
  }
}
