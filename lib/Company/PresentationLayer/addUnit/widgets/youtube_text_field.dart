import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../shared/constants.dart';

class CustomTxtFieldYoutubeAddUnit extends StatelessWidget {
  String hint;
  String title;
  TextEditingController controller;

  CustomTxtFieldYoutubeAddUnit(
      {required this.title, required this.hint, required this.controller});

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
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  cut: true,
                  paste: true,
                  selectAll: true,
                ),
                controller: controller,
                decoration: InputDecoration(
                  hintText: "${hint}",
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: FaIcon(FontAwesomeIcons.link),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
