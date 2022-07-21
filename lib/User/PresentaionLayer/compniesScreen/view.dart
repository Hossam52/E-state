import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  void initState() {
    super.initState();
    AuthCubit.get(context).userToken == null &&
            HomeCubit.get(context).token == null
        ? null
        : CompanyCubit.get(context).getAllComanyData();
  }

  int index = 0;

  int indexBottomSheet = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyCubit, CompanyState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CompanyCubit.get(context);
        return Scaffold(
          appBar: companyAppBar(cubit),
          body: cubit.indexTogleIcons == 0
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: cubit.companyData.length != null
                      ? cubit.companyData.length
                      : 3,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 12),
                        child: CompaniesListView(
                          index: index,
                        ));
                  })
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GridView.builder(
                    itemCount: cubit.companyData.length != null
                        ? cubit.companyData.length
                        : 3,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 2 / 2,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GridCompanies(
                        index: index,
                      );
                    },
                  ),
                ),
        );
      },
    );
  }
}
