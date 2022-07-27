import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';

class CustomSelectNumberOfYear extends StatefulWidget {
  String title = "";
  TextEditingController controller;

  CustomSelectNumberOfYear(this.title, {required this.controller});

  @override
  State<CustomSelectNumberOfYear> createState() =>
      _CustomSelectNumberOfYearState();
}

class _CustomSelectNumberOfYearState extends State<CustomSelectNumberOfYear> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
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
                  Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            alignment: Alignment.center,
                            width: sizeFromWidth(3),
                            child: TextFormField(
                              controller: widget.controller,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "0",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
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
