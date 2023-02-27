import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rive_animation/data/service/app_url.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rive_animation/data/service/getStudent_service.dart';

class ApiRepository {
  final DioService apiService;
  const ApiRepository({required this.apiService});

  Future<List<StudentListModel>?> getPostList() async {
    var response = await apiService.fetchStudent(AppUrl.getArticles);
    //List<StudentListModel> data = ;
    bool results = await InternetConnectionChecker().hasConnection;
    if (response != null && results == true) {
      var responseMap = response.data as Map<String, dynamic>;

      var responseList = responseMap['data'] as List<dynamic>;

      print("repository response : ${responseList} ");
      var responseData =
          responseList.map((e) => StudentListModel.fromJson(e)).toList();
      print("Return response data : ${responseData}");
      return responseData;
    } else {
      print("Error repository");
    }
  }
}
