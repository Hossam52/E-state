import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:osol/Shared/constants.dart';
import 'package:osol/Shared/custom_mini_appBar.dart';
import 'package:osol/User/BussinssLogic/unitCubit/unit_cubit.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:osol/User/PresentaionLayer/HomeScreen/units.dart';
import 'package:osol/User/PresentaionLayer/UnitsScreenDetails/units.dart';

class UnitsDetailsScreen extends StatefulWidget {
  @override
  State<UnitsDetailsScreen> createState() => _UnitsDetailsScreenState();
}

class _UnitsDetailsScreenState extends State<UnitsDetailsScreen> {


  TextEditingController writeReviewController = TextEditingController();
  ScrollController scrollController=ScrollController();

  void initState() {
    UnitClientCubit.get(context).unitAllReviewList.clear();
    UnitClientCubit.get(context).zeroId();
    super.initState();
    UnitClientCubit.get(context).getUnitById.call();
    UnitClientCubit.get(context).getAllUnitReview();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UnitClientCubit, UnitClientState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = UnitClientCubit.get(context);
        cubit.getUnitByIdList.isEmpty ? cubit.getUnitById : print("All Data ");
        return Scaffold(
          backgroundColor: ColorManager.WhiteScreen,
          appBar: CustomAppBar(context, "${
              cubit.getUnitByIdList.isEmpty || state is LoadingGetAllReviewState
              ?"Waiting" :
              cubit.getUnitByIdList[0].title}", cubit),
          body: cubit.getUnitByIdList.isEmpty || state is LoadingGetAllReviewState
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : CustomScrollView(
                  physics: BouncingScrollPhysics(),
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
                              physics: BouncingScrollPhysics(),
                              itemCount:
                                  cubit.getUnitByIdList[0].images?.length,
                              itemBuilder: (context, index) {
                                return ListViewDetails(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "${cubit.getUnitByIdList[0].images![index]}",
                                      ),
                                      fit: BoxFit.cover),
                                  txt:
                                      cubit.getUnitByIdList[0].price.toString(),
                                );
                              }),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 5),
                        child: CustomUnitIInformation(
                          backgroundImage: cubit
                                      .getUnitByIdList[0].companyLogo !=
                                  null
                              ? NetworkImage(
                                  "${cubit.getUnitByIdList[0].companyLogo}")
                              : NetworkImage(
                                  "https://royalmazad.com/public/estate_gps/public/uploads/logo.png"),
                          date: '${cubit.getUnitByIdList[0].availableDate}',
                          unitName: cubit.getUnitByIdList[0].companyName != null
                              ? '${cubit.getUnitByIdList[0].companyName}'
                              : "Owner",
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: DetailsLocatioAndNameUnits(
                        lat: "${cubit.getUnitByIdList[0].lat}",
                        long: "${cubit.getUnitByIdList[0].long}",
                        area: "${cubit.getUnitByIdList[0].area}",
                        bathRoom: "${cubit.getUnitByIdList[0].bathroom}",
                        bedRoom: "${cubit.getUnitByIdList[0].bedrooms}",
                        city: "${cubit.getUnitByIdList[0].city}",
                        country: "${cubit.getUnitByIdList[0].country}",
                        location: "${cubit.getUnitByIdList[0].type}",
                        price: "${cubit.getUnitByIdList[0].price}",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20,
                        ),
                        child: CustomUnitdetailsOfUnits(
                          area: "${cubit.getUnitByIdList[0].area}",
                          bathRooms: "${cubit.getUnitByIdList[0].bedrooms}",
                          finishType:
                              "${cubit.getUnitByIdList[0].finishedType}",
                          floor: "${cubit.getUnitByIdList[0].floor}",
                          paymentMethod:
                              "${cubit.getUnitByIdList[0].paymentMethod}",
                          rooms: "${cubit.getUnitByIdList[0].rooms}",
                          seller: "${cubit.getUnitByIdList[0].companyName}",
                          status: "${cubit.getUnitByIdList[0].status}",
                          view: "${cubit.getUnitByIdList[0].view}",
                          yearBuild: "${cubit.getUnitByIdList[0].yearBuild}",
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomDescription(
                        description: "${cubit.getUnitByIdList[0].description}",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomFloatingIcon(
                        phone: cubit.getUnitByIdList[0].lat,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: CustomAboutDeveloper(
                        airCondition:
                            "${cubit.getUnitByIdList[0].airCondition}",
                        bakary: "${cubit.getUnitByIdList[0].bakary}",
                        balcony: "${cubit.getUnitByIdList[0].balcony}",
                        beach: "${cubit.getUnitByIdList[0].beach}",
                        bus: "${cubit.getUnitByIdList[0].bus}",
                        cableTv: "${cubit.getUnitByIdList[0].cableTv}",
                        coffe: "${cubit.getUnitByIdList[0].coffe}",
                        computer: "${cubit.getUnitByIdList[0].computer}",
                        dishwasher: "${cubit.getUnitByIdList[0].dishwasher}",
                        gasLine: "${cubit.getUnitByIdList[0].gasLine}",
                        grill: "${cubit.getUnitByIdList[0].grill}",
                        heater: "${cubit.getUnitByIdList[0].heater}",
                        internet: "${cubit.getUnitByIdList[0].internet}",
                        lift: "${cubit.getUnitByIdList[0].lift}",
                        metro: "${cubit.getUnitByIdList[0].metro}",
                        microwave: "${cubit.getUnitByIdList[0].microwave}",
                        parking: "${cubit.getUnitByIdList[0].parking}",
                        pharmacy: "${cubit.getUnitByIdList[0].pharmacy}",
                        pool: "${cubit.getUnitByIdList[0].pool}",
                        resaurant: "${cubit.getUnitByIdList[0].resturant}",
                        train: "${cubit.getUnitByIdList[0].train}",
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
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
