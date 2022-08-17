import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Company/PresentationLayer/DawerScreen/view.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/unit_crud_widgets.dart';
import 'package:osol/Company/PresentationLayer/unit_crud/widgets/add_custom_date.dart';
import 'package:osol/Company/businessLogicLayer/bannersCubit/banners_cubit.dart';
import 'package:path/path.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:path_provider/path_provider.dart';

class AddBannerInCompanyScreen extends StatefulWidget {
  @override
  State<AddBannerInCompanyScreen> createState() =>
      _AddBannerInCompanyScreenState();
}

class _AddBannerInCompanyScreenState extends State<AddBannerInCompanyScreen> {
  List<HomeScreenSliderModel> unitDetails = [
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "50%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "70%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "60%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "20%"),
    HomeScreenSliderModel(image: "assets/images/pic5.png", Text: "60%"),
  ];

  TextEditingController titleController = TextEditingController();

  TextEditingController descripController = TextEditingController();

  TextEditingController videoController = TextEditingController();

  GlobalKey<FormState> bannerFormKey = GlobalKey<FormState>();

  navigateFun(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const NavigationDrawerCompany()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BannersCubit(),
      child: BlocBuilder<BannersCubit, BannersState>(
        builder: (context, state) {
          var cubit = BannersCubit.get(context);

          return WillPopScope(
            onWillPop: () {
              return navigateFun(context);
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const NavigationDrawerCompany()));
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 28,
                  ),
                ),
                shape: const ContinuousRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                centerTitle: true,
                title: const Text(
                  "Add Banner",
                ),
              ),
              body: Form(
                key: bannerFormKey,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
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
                          maxLength: 30,
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
                          maxLength: 200,
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
                        child: CustomTxtFieldYoutubeAddUnit(
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return "You Must Enter The Field";
                            }
                            return null;
                          },
                          hint: "Enter the Link",
                          title: "Youtube Video Url",
                          controller: videoController,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: SizedBox(
                          height: sizeFromHeight(10),
                          child: state is LoadingAddBannerState
                              ? const Center(child: CircularProgressIndicator())
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      maximumSize: const Size(double.infinity, 50)),
                                  onPressed: () async {
                                    if (!bannerFormKey.currentState!
                                        .validate()) {
                                      return;
                                    } else {
                                      print("You Enter Valid Date");
                                      await cubit.AddBanner(
                                        context: context,
                                        videoURL: videoController.text,
                                        description: descripController.text,
                                        endDate: cubit.title,
                                        title: titleController.text,
                                      );
                                    }
                                  },
                                  child: const Text(
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
      ),
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        var cubit = BannersCubit.get(context);

        return InkWell(
          onTap: () => ImagePick().then((value) {
            image != null
                ? cubit.changeImageBannerData(imageFile: image)
                : debugPrint("Image Null data");
          }),
          child: SizedBox(
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
                            const Padding(
                              padding: EdgeInsets.all(8.0),
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
