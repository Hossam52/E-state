import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/Customicon.dart';

import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/custom_mini_appBar.dart';
import 'package:osol/Shared/unit_bookmark.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/units.dart';
import 'package:osol/User/PresentaionLayer/compareScreen/view.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';

class UnitsDetailsScreen extends StatefulWidget {
  final int unitId;

  const UnitsDetailsScreen({Key? key, required this.unitId}) : super(key: key);
  @override
  State<UnitsDetailsScreen> createState() => _UnitsDetailsScreenState();
}

class _UnitsDetailsScreenState extends State<UnitsDetailsScreen> {
  TextEditingController writeReviewController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void initState() {
    UnitClientCubit.get(context).unitAllReviewList.clear();
    UnitClientCubit.get(context).zeroId();
    super.initState();
    UnitClientCubit.get(context).getUnitById(widget.unitId);
    UnitClientCubit.get(context).getAllUnitReview();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = UnitClientCubit.get(context);
        return Scaffold(
          backgroundColor: ColorManager.WhiteScreen,
          appBar: _CustomAppBar(
              context,
              "${cubit.unitById == null ? "Waiting" : cubit.unitById!.title}",
              cubit),
          body: cubit.unitById == null
              ? const Center(
                  child: const CircularProgressIndicator(),
                )
              : CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, bottom: 15, left: 20),
                        child: Container(
                          height: sizeFromHeight(3.5),
                          width: sizeFromWidth(1.5),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: cubit.unitById!.images?.length,
                              itemBuilder: (context, index) {
                                return ListViewDetails(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        cubit.unitById!.images![index],
                                      ),
                                      fit: BoxFit.cover),
                                  txt: cubit.unitById!.price.toString(),
                                );
                              }),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 5),
                        child: CustomUnitIInformation(
                          backgroundImage: cubit.unitById!.companyLogo != null
                              ? NetworkImage("${cubit.unitById!.companyLogo}")
                              : const NetworkImage(
                                  "https://royalmazad.com/public/estate_gps/public/uploads/logo.png"),
                          date: '${cubit.unitById!.availableDate}',
                          unitName: cubit.unitById!.companyName != null
                              ? '${cubit.unitById!.companyName}'
                              : "Owner",
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: DetailsLocatioAndNameUnits(
                        lat: "${cubit.unitById!.lat}",
                        long: "${cubit.unitById!.long}",
                        area: "${cubit.unitById!.area}",
                        bathRoom: "${cubit.unitById!.bathroom}",
                        bedRoom: "${cubit.unitById!.bedrooms}",
                        city: "${cubit.unitById!.city}",
                        country: "${cubit.unitById!.country}",
                        location: "${cubit.unitById!.type}",
                        price: "${cubit.unitById!.price}",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20,
                        ),
                        child: CustomUnitdetailsOfUnits(
                          area: "${cubit.unitById!.area}",
                          bathRooms: "${cubit.unitById!.bedrooms}",
                          finishType: "${cubit.unitById!.finishedType}",
                          floor: "${cubit.unitById!.floor}",
                          paymentMethod: "${cubit.unitById!.paymentMethod}",
                          rooms: "${cubit.unitById!.rooms}",
                          seller: "${cubit.unitById!.companyName}",
                          status: "${cubit.unitById!.status}",
                          view: "${cubit.unitById!.view}",
                          yearBuild: "${cubit.unitById!.yearBuild}",
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomDescription(
                        description: "${cubit.unitById!.description}",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomFloatingIcon(
                        phone: cubit.unitById!.lat,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomAboutDeveloper(unit: cubit.unitById!),
                    ),
                    SliverToBoxAdapter(
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: CustomVideo(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: CustomReview(
                          review: cubit.unitAllReviewList,
                        ),
                      ),
                    ),
                    // SliverToBoxAdapter(
                    //   child: Container(
                    //     height: sizeFromHeight(10),
                    //     color: Colors.red,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
                    //         Container(
                    //           width: sizeFromWidth(5),
                    //           child: ListView.builder(
                    //             controller:scrollController ,
                    //             scrollDirection: Axis.horizontal,
                    //             physics:NeverScrollableScrollPhysics() ,
                    //             itemBuilder: (context,index){
                    //             return TextButton(onPressed: (){}, child: Text("${index+1}"));
                    //           },itemCount: cubit.metaUnitReviewLastPage,),
                    //         ),
                    //         IconButton(onPressed: (){
                    //           scrollController.animateTo(sizeFromWidth(1.5) * sizeFromWidth(10),
                    //               duration: const Duration(milliseconds: 800), curve: Curves.easeIn);
                    //         }, icon: Icon(Icons.arrow_forward_ios))
                    //
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: CustomWriteReview(
                          onTap: () {
                            cubit.addUnitReview(
                                reviewBody: writeReviewController.text,
                                starNum: 5);
                            UnitClientCubit.get(context).getAllUnitReview();
                          },
                          controller: writeReviewController,
                        ),
                      ),
                    ),
                  ],
                ),
          // floatingActionButton: CustomFloatingIcon(),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }
}

AppBar _CustomAppBar(BuildContext context, String txt, UnitClientCubit cubit) {
  return AppBar(
    elevation: 0,
    backgroundColor: ColorManager.WhiteScreen,
    toolbarHeight: 80,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black54,
        size: 28,
      ),
    ),
    shape: const ContinuousRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
    ),
    centerTitle: true,
    title: Text(
      txt,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {
          cubit.toggleCompareItem(cubit.unitById!);
          if (cubit.isUnitAddedToCompare(cubit.unitById!)) {
            Fluttertoast.showToast(
              msg: "this unit added to compare List",
              backgroundColor: Colors.green,
            );
          } else {
            Fluttertoast.showToast(
              msg: "This unit removed from compare List",
              backgroundColor: Colors.red,
            );
          }
        },
        icon: cubit.unitById == null
            ? Container()
            : Icon(
                OsolIcon.images,
                color: cubit.isUnitAddedToCompare(cubit.unitById!)
                    ? ColorManager.OnBoardingScreen
                    : ColorManager.AppBarIconcolorGrey,
                size: 20,
              ),
      ),
      IconButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SearchScreen()));
        },
        icon: FaIcon(
          FontAwesomeIcons.shareNodes,
          color: ColorManager.AppBarIconcolorGrey,
        ),
      ),
      cubit.unitById == null
          ? Container()
          : IconButton(
              onPressed: () {
                cubit.toggleFavorite(context, cubit.unitById!);
              },
              icon: UnitBookmark(
                unit: cubit.unitById!,
              ))
    ],
  );
}
