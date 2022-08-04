import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Company/businessLogicLayer/unitsCubit/unit_cubit.dart';
import 'package:osol/Shared/constants.dart';

class SelectUnitImages extends StatefulWidget {
  SelectUnitImages({Key? key}) : super(key: key);

  @override
  State<SelectUnitImages> createState() => SelectUnitImagesState();
}

class SelectUnitImagesState extends State<SelectUnitImages> {
  List<XFile>? imageFileList = [];

  void ImagePick() async {
    imageFileList!.clear();
    try {
      final List<XFile>? imagePick = await ImagePicker().pickMultiImage();
      if (imagePick!.isNotEmpty) {
        imageFileList!.addAll(imagePick);
      }
      debugPrint("ImageLength: ${imageFileList!.length}");
      setState(() {});
      changeImageData();
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

  changeImageData() {
    imageFileList!.isNotEmpty
        ? UnitCubit.get(this.context).changeImageData(imageFile: imageFileList)
        : null;

    UnitCubit.get(this.context).imageData!.isNotEmpty
        ? UnitCubit.get(this.context).changeListData()
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ImagePick(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
        height: sizeFromHeight(2),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: imageFileList!.isNotEmpty
                    ? CarouselSlider.builder(
                        itemCount: imageFileList?.length ?? 0,
                        itemBuilder: (_, index, __) => Image.file(
                          File(imageFileList![index].path),
                          fit: BoxFit.fill,
                        ),
                        options: CarouselOptions(
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            viewportFraction: 1,
                            enableInfiniteScroll: false,
                            height: double.infinity),
                      )
                    : SvgPicture.asset("assets/images/imageunit.svg")),
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
    );
  }
}
