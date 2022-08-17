
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/component/methods..dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/common_models/unit_model.dart';

class DistanceList extends StatefulWidget {
  const DistanceList({Key? key, required this.unit}) : super(key: key);

  @override
  State<DistanceList> createState() => _DistanceListState();
  final UnitModel? unit;
}

class _DistanceListState extends State<DistanceList> {
  TextEditingController trainController = TextEditingController();

  TextEditingController metroController = TextEditingController();

  TextEditingController busController = TextEditingController();

  TextEditingController pharmacyController = TextEditingController();

  TextEditingController coffeController = TextEditingController();

  TextEditingController restController = TextEditingController();

  TextEditingController backeryController = TextEditingController();

  TextEditingController beachController = TextEditingController();

  @override
  void initState() {
    super.initState();
    trainController.text = widget.unit?.train?.toString() ?? '';
    busController.text = widget.unit?.bus?.toString() ?? '';
    metroController.text = widget.unit?.metro?.toString() ?? '';
    pharmacyController.text = widget.unit?.pharmacy?.toString() ?? '';
    coffeController.text = widget.unit?.coffe?.toString() ?? '';
    restController.text = widget.unit?.resturant?.toString() ?? '';
    backeryController.text = widget.unit?.bakary?.toString() ?? '';
    beachController.text = widget.unit?.beach?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            primary: true,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Distance",
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .headline1
                          ?.color
                          ?.withOpacity(0.9)),
                ),
                _DistanceItem(
                    title: 'Train',
                    controller: trainController,
                    onChanged: cubit.changeDistanceToTrain,
                    icon: FontAwesomeIcons.trainSubway,
                    measureUnit: 'M'),
                _DistanceItem(
                    title: 'Metro',
                    controller: metroController,
                    onChanged: cubit.changeDistanceToMetro,
                    svgPath: "assets/images/train.svg",
                    measureUnit: 'M'),
                _DistanceItem(
                    title: 'Bus',
                    controller: busController,
                    onChanged: cubit.changeDistanceToBus,
                    icon: FontAwesomeIcons.vanShuttle,
                    measureUnit: 'M'),
                _DistanceItem(
                    title: 'Pharamacy',
                    controller: pharmacyController,
                    onChanged: cubit.changeDistanceToPharmacy,
                    svgPath: "assets/images/pharmacy.svg",
                    measureUnit: 'M'),
                _DistanceItem(
                    title: 'Coffee',
                    controller: coffeController,
                    onChanged: cubit.changeDistanceToCoffe,
                    svgPath: "assets/images/coffe.svg",
                    measureUnit: 'M'),
                _DistanceItem(
                    title: 'Resturant',
                    controller: restController,
                    onChanged: cubit.changeDistanceRest,
                    svgPath: "assets/images/rest.svg",
                    measureUnit: 'M'),
                _DistanceItem(
                    title: 'Bakery',
                    controller: backeryController,
                    onChanged: cubit.changeDistanceToBakary,
                    svgPath: "assets/images/backery.svg",
                    measureUnit: 'M'),
                _DistanceItem(
                    title: 'Beach',
                    controller: beachController,
                    onChanged: cubit.changeDistanceToBeach,
                    svgPath: "assets/images/beach.svg",
                    measureUnit: 'M'),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _DistanceItem extends StatelessWidget {
  const _DistanceItem({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.title,
    this.svgPath,
    this.icon,
    this.measureUnit,
  }) : super(key: key);
  final String title;
  final String? svgPath;
  final IconData? icon;
  final String? measureUnit;
  final Function(String) onChanged;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? FaIcon(icon!,
              color: isDark(context)
                  ? Colors.white70
                  : ColorManager.onboardingColorDots)
          : svgPath != null
              ? SvgPicture.asset(
                  svgPath!,
                  color: isDark(context)
                      ? Colors.white70
                      : ColorManager.onboardingColorDots,
                  width: 20,
                )
              : null,
      title: Text(title,
          style: Theme.of(context).textTheme.headline3!.copyWith(
              color: isDark(context)
                  ? Colors.white70
                  : ColorManager.onboardingColorDots)),
      trailing: _TextField(
        onChanged: onChanged,
        controller: controller,
        measureUnit: measureUnit,
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    required this.onChanged,
    required this.controller,
    this.measureUnit = '',
  }) : super(key: key);

  final Function(String p1) onChanged;
  final TextEditingController controller;
  final String? measureUnit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: sizeFromWidth(4),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 1,
                  color: getInvertDarkmoodColor(context).withOpacity(0.76),
                )),
            height: sizeFromHeight(18),
            width: sizeFromWidth(5.5),
            child: TextFormField(
              onChanged: onChanged,
              controller: controller,
              style: Theme.of(context).textTheme.headline4,
              cursorColor: Colors.black54,
              cursorHeight: 20,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                borderSide: BorderSide.none,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(measureUnit!,
                style: Theme.of(context).textTheme.headline2),
          ),
        ],
      ),
    );
  }
}
