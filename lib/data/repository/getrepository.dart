import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive_animation/data/service/app_url.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rive_animation/data/service/getStudent_service.dart';
import 'package:sqflite/sqflite.dart';

class ApiRepository {
  final DioService apiService;
  const ApiRepository({required this.apiService});

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
}
