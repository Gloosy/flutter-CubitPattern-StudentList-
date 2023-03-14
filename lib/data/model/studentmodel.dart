import 'dart:ffi';

import 'package:flutter/src/widgets/framework.dart';

class StudentListModel {
  int? statusCode;
  String? status;
  String? message;
  List<StudentData>? data;

  StudentListModel({this.statusCode, this.status, this.message, this.data});
  // Method to convert from JSON to Flutter object
  StudentListModel.fromJson(Map json) {
    statusCode = json['statusCode'];
    status     = json['status'];
    message    = json['message'];
    if (json['data'] != null) {
        data = <StudentData>[];
        json['data'].forEach((v) {
        data!.add(new StudentData.fromJson(v));
      });
    }
  }
  // Method to convert to JSON for post method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode']  = this.statusCode;
    data['status']      = this.status;
    data['message']     = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  map(Widget Function(dynamic e) param0) {}

  toList() {}
}


class StudentData {
  String? Id;
  String? name;
  String? DOB;
  String? examDate;
  String? fatherName;
  String? motherName;
  String? profileUrl;

  StudentData(
      {this.Id,
      this.name,
      this.DOB,
      this.examDate,
      this.fatherName,
      this.motherName,
      this.profileUrl});

  StudentData.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    name = json['name'];
    DOB = json['DOB'];
    examDate = json['examDate'];
    fatherName = json['fatherName'];
    motherName = json['motherName'];
    profileUrl = json['profileUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id']         = this.Id;
    data['name']       = this.name;
    data['DOB']        = this.DOB;
    data['examDate']   = this.examDate;
    data['fatherName'] = this.fatherName;
    data['motherName'] = this.motherName;
    data['profileUrl'] = this.profileUrl;
    return data;
  }
}