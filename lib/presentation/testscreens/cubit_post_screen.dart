import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive_animation/cubit/post/cubit_post_cubit.dart';
import 'package:rive_animation/data/model/poststudent.dart';
import 'package:rive_animation/data/repository/getrepository.dart';
import 'package:rive_animation/data/service/networkservice.dart';
import 'package:rive_animation/presentation/screens/entryPoint/components/imagepicker.dart';
import 'package:rive_animation/utils/responsive.dart';

class CubitPostScreen extends StatefulWidget {
  const CubitPostScreen({Key? key}) : super(key: key);

  @override
  _CubitPostScreenState createState() => _CubitPostScreenState();
}

class _CubitPostScreenState extends State<CubitPostScreen> {
  final screenCubit =
      CubitPostImage(apiRepository: ApiRepository(apiService: DioService()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      body: Container(
        height: Responsive.height(100, context),
        width: double.infinity,
        margin: EdgeInsets.only(top: Responsive.height(200, context)),
        child: Center(
          child: Column(children: [
            ElevatedButton(
              onPressed: () {
                final imageUploadCubit = context.read<CubitPostImage>();
                // TODO: Call uploadImage with the selected file
                // For example: imageUploadCubit.uploadImage(selectedFile);
                //final List<int> byteList = utf8.encode(imageUrl);
                //Image image = Image.asset('assets/Images/img.png');
                XFile file = XFile('assets/icons/code.svg');

                imageUploadCubit.postImage(file);

              },
              child: Text('Upload Image'),
            ),
            BlocBuilder<CubitPostImage, PostImage>(
              builder: (context, state) {
                if (state.data == 200) {
                  return Center(child: Text('Image uploaded successfully!'));
                } else if (state == ImageUploadStatus.success) {
                  return Center(child: Text('Image uploaded not successfully'));
                }
                return Container();
              },
            ),
          ]),
        ),
      ),
      */
      body: ImagePickerView(),
    );
  }
}
