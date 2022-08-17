import 'package:flutter/material.dart';
import 'package:osol/Shared/constants.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.red,
        height: sizeFromHeight(4),
        width: sizeFromWidth(5),
      ),
    );
  }
}
