import 'package:flutter/material.dart';
import 'package:osol/shared/constants.dart';

class CustomTxtFieldAddUnit extends StatelessWidget {
  String hint;
  String title;
  TextEditingController controller;
  TextInputType keyboardType;
  String? Function(String?)? validator;
  final int? maxLength;

  CustomTxtFieldAddUnit(
      {required this.title,
      required this.hint,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              // Text(
              //   "0/150",
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 14,
              //     fontWeight: FontWeight.w500,
              //   ),
              // )
            ],
          ),
          Container(
            height: sizeFromHeight(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              validator: validator,
              decoration: InputDecoration(
                  hintText: "${hint}",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
