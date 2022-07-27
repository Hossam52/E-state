import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/common_models/unit_model.dart';

import '../unit_crud_widgets.dart';

class CustomOtherDataAddInCompany extends StatelessWidget {
  final UnitModel? unit;
  CustomOtherDataAddInCompany({Key? key, this.unit}) : super(key: key);
  final PageController pageViewController = PageController();
  late final List Screen = [
    DistanceList(unit: unit),
    IndoorList(),
    OutdoorList()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Container(
            // height: sizeFromHeight(1.25),
            width: sizeFromWidth(1.5),
            child: Column(
              children: [
                Container(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black54,
                          width: 1,
                        )),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: sizeFromHeight(1.5),
                          child: PageView.builder(
                              itemCount: Screen.length,
                              controller: pageViewController,
                              itemBuilder: (context, index) {
                                // cubit.changeScreenOfDetails(index);
                                return Screen[index];
                              }),
                        ),
                        InkWell(
                          onTap: () {
                            pageViewController.nextPage(
                                duration: Duration(milliseconds: 800),
                                curve: Curves.easeIn);
                          },
                          child: Container(
                            child: cubit.currentDetailsScreen == 2
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Done",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      FaIcon(
                                        FontAwesomeIcons.check,
                                        color: Colors.black54,
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Next",
                                        style: TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.black54,
                                      )
                                    ],
                                  ),
                          ),
                        )
                      ],
                    ),
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
