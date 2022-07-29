import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/common_models/unit_model.dart';

import '../../../Shared/Customicon.dart';
import '../../BussinssLogic/authCubit/auth_cubit.dart';
import '../../BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import '../../BussinssLogic/unitCubit/unit_cubit.dart';
import '../UnitsScreenDetails/view.dart';

class FeatureViewAllScreen extends StatefulWidget {
  @override
  State<FeatureViewAllScreen> createState() => _FeatureViewAllScreenState();
}

class _FeatureViewAllScreenState extends State<FeatureViewAllScreen> {
  @override
  Widget build(BuildContext context) {
    var cubit3 = AuthCubit.get(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        final features = cubit.featuresUnits;
        return Scaffold(
          backgroundColor: ColorManager.WhiteScreen,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: ColorManager.WhiteScreen,
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black54,
                size: 28,
              ),
            ),
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            centerTitle: true,
            title: Text(
              "All Features",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            actions: [],
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 4,
              childAspectRatio: 1.8 / 1.9,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10),
                child: features.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : InkWell(
                        onTap: cubit3.userToken == null && cubit.myToken == null
                            ? () {}
                            : () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => UnitsDetailsScreen(
                                      unitId: features[index].id!,
                                    ),
                                  ),
                                );
                              },
                        child: CardHomeFeatureView(
                          unit: features[index],
                        ),
                      ),
              );
            },
            itemCount: features.length,
          ),
        );
      },
    );
  }
}

class CardHomeFeatureView extends StatelessWidget {
  CardHomeFeatureView({required this.unit});
  final UnitModel unit;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent, width: 0.5),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 5,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            unit.images!.first,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 2),
                        child: Text(
                          unit.type!,
                          style: TextStyle(
                            color: ColorManager.TextHomeColor,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                        child: Container(
                          width: sizeFromWidth(3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                  text:
                                      "\$ ${unit.price == null ? 0 : unit.price.toString().length >= 6 ? unit.price.toString().substring(0, 1) : unit.price.toString()} ${unit.price.toString().length > 3 && unit.price.toString().length < 6 ? "K" : unit.price.toString().length > 6 && unit.price.toString().length < 9 ? "M" : "B"}",
                                  style: TextStyle(
                                      color: ColorManager.OnBoardingScreen),
                                ),
                                TextSpan(
                                  text: "\\ Mnth",
                                  style:
                                      TextStyle(color: Colors.lightBlueAccent),
                                )
                              ])),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Icon(
                              OsolIcon.location,
                              color: ColorManager.AppBarIconcolorGrey,
                              size: 16,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${unit.city} , ${unit.country}",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorManager.homeColorFeature,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: FaIcon(
                                OsolIcon.square_,
                                color: Colors.grey[400],
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${unit.area} m²",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: FaIcon(
                                FontAwesomeIcons.bath,
                                color: Colors.grey[400],
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${unit.bathroom}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: FaIcon(
                                FontAwesomeIcons.bed,
                                size: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "${unit.bedrooms}",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidStar,
                                color: ColorManager.starColor,
                                size: 12,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              "3.4",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
