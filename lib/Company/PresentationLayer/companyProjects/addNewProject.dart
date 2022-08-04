import 'dart:io';

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
import 'package:osol/Company/PresentationLayer/registerition/registeration/view.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/unit_crud_widgets.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/widgets/add_custom_date.dart';
import 'package:osol/Company/businessLogicLayer/addNewProjectCubit/add_new_projects_cubit.dart';
import 'package:osol/Company/businessLogicLayer/bannersCubit/banners_cubit.dart';
import 'package:osol/Shared/CustomToast.dart';
import 'package:osol/User/BussinssLogic/companyCubit/company_cubit.dart';
import 'package:path/path.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:intl/src/intl/date_format.dart';
import 'package:path_provider/path_provider.dart';

class AddNewProjectScreen extends StatefulWidget {
  @override
  State<AddNewProjectScreen> createState() => _AddNewProjectScreenState();
}

class _AddNewProjectScreenState extends State<AddNewProjectScreen> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descripController = TextEditingController();
  TextEditingController numberOfUnitController = TextEditingController();

  TextEditingController videoController = TextEditingController();

  GlobalKey<FormState> bannerFormKey = GlobalKey<FormState>();

  navigateFun(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => NavigationDrawerCompany()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNewProjectsCubit, AddNewProjectsState>(
      listener: (context, state) {
        if (state is SuccessAddNewProject) {
          CustomToast(msg: "تمت الاضافه بنجاح", color: Colors.green);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => NavigationDrawerCompany(),
            ),
          );
        }
      },
      builder: (context, state) {
        return BlocBuilder<AddNewProjectsCubit, AddNewProjectsState>(
          builder: (context, state) {
            var cubit = AddNewProjectsCubit.get(context);
            return WillPopScope(
              onWillPop: () {
                return navigateFun(context);
              },
              child: Scaffold(
                backgroundColor: ColorManager.WhiteScreen,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: ColorManager.WhiteScreen,
                  toolbarHeight: 80,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              NavigationDrawerCompany()));
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black54,
                      size: 28,
                    ),
                  ),
                  shape: ContinuousRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                  centerTitle: true,
                  title: Text(
                    "Add New Project",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                body: Form(
                  key: bannerFormKey,
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, bottom: 15, left: 20, right: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300]),
                            height: sizeFromHeight(3),
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
                          child: SelectCustomDate(
                            onDateChange: cubit.changeDate,
                            selectedDate: cubit.title,
                            initialDate: cubit.title,
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
                          child: Container(
                            height: sizeFromHeight(10),
                            child: state is LoadingAddBannerState
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
                                        await cubit.addNewProject(
                                          deliveryDate: cubit.title,
                                          descrip: descripController.text,
                                          numOfUnit:
                                              numberOfUnitController.text,
                                          title: titleController.text,
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Publish",
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
    return BlocBuilder<AddNewProjectsCubit, AddNewProjectsState>(
      builder: (context, state) {
        var cubit = AddNewProjectsCubit.get(context);

        return InkWell(
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
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        height: sizeFromHeight(3),
                        child: Image.file(
                          image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, bottom: 15, left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300]),
                        height: sizeFromHeight(3),
                        child: Stack(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                    "assets/images/imageunit.svg")),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add,
                                size: 40,
                              ),
                            )
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
