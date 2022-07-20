import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/companyProjects/updateProject.dart';
import 'package:osol/Company/businessLogicLayer/compayProject/company_project_cubit.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/constants.dart';

import 'addNewProject.dart';

class CompanyProjectScreen extends StatefulWidget {
  const CompanyProjectScreen({Key? key}) : super(key: key);

  @override
  State<CompanyProjectScreen> createState() => _CompanyProjectScreenState();
}

class _CompanyProjectScreenState extends State<CompanyProjectScreen> {
  @override
  void initState() {
    CompanyProjectCubit.get(context).getAllCompanyProjects();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyProjectCubit, CompanyProjectState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = CompanyProjectCubit.get(context);
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
              "Company Projects",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          body: state is LoadingGetAllProjects
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: cubit.dataOfProjects.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                            color: Colors.white,
                          ),
                          height: sizeFromHeight(3),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 6,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            cubit
                                                                .dataOfProjects[
                                                                    index]
                                                                .image
                                                                .toString()),
                                                        fit: BoxFit.cover),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${cubit.dataOfProjects[index].title}",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          FaIcon(
                                                            OsolIcon.location,
                                                            color: Colors.red,
                                                            size: 14,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "${cubit.dataOfProjects[index].city} ,${cubit.dataOfProjects[index].country}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    10.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          FaIcon(
                                                            FontAwesomeIcons
                                                                .bagShopping,
                                                            size: 14,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            "${cubit.dataOfProjects[index].deliveryDate}",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    10.sp),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          FaIcon(
                                                            OsolIcon.home_3,
                                                            color: Colors.black,
                                                            size: 14,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            width:
                                                                sizeFromWidth(
                                                                    3),
                                                            child: Text(
                                                              "${cubit.dataOfProjects[index].description}",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      10.sp),
                                                              maxLines: 1,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Text(
                                              "${cubit.dataOfProjects[index].description}",
                                              maxLines: 5,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                              ),
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    cubit.changeId(
                                        newId: cubit.dataOfProjects[index].id);
                                    print(
                                        "id vall:${cubit.dataOfProjects[index].id}");
                                  },
                                  child: CustomBottomSheet(
                                    index: index,
                                    cubit: cubit,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AddNewProjectScreen(),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}

///Show Model Bottom Sheet

class CustomBottomSheet extends StatefulWidget {
  CompanyProjectCubit cubit;
  int index;

  CustomBottomSheet({
    required this.cubit,
    required this.index,
  });

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    int indexBottomSheet = 0;
    return InkWell(
      onTap: () {
        widget.cubit
            .changeId(newId: widget.cubit.dataOfProjects[widget.index].id);
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          isScrollControlled: true,
          enableDrag: true,
          context: context,
          builder: (BuildContext context) => Container(
            height: sizeFromHeight(1.1),
            width: 42.w,
            child: UpdateProjectScreen(),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 28,
          color: ColorManager.OnBoardingScreen,
        ),
      ),
    );
  }
}

class CustomTxtFieldCompanyProject extends StatelessWidget {
  String hint;
  String title;
  double width;

  CustomTxtFieldCompanyProject({
    required this.title,
    required this.hint,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
      width: width == 0 ? double.infinity : width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Container(
            height: sizeFromHeight(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: Center(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "${hint}",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTxtFieldDescription extends StatelessWidget {
  String hint;
  String title;

  CustomTxtFieldDescription({required this.title, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(4.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            height: 100,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "$hint",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
