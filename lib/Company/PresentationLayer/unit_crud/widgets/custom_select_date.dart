import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';
import 'package:intl/intl.dart';

class CustomSelectDate extends StatefulWidget {
  String title = "";

  CustomSelectDate(
    this.title,
  );

  @override
  State<CustomSelectDate> createState() => _CustomSelectDateState();
}

class _CustomSelectDateState extends State<CustomSelectDate> {
  DateTime date = DateTime(2022, 12, 24);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return InkWell(
          onTap: () async {
            DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(1990),
                lastDate: DateTime(2100));
            if (newDate == null) return;
            setState(() {
              date = newDate;
              widget.title = DateFormat('yyyy-MM-dd').format(newDate);
            });
            cubit.changeDate(DateFormat('yyyy-MM-dd').format(newDate));
          },
          child: SizedBox(
            height: sizeFromHeight(6.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "",
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
                    child: Center(
                      child: Text(widget.title),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
