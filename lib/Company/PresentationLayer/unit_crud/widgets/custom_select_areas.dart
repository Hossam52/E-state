import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/countryModel/modelOfData.dart';

class AddUnitSelectListAreas extends StatelessWidget {
  String title = "";
  List<Areas> myList;

  AddUnitSelectListAreas({
    required this.myList,
    required this.title,
  });

  String? dropDownMenuCities;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommonCubit, CommonState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CommonCubit.get(context);
        return Container(
          height: sizeFromHeight(10),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorManager.CompareConatainer,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 8,
            ),
            child: DropdownButton<Areas>(
              isExpanded: true,
              value: cubit.newAreasValue,
              underline: const SizedBox(),
              hint: Text(title),
              items: myList.map((Areas value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value.name!),
                );
              }).toList(),
              onChanged: (value) {
                cubit.changeSelectedAreas(value);
                cubit.areaIndex = value?.id;
              },
            ),
          ),
        );
      },
    );
  }
}
