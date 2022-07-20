import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';

class DistanceList extends StatefulWidget {
  @override
  State<DistanceList> createState() => _DistanceListState();
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
  Widget build(BuildContext context) {
    return BlocBuilder<UnitCubit, UnitState>(
      builder: (context, state) {
        var cubit = UnitCubit.get(context);
        return Container(
          height: double.infinity,
          child: SingleChildScrollView(
            primary: true,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Distance",
                  style: TextStyle(
                      color: ColorManager.onboardingColorDots,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.trainSubway,
                    color: Colors.black54,
                  ),
                  title: Text("train"),
                  trailing: Container(
                    height: 40,
                    width: sizeFromWidth(4),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          height: sizeFromHeight(18),
                          width: sizeFromWidth(5.5),
                          child: TextFormField(
                            onChanged: (String v) {
                              cubit.changeDistanceToTrain(v);
                            },
                            controller: trainController,
                            cursorColor: Colors.black54,
                            cursorHeight: 20,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset("assets/images/train.svg"),
                  title: Text("Metro"),
                  trailing: Container(
                    height: 40,
                    width: sizeFromWidth(4),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          height: sizeFromHeight(18),
                          width: sizeFromWidth(5.5),
                          child: TextFormField(
                            onChanged: (String v) {
                              cubit.changeDistanceToMetro(v);
                            },
                            controller: metroController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black54,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: FaIcon(
                    FontAwesomeIcons.vanShuttle,
                    color: Colors.black54,
                  ),
                  title: Text("Bus"),
                  trailing: Container(
                    height: 40,
                    width: sizeFromWidth(4),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          height: sizeFromHeight(18),
                          width: sizeFromWidth(5.5),
                          child: TextFormField(
                            onChanged: (String v) {
                              cubit.changeDistanceToBus(v);
                            },
                            controller: busController,
                            keyboardType: TextInputType.number,
                            cursorColor: Colors.black54,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/pharmacy.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  title: Text("Pharmacy"),
                  trailing: Container(
                    height: 40,
                    width: sizeFromWidth(4),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          height: sizeFromHeight(18),
                          width: sizeFromWidth(5.5),
                          child: TextFormField(
                            onChanged: (String v) {
                              cubit.changeDistanceToPharmacy(v);
                            },
                            controller: pharmacyController,
                            cursorColor: Colors.black54,
                            keyboardType: TextInputType.number,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/coffe.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  title: Text("Coffe"),
                  trailing: Container(
                    height: 40,
                    width: sizeFromWidth(4),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          height: sizeFromHeight(18),
                          width: sizeFromWidth(5.5),
                          child: TextFormField(
                            onChanged: (String v) {
                              cubit.changeDistanceToCoffe(v);
                            },
                            keyboardType: TextInputType.number,
                            controller: coffeController,
                            cursorColor: Colors.black54,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/rest.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  title: Text("Restaurant"),
                  trailing: Container(
                    height: 40,
                    width: sizeFromWidth(4),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          height: sizeFromHeight(18),
                          width: sizeFromWidth(5.5),
                          child: TextFormField(
                            onChanged: (String v) {
                              cubit.changeDistanceRest(v);
                            },
                            keyboardType: TextInputType.number,
                            controller: restController,
                            cursorColor: Colors.black54,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/backery.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  title: Text("Bakary"),
                  trailing: Container(
                    height: 40,
                    width: sizeFromWidth(4),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          height: sizeFromHeight(18),
                          width: sizeFromWidth(5.5),
                          child: TextFormField(
                            onChanged: (String v) {
                              cubit.changeDistanceToBakary(v);
                            },
                            keyboardType: TextInputType.number,
                            controller: backeryController,
                            cursorColor: Colors.black54,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/beach.svg",
                    color: Colors.black54,
                    width: 20,
                  ),
                  title: Text("Beach"),
                  trailing: Container(
                    height: 40,
                    width: sizeFromWidth(4),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.black54,
                              )),
                          height: sizeFromHeight(18),
                          width: sizeFromWidth(5.5),
                          child: TextFormField(
                            onChanged: (String v) {
                              cubit.changeDistanceToBeach(v);
                            },
                            keyboardType: TextInputType.number,
                            controller: beachController,
                            cursorColor: Colors.black54,
                            cursorHeight: 20,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "M",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
