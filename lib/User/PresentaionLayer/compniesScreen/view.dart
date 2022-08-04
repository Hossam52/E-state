import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osol/Company/businessLogicLayer/filter_cubit/filter_cubit.dart';
import 'package:osol/Shared/component/search_and_filter_widget.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import 'package:osol/User/BussinssLogic/homeCubit/home_cubit.dart';
import 'package:osol/User/PresentaionLayer/compniesScreen/units.dart';
import '../../BussinssLogic/authCubit/auth_cubit.dart';

class CompaniesViewData extends StatefulWidget {
  @override
  State<CompaniesViewData> createState() => _CompaniesViewDataState();
}

class _CompaniesViewDataState extends State<CompaniesViewData> {
  @override
  void initState() {
    super.initState();
    FilterCubit.instance(context).resetSearchText();
    AuthCubit.get(context).userToken == null &&
            HomeCubit.get(context).token == null
        ? null
        : CompanyCubit.get(context).getAllComanyData(context);
  }

  int index = 0;

  int indexBottomSheet = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyCubit, CompanyState>(
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);
        return Scaffold(
          appBar: companyAppBar(cubit),
          body: cubit.indexTogleIcons == 0
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: cubit.companyData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 12),
                        child: CompaniesListView(
                          company: cubit.companyData[index],
                        ));
                  })
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    itemCount: cubit.companyData.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 2 / 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GridCompanies(
                        company: cubit.companyData[index],
                      );
                    },
                  ),
                ),
        );
      },
    );
  }

  AppBar companyAppBar(cubit) {
    return AppBar(
      bottom: PreferredSize(
        preferredSize: const Size(50, 10),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        flex: 9,
                        child: SearchAndFilterWidget(
                          displayFilterDialog: false,
                          onSearch: () {
                            log('Hello');
                            CompanyCubit.get(context).getAllComanyData(context);
                          },
                        )
                        // Container(
                        //   height: sizeFromHeight(16),
                        //   decoration: BoxDecoration(
                        //       color: Colors.grey[200],
                        //       borderRadius: BorderRadius.circular(
                        //         5,
                        //       )),
                        //   child: TextFormField(
                        //     cursorColor: Colors.grey[500],
                        //     cursorHeight: sizeFromHeight(17),
                        //     decoration: InputDecoration(
                        //       contentPadding: EdgeInsets.only(
                        //         left: 10,
                        //       ),
                        //       border: InputBorder.none,
                        //       suffixIcon: Icon(
                        //         Icons.search,
                        //         color: Colors.grey[500],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: sizeFromHeight(16),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.AppBarIconcolorGrey,
                                width: 1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  cubit.changeTogleIconsState(0);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: sizeFromHeight(14.5),
                                    child: cubit.indexTogleIcons == 0
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
                                  cubit.changeTogleIconsState(1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height: sizeFromHeight(14.5),
                                    child: cubit.indexTogleIcons == 0
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
