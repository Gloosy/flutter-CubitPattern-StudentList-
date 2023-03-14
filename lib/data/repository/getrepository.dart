import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive_animation/data/model/poststudent.dart';
import 'package:rive_animation/data/model/updatemodel.dart';
import 'package:rive_animation/data/service/app_url.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rive_animation/data/service/networkservice.dart';
import 'package:sqflite/sqflite.dart';

class ApiRepository {
  final DioService apiService;
  const ApiRepository({required this.apiService});

  // Method to GetPostList Image student

  Future<StudentListModel> getPostList() async {
    var response = await apiService.fetchStudent(AppUrl.getArticles);
    bool results = await InternetConnectionChecker().hasConnection;
    if (results == true) {
      var data = await response?.data;
      if (data != null) {
        var responseData = StudentListModel.fromJson(data);
        return responseData;
      }
      return StudentListModel();
    } else {
      return StudentListModel();
    }
  }
  
  // Method to Upload Image student

  Future<PostImage> uploadImage(File file) async {
    final studentMap =
        await apiService.uploadedMultipleFiles(file, AppUrl.postImage);
    if (studentMap!.data['statusCode'] == 200) {
      var responseData = PostImage.fromJson(studentMap.data);
      print('data response in repository : $responseData');
      return responseData;
    }
    return PostImage();
  }

  // Method to updateInformation student
  
  Future<UpdateInfo> updateInfo(String name, String DOB, String examDate, String fatherName, String motherName) async {
    final studentRespone = await apiService.updateInfo(
        name, DOB, examDate, fatherName, motherName, AppUrl.updateInfo);
    print(studentRespone);
    if (studentRespone?.statusCode == 200) {
      print("Check response in repository ${studentRespone}");
      return studentRespone!.data = UpdateInfo.fromJson(studentRespone.data);
    }
    return UpdateInfo();
  }
}
