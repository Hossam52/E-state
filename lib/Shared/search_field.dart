import 'package:flutter/material.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/shared/constants.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({Key? key, required this.onSeach, this.textFieldColor})
      : super(key: key);
  final VoidCallback onSeach;
  final Color? textFieldColor;
  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(12),
      decoration: BoxDecoration(
          color: widget.textFieldColor ?? Colors.grey[200]?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(
            10,
          )),
      child: TextFormField(
        controller: searchController,
        onEditingComplete: () {
          FilterCubit.instance(context)
              .onChangeSearchText(searchController.text);
          widget.onSeach();
        },
        cursorColor: Colors.grey[500],
        cursorHeight: sizeFromHeight(17),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            bottom: 15,
            left: 10,
          ),
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.search,
            color: Colors.grey[500],
          ),
        ),
      ),
    );
  }
}
