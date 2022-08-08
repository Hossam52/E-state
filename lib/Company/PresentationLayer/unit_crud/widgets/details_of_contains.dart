import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/component/methods..dart';
import 'package:osol/Shared/constants.dart';

class DetailsOfContains extends StatelessWidget {
  const DetailsOfContains({Key? key, this.area = '0'}) : super(key: key);
  final String area;

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
                        color:
                            getInvertDarkmoodColor(context).withOpacity(0.85),
                        size: 12,
                      ),
                      Text(
                        "${cubit.numBathRoom}",
                        style: Theme.of(context).textTheme.headline3!,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FaIcon(
                        FontAwesomeIcons.bed,
                        size: 12,
                        color:
                            getInvertDarkmoodColor(context).withOpacity(0.85),
                      ),
                      Text(
                        "${cubit.numBedRoom}",
                        style: Theme.of(context).textTheme.headline3!,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        OsolIcon.square_,
                        size: 12,
                        color:
                            getInvertDarkmoodColor(context).withOpacity(0.85),
                      ),
                      Text(
                        "$area m²",
                        style: Theme.of(context).textTheme.headline3!,
                      ),
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
