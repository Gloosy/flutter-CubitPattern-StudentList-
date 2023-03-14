import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rive_animation/cubit/post/cubit_post_cubit.dart';
import 'package:rive_animation/data/model/poststudent.dart';
import 'package:rive_animation/data/repository/getrepository.dart';
import 'package:rive_animation/data/service/networkservice.dart';
import 'package:rive_animation/utils/responsive.dart';

class ImagePickerView extends StatefulWidget {
  const ImagePickerView({Key? key}) : super(key: key);
  @override
  State<ImagePickerView> createState() => _ImagePickerViewState();
}

class _ImagePickerViewState extends State<ImagePickerView> {
  ImagePicker picker = ImagePicker();
  File? _image;

  Future<void> _picker(ImageSource source, BuildContext context) async {
    try {
      final imageUploadCubit = context.read<CubitPostImage>();
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      //File img = File(image.path);
      setState(() {
        _image = File(pickedImage.path);
        // method to upload image \\
        // ======================== \\
        //imageUploadCubit.postImage(File(pickedImage.path));
      });
    } on PlatformException catch (e) {
      print(e.toString());
      //Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _picker(ImageSource.gallery, context),
      // Image tapped
      child: Container(
        //alignment: Alignment.topCenter,
        margin: EdgeInsets.only(
            top: Responsive.height(30, context),
            left: Responsive.width(66, context)),
        height: Responsive.height(100, context),
        width: Responsive.width(100, context),
        child: Column(
          children: [
            _image == null
                ? Container(child: Image.asset('assets/Images/img.png'))
                : Container(
                    height: Responsive.height(350, context),
                    width: Responsive.width(250, context),
                    child: Container(
                        margin: EdgeInsets.only(
                            bottom: Responsive.height(90, context),
                            //left: Responsive.width(10, context)
                        ),
                        height: Responsive.height(700, context),
                        width: Responsive.width(700, context),
                        child: Image.file(_image! as File)),
                  ),
          ],
        ),
      ),
    );
  }
}

/*
  Widget buttomSheet(BuildContext context) {
    return Container(
      height: Responsive.height(100, context),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
      ),
      child: Column(
        children: <Widget>[ 
          Text('Choose Profile Photo',
          style: TextStyle(fontSize: Responsive.fontSize(20.0, context)),
          
          ),
          SizedBox(
            height: Responsive.height(20, context),
          ),
          Row(
            children: <Widget>[
              Flat3dButton.icon(
                icon: Icons.camera,
                onPressed: () {

                },
                
              ),
              Flat3dButton.icon(
                icon: Icons.camera,
                onPressed: () {

                },
              ),
            ],
          )
        
      ]),
    );
  }
  */

