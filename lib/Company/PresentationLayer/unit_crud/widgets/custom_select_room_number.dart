import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/shared/constants.dart';

class CustomSelectRoomNumber extends StatelessWidget {
  String title = "";
  int num;

  CustomSelectRoomNumber(
    this.title, {
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitCubit, UnitState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headline3!),
                ],
              ),
              Container(
                height: sizeFromHeight(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              "${num}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              cubit.changeNumRoomsPlus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronUp,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              cubit.changeNumRoomsMinus();
                            },
                            child: Icon(
                              FontAwesomeIcons.chevronDown,
                              color: Colors.black54,
                              size: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
