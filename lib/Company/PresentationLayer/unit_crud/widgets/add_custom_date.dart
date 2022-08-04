import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:osol/shared/constants.dart';
import 'package:intl/intl.dart';

class SelectCustomDate extends StatefulWidget {
  final String hint;
  final String title;
  final void Function(String) onDateChange;
  final String? initialDate;
  final String selectedDate;

  SelectCustomDate(
      {Key? key,
      required this.title,
      required this.hint,
      required this.onDateChange,
      this.initialDate,
      this.selectedDate = ''})
      : super(key: key);

  @override
  State<SelectCustomDate> createState() => _SelectCustomDateState();
}

class _SelectCustomDateState extends State<SelectCustomDate> {
  DateTime date = DateTime(2022, 12, 24);

  @override
  Widget build(BuildContext context) {
    print(widget.selectedDate.toString());
    return SizedBox(
      height: sizeFromHeight(9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Container(
            height: sizeFromHeight(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: Center(
              child: InkWell(
                onTap: () async {
                  log(widget.initialDate.toString());
                  DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: widget.initialDate == null ||
                              widget.initialDate!.isEmpty
                          ? DateTime.now()
                          : DateTime.tryParse(widget.initialDate!) ??
                              DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100));
                  if (newDate == null) return;
                  setState(() {
                    date = newDate;
                    // widget.title = DateFormat('yyyy-MM-dd').format(newDate);
                  });
                  widget.onDateChange(DateFormat('yyyy-MM-dd').format(newDate));
                },
                child: Container(
                  height: sizeFromHeight(16),
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
                      child: Text(
                        widget.selectedDate.isEmpty
                            ? widget.title
                            : widget.selectedDate,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
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
