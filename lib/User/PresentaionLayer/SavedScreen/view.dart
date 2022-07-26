import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/savedCubit/saved_cubit.dart';
import 'package:osol/User/PresentaionLayer/searchScreen/view.dart';

class SavedScreen extends StatefulWidget {
  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  void initState() {
    SavedCubit.get(context).dataUnit.clear();
    SavedCubit.get(context).getMySavedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SavedCubit, SavedState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SavedCubit.get(context);
        print("${cubit.dataUnit.length}");
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.grey,
              ),
            ),

            // toolbarHeight: 70,
            centerTitle: true,
            title: const Text(
              "Saved",
            ),
          ),
          body: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: Column(
                    children: [
                      // SearchAndFilterWidget(
                      //   onConfirmFilter: () {
                      //     cubit.getMySavedData();
                      //   },
                      //   onSearch: () {},
                      // ),
                      // Container(
                      //   height: sizeFromHeight(14),
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         children: [
                      //           Expanded(
                      //             flex: 7,
                      //             child: Container(
                      //               height: sizeFromHeight(15),
                      //               decoration: BoxDecoration(
                      //                   color: Colors.grey[200],
                      //                   borderRadius: BorderRadius.circular(
                      //                     10,
                      //                   )),
                      //               child: TextFormField(
                      //                 cursorColor: Colors.grey[500],
                      //                 cursorHeight: sizeFromHeight(17),
                      //                 decoration: InputDecoration(
                      //                   contentPadding: EdgeInsets.only(
                      //                     bottom: 15,
                      //                     left: 10,
                      //                   ),
                      //                   border: InputBorder.none,
                      //                   suffixIcon: Icon(
                      //                     Icons.search,
                      //                     color: Colors.grey[500],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           SizedBox(
                      //             width: 5,
                      //           ),
                      //           Expanded(
                      //             flex: 1,
                      //             child: InkWell(
                      //               onTap: () {
                      //                 showMaterialModalBottomSheet(
                      //                   enableDrag: true,
                      //                   builder: (context) => FilterDialog(
                      //                     onConfirmFilter: () {
                      //                       cubit.dataUnit.clear();
                      //                       cubit.getMySavedData();
                      //                     },
                      //                   ),
                      //                   context: context,
                      //                   shape: RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.vertical(
                      //                       top: Radius.circular(20),
                      //                     ),
                      //                   ),
                      //                 );
                      //               },
                      //               child: Container(
                      //                 height: sizeFromHeight(15),
                      //                 width: sizeFromWidth(8),
                      //                 decoration: BoxDecoration(
                      //                   color: ColorManager.AppBarHomeColorIcon,
                      //                   borderRadius: BorderRadius.circular(10),
                      //                 ),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: SvgPicture.asset(
                      //                     "assets/images/slider.svg",
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${cubit.dataUnit.length} Result Found",
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 8,
                            ),
                            child: Container(
                              height: sizeFromHeight(16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: ColorManager.AppBarIconcolorGrey,
                                    width: 1),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      cubit.changeTogleSavedState(0);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SizedBox(
                                        height: sizeFromHeight(14.5),
                                        child: cubit.toggleSaved == 0
                                            ? SvgPicture.asset(
                                                "assets/images/viewstream.svg",
                                              )
                                            : SvgPicture.asset(
                                                "assets/images/viewstreamgray.svg",
                                              ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: sizeFromHeight(14.5),
                                      width: 1,
                                      color: ColorManager.AppBarIconcolorGrey,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      cubit.changeTogleSavedState(1);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: SizedBox(
                                        height: sizeFromHeight(14.5),
                                        child: cubit.toggleSaved == 0
                                            ? SvgPicture.asset(
                                                "assets/images/menutogle.svg",
                                              )
                                            : SvgPicture.asset(
                                                "assets/images/coloredgridview.svg",
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: cubit.toggleSaved == 0
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: cubit.dataUnit.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, right: 20),
                              child: HorizontalCard(
                                unit: cubit.dataUnit[index],
                              ));
                        })
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GridView.builder(
                          itemCount: cubit.dataUnit.length,
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            childAspectRatio: 2.5 / 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return gridCards(
                              index: index,
                            );
                          },
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

AppBar CustomAppBar(context, txt) {
  return AppBar(
    elevation: 0,
    toolbarHeight: 80,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(
        Icons.arrow_back,
        size: 28,
      ),
    ),
    shape: const ContinuousRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
    ),
    centerTitle: true,
    title: Text(
      "$txt",
    ),
  );
}
