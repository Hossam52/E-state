import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/BussinssLogic/commonCubit/common_cubit.dart';
import 'package:osol/User/PresentaionLayer/RegisterScreen/signUp/view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Company/PresentationLayer/registerition/registeration/view.dart';
import '../../../Shared/constants.dart';
import '../../BussinssLogic/commonCubit/common_cubit.dart';
import '../../BussinssLogic/commonCubit/profieCubit/profile_cubit.dart';
import '../RegisterScreen/signUp/view.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController NameController = TextEditingController();

  TextEditingController NumController = TextEditingController();

  GlobalKey<FormState> myForm = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var cubit = ProfileCubit.get(context);
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) async {
        if (state is SuccessUploadStatus) {
          await ProfileCubit.get(context).getProfileData();
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Update Profile",
            ),
          ),
          body: cubit.profileDate.isEmpty
              ? const CupertinoActivityIndicator(
                  color: Colors.blue,
                )
              : Form(
                  key: myForm,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 5),
                          child: UploadNewImage(),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomTxtFieldCompanyProfile(
                            controller: NameController,
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return "You must enter Your Name";
                              }
                              return null;
                            },
                            hint: "${cubit.profileDate[0].client!.userName}",
                            title: "Change Name",
                            width: 0,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          child: CustomSelectListGender(
                            title: "Gender",
                            myList: const ["Male", "Female"],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: BlocBuilder<CommonCubit, CommonState>(
                            builder: (context, state) {
                              var cubit = CommonCubit.get(context);
                              return Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: CustomSelectListRegister(
                                        myList: cubit.countryData,
                                        title: "Country",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: CustomSelectListCities(
                                        myList: cubit.cityData,
                                        title: "City",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10,
                          ),
                          child: CustomTxtFieldCompanyProfile(
                            controller: NumController,
                            validator: (String? v) {
                              return null;
                            },
                            hint: "${cubit.profileDate[0].client!.phone}",
                            title: "Phone Number",
                            width: 0,
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10,
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(
                                        double.infinity, sizeFromHeight(11))),
                                onPressed: () async {
                                  cubit.updateProfile(
                                    name: NameController.text == null
                                        ? cubit.profileDate[0].client!.userName
                                            .toString()
                                        : NameController.text.toString(),
                                    cityId: CommonCubit.get(context)
                                        .cityIndex
                                        .toString(),
                                    countryId: CommonCubit.get(context)
                                        .valueCountryId
                                        .toString(),
                                    gender: "0",
                                    phone: NumController.text == null
                                        ? cubit.profileDate[0].client!.phone
                                            .toString()
                                        : NumController.text.toString(),
                                  );
                                },
                                child: const Text("Update Profile"),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class UploadNewImage extends StatefulWidget {
  const UploadNewImage({Key? key}) : super(key: key);

  @override
  State<UploadNewImage> createState() => _UploadNewImageState();
}

class _UploadNewImageState extends State<UploadNewImage> {
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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);

        return InkWell(
          onTap: () => ImagePick().then((value) {
            image != null
                ? cubit.changeImageData(imageFile: image)
                : debugPrint("Image Null data");
          }),
          child: SizedBox(
            height: sizeFromHeight(8),
            width: 327.w,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        sizeFromWidth(11),
                      ),
                      border: image != null
                          ? null
                          : Border.all(
                              color: ColorManager.onboardingColorDots)),
                  child: image != null
                      ? CircleAvatar(
                          radius: sizeFromWidth(12),
                          child: Image.file(
                            image!,
                            fit: BoxFit.cover,
                          ))
                      : CircleAvatar(
                          radius: sizeFromWidth(12),
                          child: image != null
                              ? Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                )
                              : SvgPicture.asset(
                                  "assets/images/upimage.svg",
                                )),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Icon(Icons.add),
                ),
                Text(
                  "Upload Personal Image",
                  style: Theme.of(context).textTheme.headline2,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
