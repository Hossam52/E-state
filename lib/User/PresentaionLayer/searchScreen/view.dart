import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_states.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/component/search_and_filter_widget.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/unit_bookmark.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/BussinssLogic/savedCubit/saved_cubit.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/HomeScreenView.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/view.dart';
import 'package:osol/common_models/unit_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  void initState() {
    super.initState();
    FilterCubit.instance(context).resetSearchText();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UnitClientCubit()..getAllUnitDetails(context),
      child: BlocBuilder<UnitClientCubit, UnitClientState>(
        builder: (context, state) {
          var cubit = UnitClientCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 80,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey[600],
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              shape: const ContinuousRectangleBorder(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(10)),
              ),
              title: const Text(
                "Results",
              ),
              bottom: PreferredSize(
                preferredSize: Size(60, sizeFromHeight(10)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchAndFilterWidget(
                    onConfirmFilter: () {
                      cubit.getAllUnitDetails(context);
                    },
                    onSearch: () {
                      cubit.getAllUnitDetails(context);
                    },
                  ),
                ),
              ),
            ),
            body: state is ErrorGetUnitClientDetails
                ? CupertinoAlertDialog(
                    title: const Text("Error On Data Loading"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("OK"),
                      )
                    ],
                  )
                : state is LoadingGetAllUnitClientDetails
                    ? const Center(child: CircularProgressIndicator())
                    : cubit.getAllDataList.isEmpty
                        ? const Center(
                            child: Text(
                              "There Is No Data",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: cubit.getAllDataList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  child: HorizontalCard(
                                    unit: cubit.getAllDataList[index],
                                  ));
                            },
                          ),
          );
        },
      ),
    );
  }
}

class HorizontalCard extends StatelessWidget {
  final UnitModel unit;

  HorizontalCard({required this.unit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = UnitClientCubit.get(context);
        return InkWell(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => UnitsDetailsScreen(unitId: unit.id!),
            ),
          ),
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
            child: Container(
                height: sizeFromHeight(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 5),
                        child: Container(
                          width: 80.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(unit.images!.first),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${unit.type}",
                                  style: TextStyle(
                                    color: ColorManager.TextHomeColor,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: UnitBookmark(
                                    unit: unit,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  OsolIcon.location,
                                  color: ColorManager.AppBarIconcolorGrey,
                                  size: 10.w,
                                ),
                                const SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  "${unit.city} , ${unit.country}",
                                  style: TextStyle(fontSize: 10.sp),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text.rich(TextSpan(children: [
                                  TextSpan(
                                    text: "\$ ${unit.price} ",
                                    style: TextStyle(
                                        color: ColorManager.OnBoardingScreen),
                                  ),
                                  const TextSpan(
                                    text: "\\ Mnth",
                                    style: TextStyle(
                                        color: Colors.lightBlueAccent),
                                  )
                                ])),
                              ],
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FaIcon(
                                    OsolIcon.square_,
                                    color: Colors.grey[400],
                                    size: 12,
                                  ),
                                  Text(
                                    "${unit.area} m²",
                                    style: TextStyle(
                                        color: ColorManager.TextHomeColor,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.bath,
                                    color: Colors.grey[400],
                                    size: 12,
                                  ),
                                  Text(
                                    "${unit.bathroom}",
                                    style: TextStyle(
                                        color: ColorManager.TextHomeColor,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.bed,
                                    size: 12,
                                    color: Colors.grey[400],
                                  ),
                                  Text(
                                    "${unit.bedrooms}",
                                    style: TextStyle(
                                        color: ColorManager.TextHomeColor,
                                        fontSize: 12),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "3.5",
                                    style: TextStyle(
                                        color: ColorManager.TextHomeColor,
                                        fontSize: 12),
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    color: ColorManager.starColor,
                                    size: 12,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}

class gridCards extends StatelessWidget {
  int index;

  gridCards({required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavedCubit, SavedState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SavedCubit.get(context);
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.lightBlueAccent, width: 0.5),
              borderRadius: BorderRadius.circular(6)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: cubit.dataUnit == null
                    ? const CircularProgressIndicator()
                    : Container(
                        width: 160.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  cubit.dataUnit[index].images!.first),
                              fit: BoxFit.cover),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        ),
                      ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0, top: 5),
                  child: Text(
                    "${cubit.dataUnit[index].type}",
                    style: TextStyle(
                      color: ColorManager.TextHomeColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Row(
                    children: [
                      Icon(
                        OsolIcon.location,
                        color: ColorManager.AppBarIconcolorGrey,
                        size: 12,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "${cubit.dataUnit[index].companyId} ,${cubit.dataUnit[index].cityId} ",
                        style: const TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "\$ 240 ",
                      style: TextStyle(color: ColorManager.OnBoardingScreen),
                    ),
                    const TextSpan(
                      text: "\\ Mnth",
                      style: TextStyle(color: Colors.lightBlueAccent),
                    )
                  ])),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
// class StackedCustomizeText extends StatelessWidget {
//   List typePro = [
//     "Any",
//     "Apartment",
//     "Duplex",
//     "Office",
//     "Store",
//     "Studio",
//     "Town House",
//     "Twin House",
//     "Penthouse",
//     "Villa",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UnitClientCubit, UnitClientState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = UnitClientCubit.get(context);
//         return Stack(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: sizeFromHeight(9),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black45, width: 1),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: ListView.builder(
//                               itemCount: typePro.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, listIndex) {
//                                 return InkWell(
//                                   onTap: () {
//                                     cubit.changePropType(typePro[listIndex]);
//                                     debugPrint(typePro[listIndex]);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Container(
//                                       decoration: typePro.indexOf(
//                                                   "${cubit.typeFilter}") ==
//                                               listIndex
//                                           ? BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 color: ColorManager
//                                                     .AppBarHomeColorIcon,
//                                               ),
//                                             )
//                                           : null,
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0),
//                                         child: Align(
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               "${typePro[listIndex]}",
//                                               style: TextStyle(
//                                                   fontWeight: typePro.indexOf(
//                                                               "${cubit.typeFilter}") ==
//                                                           listIndex
//                                                       ? FontWeight.bold
//                                                       : null),
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             Positioned(
//               top: 10,
//               left: sizeFromWidth(11),
//               child: Container(
//                 color: ColorManager.WhiteScreen,
//                 height: 20,
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     SvgPicture.asset(
//                       "assets/images/home.svg",
//                     ),
//                     const SizedBox(width: 5),
//                     const Text(
//                       "Property Type",
//                       style: const TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class StackedCustomizeCardPrice extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UnitClientCubit, UnitClientState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = UnitClientCubit.get(context);
//         return Stack(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: sizeFromHeight(9),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black45, width: 1),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 8.0),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Padding(
//                             padding: const EdgeInsets.all(5.0),
//                             child: RangeSlider(
//                               values: RangeValues(cubit.start, cubit.end),
//                               labels: RangeLabels(
//                                   cubit.start.toString(), cubit.end.toString()),
//                               onChanged: (value) {
//                                 cubit.changeRangeSlider(value);
//                               },
//                               min: 0,
//                               max: 100000000,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: Padding(
//                             padding:
//                                 const EdgeInsets.symmetric(horizontal: 15.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("\$${cubit.start.toStringAsFixed(1)}"),
//                                 Text("\$${cubit.end.toStringAsFixed(1)}")
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )),
//             Positioned(
//               top: 10,
//               left: sizeFromWidth(11),
//               child: Container(
//                 color: ColorManager.WhiteScreen,
//                 height: 20,
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     const FaIcon(FontAwesomeIcons.dollarSign),
//                     const SizedBox(width: 5),
//                     const Text(
//                       "Price",
//                       style: TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class StackedCustomrequiredField extends StatelessWidget {
//   List FinishType = [
//     "Any",
//     "without",
//     "Half",
//     "Full",
//     "lux",
//     "Super Lux",
//     "Ultra Luxe",
//     "Deluxe",
//     "Super Deluxe"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UnitClientCubit, UnitClientState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = UnitClientCubit.get(context);
//         return Stack(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: sizeFromHeight(9),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black45, width: 1),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: ListView.builder(
//                               itemCount: FinishType.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, listIndex) {
//                                 return InkWell(
//                                   onTap: () {
//                                     cubit.changeIndexInFilterFinishType(
//                                         FinishType[listIndex]);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Container(
//                                       decoration:
//                                           cubit.filterNewIndexFinishType ==
//                                                   FinishType[listIndex]
//                                               ? BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(5),
//                                                   border: Border.all(
//                                                     color: ColorManager
//                                                         .AppBarHomeColorIcon,
//                                                   ),
//                                                 )
//                                               : null,
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0),
//                                         child: Align(
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               "${FinishType[listIndex]}",
//                                               style: TextStyle(
//                                                   fontWeight:
//                                                       cubit.filterNewIndexFinishType ==
//                                                               FinishType[
//                                                                   listIndex]
//                                                           ? FontWeight.bold
//                                                           : null),
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             Positioned(
//               top: 10,
//               left: sizeFromWidth(11),
//               child: Container(
//                 color: ColorManager.WhiteScreen,
//                 height: 20,
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     SvgPicture.asset(
//                       "assets/images/home.svg",
//                     ),
//                     const SizedBox(width: 5),
//                     const Text(
//                       "Finish Types",
//                       style: const TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class StackedFinishesAndPaints extends StatelessWidget {
//   List requiredField = [
//     "Any",
//     "Vacation",
//     "medical",
//     "commercial",
//     "Residential",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UnitClientCubit, UnitClientState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = UnitClientCubit.get(context);
//         return Stack(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: sizeFromHeight(9),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black45, width: 1),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: ListView.builder(
//                               itemCount: requiredField.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, listIndex) {
//                                 return InkWell(
//                                   onTap: () {
//                                     cubit.changeIndexInFilterrequiredField(
//                                         requiredField[listIndex]);
//                                     debugPrint(requiredField[listIndex]);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Container(
//                                       decoration: cubit.requiredField ==
//                                               requiredField[listIndex]
//                                           ? BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 color: ColorManager
//                                                     .AppBarHomeColorIcon,
//                                               ),
//                                             )
//                                           : null,
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0),
//                                         child: Align(
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               "${requiredField[listIndex]}",
//                                               style: TextStyle(
//                                                   fontWeight:
//                                                       cubit.requiredField ==
//                                                               requiredField[
//                                                                   listIndex]
//                                                           ? FontWeight.bold
//                                                           : null),
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             Positioned(
//               top: 10,
//               left: sizeFromWidth(11),
//               child: Container(
//                 color: ColorManager.WhiteScreen,
//                 height: 20,
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     SvgPicture.asset(
//                       "assets/images/home.svg",
//                     ),
//                     const SizedBox(width: 5),
//                     const Text(
//                       "Required type",
//                       style: TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class PaymentType extends StatelessWidget {
//   int index = 0;
//   int newIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<UnitClientCubit, UnitClientState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = UnitClientCubit.get(context);
//         return Stack(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: sizeFromHeight(9),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black45, width: 1),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10.0, vertical: 10),
//                           child: InkWell(
//                             onTap: () {
//                               cubit.changeIndexInFilter(1);
//                               debugPrint("any");
//                             },
//                             child: Container(
//                               height: sizeFromWidth(9),
//                               width: sizeFromWidth(9),
//                               decoration: cubit.filterNewIndex == 1
//                                   ? BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                           color:
//                                               ColorManager.AppBarHomeColorIcon),
//                                     )
//                                   : null,
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Any",
//                                   style: TextStyle(
//                                       fontWeight: cubit.filterNewIndex == 1
//                                           ? FontWeight.bold
//                                           : null),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10.0, vertical: 10),
//                           child: InkWell(
//                             onTap: () {
//                               cubit.changeIndexInFilter(2);
//                               debugPrint("Cash");
//                             },
//                             child: Container(
//                               height: sizeFromWidth(9),
//                               width: sizeFromWidth(9),
//                               decoration: cubit.filterNewIndex == 2
//                                   ? BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                         color: ColorManager.AppBarHomeColorIcon,
//                                       ),
//                                     )
//                                   : null,
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Text(
//                                   "Cash",
//                                   style: TextStyle(
//                                       fontWeight: cubit.filterNewIndex == 2
//                                           ? FontWeight.bold
//                                           : null),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10.0, vertical: 10),
//                           child: InkWell(
//                             onTap: () {
//                               cubit.changeIndexInFilter(3);
//                               print("Installment");
//                             },
//                             child: Container(
//                               height: sizeFromWidth(9),
//                               width: sizeFromWidth(9),
//                               decoration: cubit.filterNewIndex == 3
//                                   ? BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5),
//                                       border: Border.all(
//                                         color: ColorManager.AppBarHomeColorIcon,
//                                       ),
//                                     )
//                                   : null,
//                               child: Align(
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                     "Installment",
//                                     style: TextStyle(
//                                         fontWeight: cubit.filterNewIndex == 3
//                                             ? FontWeight.bold
//                                             : null),
//                                   )),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             Positioned(
//               top: 10,
//               left: sizeFromWidth(11),
//               child: Container(
//                 color: ColorManager.WhiteScreen,
//                 height: 20,
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     const FaIcon(
//                       FontAwesomeIcons.wallet,
//                       size: 14,
//                       color: Colors.black54,
//                     ),
//                     const SizedBox(width: 5),
//                     const Text(
//                       "Payment gateway",
//                       style: const TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

// class StackedAdvertisor extends StatelessWidget {
//   List advistor = ["Any", "Owner", "Company"];

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<HomeCubit, HomeState>(
//       listener: (context, state) {
//         // TODO: implement listener
//       },
//       builder: (context, state) {
//         var cubit = HomeCubit.get(context);
//         return Stack(
//           children: [
//             Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: sizeFromHeight(9),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     border: Border.all(color: Colors.black45, width: 1),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: ListView.builder(
//                               itemCount: advistor.length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, listIndex) {
//                                 return InkWell(
//                                   onTap: () {
//                                     cubit.changeIndexInAdvistor(listIndex);
//                                   },
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(10.0),
//                                     child: Container(
//                                       decoration: cubit.advistor == listIndex
//                                           ? BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               border: Border.all(
//                                                 color: ColorManager
//                                                     .AppBarHomeColorIcon,
//                                               ),
//                                             )
//                                           : null,
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10.0),
//                                         child: Align(
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               "${advistor[listIndex]}",
//                                               style: TextStyle(
//                                                   fontWeight: cubit.advistor ==
//                                                           listIndex
//                                                       ? FontWeight.bold
//                                                       : null),
//                                             )),
//                                       ),
//                                     ),
//                                   ),
//                                 );
//                               }),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//             Positioned(
//               top: 10,
//               left: sizeFromWidth(11),
//               child: Container(
//                 color: ColorManager.WhiteScreen,
//                 height: 20,
//                 child: Row(
//                   children: [
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     SvgPicture.asset(
//                       "assets/images/home.svg",
//                     ),
//                     const SizedBox(width: 5),
//                     const Text(
//                       "Advertisor",
//                       style: TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
