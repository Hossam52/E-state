import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osol/Shared/constants.dart';
import 'package:osol/User/DataLayer/DataProvider/dioHelper.dart';

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  DioHelper api = DioHelper();
  File _image = File("");
  TextEditingController _txtNameImage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.file_upload),
            onPressed: () {
              uploadImage(_image);
            },
          )
        ],
      ),
      body: _formUpload(),
    );
  }

  Widget _formUpload() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          TextField(
            controller: _txtNameImage,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(hintText: "Nama Image"),
            maxLength: 9,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: _image == null
                ? Text('No Images Selected')
                : Image.file(_image),
          ),
          SizedBox(
            height: 50.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Icon(Icons.camera),
                onPressed: () => getImageCamera(),
              ),
              SizedBox(
                width: 50.0,
              ),
              RaisedButton(
                child: Icon(Icons.image),
                onPressed: () => getImageGallery(),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<String> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    Response response = await DioHelper.postData(data: {
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    }, url: authRegisterURL);
    return response.data['id'];
  }

  getImageGallery() async {
    var imageFile =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = imageFile as File;
    });
  }

  getImageCamera() async {
    var imageFile =
        await ImagePicker.platform.pickImage(source: ImageSource.camera);
    setState(() {
      _image = imageFile as File;
    });
  }
}
