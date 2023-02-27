
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerView extends StatefulWidget {
  const ImagePickerView({Key? key}) : super(key: key);
  @override
  State<ImagePickerView> createState() => _ImagePickerViewState();
}

class _ImagePickerViewState extends State<ImagePickerView> {
  ImagePicker picker = ImagePicker();
  XFile? _image;
  Future _picker(ImageSource source) async {
    try{
      final image = await ImagePicker().pickImage(source: source);
      if(image == null) return ;
      XFile img = XFile(image.path);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e){
      print(e);
      Navigator.of(context).pop();
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _picker(ImageSource.gallery),
       // Image tapped
      child: Container(
        child: Column(
          children: [
            _image == null?Container(
              child: Image.asset('assets/Images/img.png')
            ): Image.file(_image! as File),
          ],
        ),
      ),
    );
  }
}


