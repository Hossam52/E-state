import 'dart:io';
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
import 'package:osol/Company/businessLogicLayer/compayProject/company_project_cubit.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class UpdateProjectScreen extends StatefulWidget {
  @override
  State<UpdateProjectScreen> createState() => _UpdateProjectScreenState();
}

class _UpdateProjectScreenState extends State<UpdateProjectScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descripController = TextEditingController();
  TextEditingController numberOfUnitController = TextEditingController();

  TextEditingController videoController = TextEditingController();

  GlobalKey<FormState> bannerFormKey = GlobalKey<FormState>();

  navigateFun(context) {
    // CompanyProjectCubit.get(context).getAllCompanyProjects();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyProjectCubit, CompanyProjectState>(
      listener: (context, state) {
        if (state is SuccessUpdateProjectDataState) {
          CustomToast(msg: "تمت التعديل بنجاح بنجاح", color: Colors.green);
          CompanyProjectCubit.get(context).getAllCompanyProjects();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => CompanyProjectScreen(),
            ),
          );
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
              onWillPop: () {
                return navigateFun(context);
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
                    physics: NeverScrollableScrollPhysics(),
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
                            height: sizeFromHeight(8),
                            child: CustomIAddBannerImageCompanies(),
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
                          child: CustomAddDateToBanner(
                            hint: '',
                            title: 'Pick The Delivery Date',
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
                          child: Container(
                            height: sizeFromHeight(10),
                            child: state is LoadingUpdateProjectstate
                                ? Center(child: CircularProgressIndicator())
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        maximumSize: Size(double.infinity, 50)),
                                    onPressed: () async {
                                      if (!bannerFormKey.currentState!
                                          .validate()) {
                                        return;
                                      } else {
                                        print("You Enter Valid Date");
                                        await cubit.UpdateProjectsOfCampany(
                                          deliveryDate: cubit.title,
                                          descrip: descripController.text,
                                          numOfUnit:
                                              numberOfUnitController.text,
                                          title: titleController.text,
                                          id: cubit.id,
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Save Changes",
                                      style: TextStyle(
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
    );
  }
}

class CustomTxtFieldAddUnit extends StatelessWidget {
  String hint;
  String title;
  TextEditingController controller;
  String? Function(String?)? validator;

  CustomTxtFieldAddUnit(
      {required this.title,
      required this.hint,
      required this.controller,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ],
          ),
          Container(
            height: sizeFromHeight(13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.CompareConatainer,
            ),
            child: TextFormField(
              validator: validator,
              controller: controller,
              decoration: InputDecoration(
                  hintText: "${hint}",
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

class CustomTxtFieldYoutubeAddUnit extends StatelessWidget {
  String hint;
  String title;
  TextEditingController controller;
  String? Function(String?)? validator;

  CustomTxtFieldYoutubeAddUnit({
    required this.title,
    required this.hint,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeFromHeight(6.5),
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
                validator: validator,
                controller: controller,
                decoration: InputDecoration(
                    hintText: "${hint}",
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: FaIcon(FontAwesomeIcons.link),
                    ),
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

class CustomAddDateToBanner extends StatefulWidget {
  String hint;
  String title;

  CustomAddDateToBanner({required this.title, required this.hint});

  @override
  State<CustomAddDateToBanner> createState() => _CustomAddDateToBannerState();
}

class _CustomAddDateToBannerState extends State<CustomAddDateToBanner> {
  DateTime date = DateTime(2022, 12, 24);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyProjectCubit, CompanyProjectState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = CompanyProjectCubit.get(context);
        return Container(
          height: sizeFromHeight(9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Container(
                height: sizeFromHeight(13),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.CompareConatainer,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime(1990),
                          lastDate: DateTime(2100));
                      if (newDate == null) return;
                      setState(() {
                        date = newDate;
                        widget.title = DateFormat('yyyy-MM-dd').format(newDate);
                      });
                      cubit
                          .changeDate(DateFormat('yyyy-MM-dd').format(newDate));
                    },
                    child: Container(
                      height: sizeFromHeight(16),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.CompareConatainer,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                        ),
                        child: Center(
                          child: Text(
                            "${widget.title}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomIAddBannerImageCompanies extends StatefulWidget {
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
          msg: "${e.toString()}",
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyProjectCubit, CompanyProjectState>(
      builder: (context, state) {
        var cubit = CompanyProjectCubit.get(context);

        return Container(
          child: InkWell(
            onTap: () => ImagePick().then((value) {
              image != null
                  ? cubit.changeImageData(imageFile: image)
                  : debugPrint("Image Null data");
            }),
            child: Container(
              height: sizeFromHeight(8),
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                                  icon: Icon(
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
                                      height: sizeFromHeight(8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "assets/images/pic1.png",
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                    Positioned(
                                      top: sizeFromHeight(25),
                                      bottom: 0,
                                      right: 0,
                                      child: IconButton(
                                          onPressed: () {},
                                          icon: FaIcon(
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
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
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
                                  icon: Icon(
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
          ),
        );
      },
    );
  }
}
