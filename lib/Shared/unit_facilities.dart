import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:osol/Shared/component/methods..dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/common_models/unit_model.dart';

class UnitFacilities extends StatelessWidget {
  const UnitFacilities({
    Key? key,
    required this.unit,
    this.height,
  }) : super(key: key);
  final UnitModel unit;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? sizeFromHeight(1.9),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _FacilitySection(
            sectionTitle: 'Distance',
            unit: unit,
            items: [
              _FacilityItem(key: 'Metro', value: unit.metro, measureUnit: 'm'),
              _FacilityItem(key: 'Train', value: unit.train, measureUnit: 'm'),
              _FacilityItem(key: 'Bus', value: unit.bus, measureUnit: 'm'),
              _FacilityItem(
                  key: 'Pharmacy', value: unit.pharmacy, measureUnit: 'm'),
              _FacilityItem(key: 'Beach', value: unit.beach, measureUnit: 'm'),
              _FacilityItem(
                  key: 'Bakary', value: unit.bakary, measureUnit: 'm'),
              _FacilityItem(
                  key: 'Restaurant', value: unit.resturant, measureUnit: 'm'),
              _FacilityItem(key: 'Coffe', value: unit.coffe, measureUnit: 'm'),
            ],
          ),
          _FacilitySection(
            sectionTitle: 'Indoor',
            unit: unit,
            items: [
              _FacilityItem(key: 'Air Conditioning', value: unit.airCondition),
              _FacilityItem(key: 'Cable Tv', value: unit.cableTv),
              _FacilityItem(key: 'Computer', value: unit.computer),
              _FacilityItem(key: 'Gas line', value: unit.gasLine),
              _FacilityItem(key: 'Dishwasher', value: unit.dishwasher),
              _FacilityItem(key: 'Internet', value: unit.internet),
              _FacilityItem(key: 'Heater', value: unit.heater),
              _FacilityItem(key: 'Microwave', value: unit.microwave),
            ],
          ),
          _FacilitySection(
            sectionTitle: 'Outdoor',
            unit: unit,
            items: [
              _FacilityItem(key: 'Balcony', value: unit.balcony),
              _FacilityItem(key: 'Lift', value: unit.lift),
              _FacilityItem(key: 'Grill', value: unit.grill),
              _FacilityItem(key: 'Pool', value: unit.pool),
              _FacilityItem(key: 'Parking', value: unit.parking),
            ],
          ),
        ],
      ),
    );
  }
}

class _FacilitySection extends StatelessWidget {
  const _FacilitySection({
    Key? key,
    required this.unit,
    required this.sectionTitle,
    required this.items,
  }) : super(key: key);
  final String sectionTitle;
  final UnitModel unit;
  final List<_FacilityItem> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8,
        right: 16,
      ),
      child: Container(
        height: sizeFromHeight(2.2),
        width: sizeFromWidth(1.3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Text(
                sectionTitle,
                style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .headline2
                        ?.color
                        ?.withOpacity(0.9)),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int index = 0;
                            index < 5 && index < items.length;
                            index++)
                          if (index <= items.length - 1)
                            _FacilityItemWidget(
                              item: items[index],
                            ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey,
                    width: 2,
                    height: sizeFromHeight(3.2),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (int index = min(5, items.length);
                            index < 10 && index < items.length;
                            index++)
                          if (index <= items.length - 1)
                            _FacilityItemWidget(item: items[index]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FacilityItemWidget extends StatelessWidget {
  const _FacilityItemWidget({Key? key, required this.item}) : super(key: key);
  final _FacilityItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: SizedBox(
        height: 50.h,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(item.key,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: isDark(context)
                          ? Colors.white70
                          : ColorManager.onboardingColorDots)),
            ),
            Expanded(
              child: Text(getValue,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline4),
            ),
          ],
        ),
      ),
    );
  }

  String get getValue {
    if (item.value == null) return 'N/A';
    if (item.measureUnit != null) {
      return item.value.toString() + ' ' + item.measureUnit!;
    } else {
      return item.value;
    }
  }
}

class _FacilityItem {
  final String key;
  final dynamic value;
  final String? measureUnit;

  _FacilityItem({
    required this.key,
    required this.value,
    this.measureUnit,
  });
}
