import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:osol/Shared/component/filter_dialog.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/search_field.dart';

class SearchAndFilterWidget extends StatelessWidget {
  const SearchAndFilterWidget({
    Key? key,
    this.onSearch,
    this.onConfirmFilter,
    this.textFieldColor,
    this.displayFilterDialog = true,
  }) : super(key: key);
  final VoidCallback? onSearch;
  final VoidCallback? onConfirmFilter;
  final Color? textFieldColor;
  final bool displayFilterDialog;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: sizeFromHeight(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                    flex: 6,
                    child: AppSearchField(
                      textFieldColor: textFieldColor,
                      onSeach: () => onSearch == null ? null : onSearch!(),
                    )),
                const SizedBox(
                  width: 5,
                ),
                if (displayFilterDialog)
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        showMaterialModalBottomSheet(
                          isDismissible: true,
                          animationCurve: Curves.bounceInOut,
                          enableDrag: true,
                          builder: (_) => FilterDialog(
                              onConfirmFilter: () => onConfirmFilter == null
                                  ? null
                                  : onConfirmFilter!()),
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: sizeFromHeight(12),
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
        ),
      ],
    );
  }
}
