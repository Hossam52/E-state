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
import 'package:osol/Company/businessLogicLayer/bannersCubit/banners_cubit.dart';
import 'package:path/path.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/Model/modelOfData/onBoardingModel.dart';
import 'package:intl/src/intl/date_format.dart';
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
        builder: (BuildContext context) => NavigationDrawerCompany()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        var cubit = BannersCubit.get(context);

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
                "Add Banner",
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
                      child: CustomAddDateToBanner(
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
                      child: Container(
                        height: sizeFromHeight(10),
                        child: state is LoadingAddBannerState
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    maximumSize: Size(double.infinity, 50)),
                                onPressed: () async {
                                  if (!bannerFormKey.currentState!.validate()) {
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
      height: sizeFromHeight(6.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              Text(
                "0/150",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Container(
            height: sizeFromHeight(10),
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
    return BlocConsumer<BannersCubit, BannersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = BannersCubit.get(context);
        return Container(
          height: sizeFromHeight(6.5),
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
                height: sizeFromHeight(10),
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
                      height: sizeFromHeight(15),
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
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        var cubit = BannersCubit.get(context);

        return InkWell(
          onTap: () => ImagePick().then((value) {
            image != null
                ? cubit.changeImageBannerData(imageFile: image)
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
