import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';

class CustomTxtFieldYoutubeAddUnit extends StatelessWidget {
  String hint;
  String title;
  TextEditingController controller;
  String? Function(String?)? validator;
  CustomTxtFieldYoutubeAddUnit(
      {required this.title,
      required this.hint,
      required this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline3!,
          ),
          Container(
            height: sizeFromHeight(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: Center(
              child: TextFormField(
                validator: validator,
                toolbarOptions: const ToolbarOptions(
                  copy: true,
                  cut: true,
                  paste: true,
                  selectAll: true,
                ),
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint,
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: FaIcon(FontAwesomeIcons.link),
                  ),
                  border: const OutlineInputBorder(
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
