import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_states.dart';
import 'package:osol/Shared/component/filter_dialog.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';

import 'constants.dart';
import 'customFloatingFilteButton.dart';

class CustomBottomAppBar extends StatelessWidget {
  Color color;

  CustomBottomAppBar({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(9),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 10,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Container(
                height: sizeFromHeight(14),
                decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(
                      10,
                    )),
                child: TextFormField(
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
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showMaterialModalBottomSheet(
                    enableDrag: true,
                    builder: (context) => FilterDialog(
                      onConfirmFilter: () {
                        UnitClientCubit.get(context).getAllDataList.clear();
                        UnitClientCubit.get(context).getAllUnitDetails(context);
                      },
                    ),
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: sizeFromHeight(14),
                  width: sizeFromWidth(8),
                  decoration: BoxDecoration(
                    color: ColorManager.AppBarHomeColorIcon,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      "assets/images/slider.svg",
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
