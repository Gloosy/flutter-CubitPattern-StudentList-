import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive_animation/data/model/poststudent.dart';
import 'package:rive_animation/data/repository/getrepository.dart';
part 'cubit_post_state.dart';

enum ImageUploadStatus { initial, uploading, success, failure }

class CubitPostImage extends Cubit<PostImage> {
  final ApiRepository apiRepository;
  CubitPostImage({required this.apiRepository}) : super(PostImage());
  // method for image
  void postImage(File imageFile) async {
    var response = await apiRepository.uploadImage(imageFile);
    print("====================== this is Response from API ======================");
    print("Status code from API   : ${response.statusCode}");
    print("Message                : ${response.message}");
    print("Image                  : ${response.data}");
    print("Status                 : ${response.status}");
    emit(response);
  }
}
