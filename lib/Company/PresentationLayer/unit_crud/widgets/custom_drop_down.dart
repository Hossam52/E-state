import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';

class CustomDropDownList extends StatelessWidget {
  final String title;
  final void Function(String? val)? onChange;
  final List<String> list;
  final String? selectedItem;

  const CustomDropDownList({
    Key? key,
    required this.title,
    required this.onChange,
    this.selectedItem,
    this.list = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return SizedBox(
          height: sizeFromHeight(6.5),
          width: sizeFromWidth(2.4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: Theme.of(context).textTheme.headline3!)
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
                  child: DropdownButton(
                    value: selectedItem,
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: const Text("Select"),
                    items: list.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: onChange,
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
