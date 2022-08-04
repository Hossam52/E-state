import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/PresentationLayer/companyProjects/view.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/unit_crud_widgets.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/widgets/add_custom_date.dart';
import 'package:osol/Company/businessLogicLayer/compayProject/company_project_cubit.dart';
import 'package:osol/Company/dataLayer/dataModel/projectsOfCompany/ProjectsofCompany.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UpdateProjectScreen extends StatefulWidget {
  final DataOfProjects project;

  const UpdateProjectScreen({Key? key, required this.project})
      : super(key: key);
  @override
  State<UpdateProjectScreen> createState() => _UpdateProjectScreenState();
}

class _UpdateProjectScreenState extends State<UpdateProjectScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descripController = TextEditingController();
  TextEditingController numberOfUnitController = TextEditingController();

  GlobalKey<FormState> bannerFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.project.title ?? '';
    descripController.text = widget.project.description ?? '';
    numberOfUnitController.text = widget.project.numOfUnits ?? '';
  }

  navigateFun(context) {
    // CompanyProjectCubit.get(context).getAllCompanyProjects();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyProjectCubit()
        ..date = widget.project.deliveryDate == null
            ? ''
            : DateFormat('yyyy-MM-dd').format(
                DateTime.tryParse(widget.project.deliveryDate!) ??
                    DateTime.now()),
      child: BlocConsumer<CompanyProjectCubit, CompanyProjectState>(
        listener: (companyProjectsContext, state) {
          if (state is SuccessUpdateProjectDataState) {
            CustomToast(msg: "تمت التعديل بنجاح بنجاح", color: Colors.green);
            CompanyProjectCubit.get(context).getAllCompanyProjects();
            Navigator.pop(context);
          }
          if (state is SuccessDeleteProject) {
            CompanyProjectCubit.get(context).getAllCompanyProjects();
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return BlocBuilder<CompanyProjectCubit, CompanyProjectState>(
            builder: (context, state) {
              var cubit = CompanyProjectCubit.get(context);

              return WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0))),
                  child: Form(
                    key: bannerFormKey,
                    child: CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 15.0,
                              bottom: 15,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: sizeFromHeight(6),
                              child: CustomIAddBannerImageCompanies(
                                  project: widget.project),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            child: CustomTxtFieldAddUnit(
                              validator: (String? v) {
                                if (v!.isEmpty) {
                                  return "You Must Enter The Field";
                                }
                                return null;
                              },
                              controller: titleController,
                              hint: 'change name',
                              title: "Main Title",
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            child: CustomTxtFieldAddUnit(
                              validator: (String? v) {
                                if (v!.isEmpty) {
                                  return "You Must Enter The Field";
                                }
                                return null;
                              },
                              hint: 'change name',
                              title: "Description",
                              controller: descripController,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            child: SelectCustomDate(
                              onDateChange: cubit.changeDate,
                              selectedDate: cubit.date,
                              initialDate: cubit.date,
                              hint: '',
                              title: 'Pick The Date',
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            child: CustomTxtFieldAddUnit(
                              validator: (String? v) {
                                if (v!.isEmpty) {
                                  return "You Must Enter The Field";
                                }
                                return null;
                              },
                              hint: 'Number of unit',
                              title: "Units",
                              controller: numberOfUnitController,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20),
                            child: SizedBox(
                              height: sizeFromHeight(10),
                              child: state is LoadingUpdateProjectstate
                                  ? const Center(
                                      child: const CircularProgressIndicator())
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          maximumSize:
                                              const Size(double.infinity, 50)),
                                      onPressed: () async {
                                        if (bannerFormKey.currentState!
                                            .validate()) {
                                          await cubit.UpdateProjectsOfCampany(
                                            deliveryDate: cubit.date,
                                            descrip: descripController.text,
                                            numOfUnit:
                                                numberOfUnitController.text,
                                            title: titleController.text,
                                            id: widget.project.id,
                                          );
                                        } else {
                                          print("You Enter Valid Date");
                                        }
                                      },
                                      child: const Text(
                                        "Save Changes",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CustomIAddBannerImageCompanies extends StatefulWidget {
  final DataOfProjects project;

  const CustomIAddBannerImageCompanies({Key? key, required this.project})
      : super(key: key);
  @override
  State<CustomIAddBannerImageCompanies> createState() =>
      _CustomIAddBannerImageCompaniesState();
}

class _CustomIAddBannerImageCompaniesState
    extends State<CustomIAddBannerImageCompanies> {
  File? image;

  Future ImagePick() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = await saveImagePermanently(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");
    return File(imagePath).copy(image.path);
  }

  Future<void> pickImage(CompanyProjectCubit cubit) async {
    ImagePick().then((value) {
      image != null
          ? cubit.changeImageData(imageFile: image)
          : debugPrint("Image Null data");
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyProjectCubit, CompanyProjectState>(
      builder: (context, state) {
        var cubit = CompanyProjectCubit.get(context);

        return InkWell(
          onTap: () => pickImage(cubit),
          child: SizedBox(
            height: sizeFromHeight(6),
            width: 327.w,
            child: Container(
              child: image != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15, left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: sizeFromHeight(8),
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "Edit Current image",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  cubit.deleteProject(projectId: cubit.id);
                                },
                              ))
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15, left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: sizeFromHeight(8),
                              child: Stack(
                                children: [
                                  Container(
                                    height: sizeFromHeight(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: widget.project.image == null
                                          ? null
                                          : DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  widget.project.image!),
                                              fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    // top: sizeFromHeight(25),
                                    bottom: 0,
                                    right: 0,
                                    child: IconButton(
                                        onPressed: () => pickImage(cubit),
                                        icon: const FaIcon(
                                          FontAwesomeIcons.pen,
                                          color: Colors.white,
                                          size: 18,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "Edit Current image",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 30,
                                ),
                                onPressed: () {
                                  cubit.deleteProject(projectId: cubit.id);
                                },
                              ))
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
