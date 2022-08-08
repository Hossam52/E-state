import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:osol/Company/PresentationLayer/companyProjects/updateProject.dart';
import 'package:osol/Company/businessLogicLayer/compayProject/company_project_cubit.dart';
import 'package:osol/Company/dataLayer/dataModel/projectsOfCompany/ProjectsofCompany.dart';
import 'package:osol/Shared/Customicon.dart';
import 'package:osol/Shared/component/methods..dart';
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
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            shape: const ContinuousRectangleBorder(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(10)),
            ),
            centerTitle: true,
            title: const Text(
              "Company Projects",
            ),
          ),
          body: state is LoadingGetAllProjects
              ? const Center(child: const CircularProgressIndicator())
              : ListView.builder(
                  itemCount: cubit.dataOfProjects.length,
                  itemBuilder: (context, index) {
                    return _ProjectItem(
                      project: cubit.dataOfProjects[index],
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
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class _ProjectItem extends StatelessWidget {
  const _ProjectItem({Key? key, required this.project}) : super(key: key);
  final DataOfProjects project;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            color: getDarkmoodColor(context).withOpacity(0.54),
            borderRadius: BorderRadius.circular(
              15,
            ),
          ),
          clipBehavior: Clip.hardEdge,
          height: sizeFromHeight(3),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 6,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: _projectImage(),
                            ),
                            Expanded(
                              flex: 5,
                              child: _projectData(),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: _projectDesc(),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    CompanyProjectCubit.get(context)
                        .changeId(newId: project.id);
                    print("id vall:${project.id}");
                  },
                  child: CustomBottomSheet(
                    project: project,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectDesc() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${project.description}",
          maxLines: 5,
          style: Theme.of(context).textTheme.headline4,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
        ),
      );
    });
  }

  Widget _projectData() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${project.title}",
                style: Theme.of(context).textTheme.headline2),
            _details(
                icon: OsolIcon.location,
                iconColor: Colors.red,
                title: '${project.city} , ${project.country}'),
            _details(
                icon: FontAwesomeIcons.bagShopping,
                title: '${project.deliveryDate}'),
            _details(icon: OsolIcon.home_3, title: '${project.description}'),
          ],
        ),
      );
    });
  }

  Widget _details({
    required IconData icon,
    required String title,
    Color iconColor = Colors.black,
  }) {
    return Builder(builder: (context) {
      return Row(
        children: [
          FaIcon(
            icon,
            color: iconColor,
            size: 14,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      );
    });
  }

  Padding _projectImage() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(project.image.toString()), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}

///Show Model Bottom Sheet

class CustomBottomSheet extends StatefulWidget {
  final DataOfProjects project;
  CustomBottomSheet({required this.project});

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    int indexBottomSheet = 0;
    return InkWell(
      onTap: () {
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
            child: UpdateProjectScreen(
              project: widget.project,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          size: 28,
          color: getInvertDarkmoodColor(context),
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
            style: const TextStyle(
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
                    border: const OutlineInputBorder(
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
            style: const TextStyle(
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
                border: const OutlineInputBorder(
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
