import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';

class DetailsOfContains extends StatelessWidget {
  const DetailsOfContains({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
          child: Container(
            height: sizeFromHeight(30),
            width: sizeFromWidth(1.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: sizeFromWidth(2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.bath,
                        color: Colors.grey,
                        size: 12,
                      ),
                      Text("${cubit.numBathRoom}"),
                      SizedBox(
                        width: 5,
                      ),
                      FaIcon(
                        FontAwesomeIcons.bed,
                        size: 12,
                        color: Colors.grey,
                      ),
                      Text("${cubit.numBedRoom}"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        OsolIcon.square_,
                        size: 12,
                        color: Colors.grey,
                      ),
                      Text("0 m²"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
