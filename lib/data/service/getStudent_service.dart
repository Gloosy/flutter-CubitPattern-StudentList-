import 'dart:convert';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/data/repository/getrepository.dart';
import 'app_url.dart';
import 'dart:convert';

class DioService {
  Dio dio = Dio();
  Future<Response?> fetchStudent(String url) async {
    var headers = {
      'appid': 'BEB03CD3-7204-405F-BE41-58EC27F2AEBD',
      'firebase_token':
          'eyJhbGciOiJSUzI1NiIsImtpZCI6IjNmNjcyNDYxOTk4YjJiMzMyYWQ4MTY0ZTFiM2JlN2VkYTY4NDZiMzciLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoiQWRtaW4gV2VjYWZlIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FMbTV3dTM3Y1RNY0RISTU1M0hOSnNkOFQ0MEhpSjBQTkZTVnRNeWVSd3Y1PXM5Ni1jIiwiaXNzIjoiaHR0cHM6Ly9zZWN1cmV0b2tlbi5nb29nbGUuY29tL2FwcC10ZXN0LTIzN2IwIiwiYXVkIjoiYXBwLXRlc3QtMjM3YjAiLCJhdXRoX3RpbWUiOjE2NjY5MTU4NjgsInVzZXJfaWQiOiJDUHRHeGpIM3RtZDZBRWdYODR0SmNEVGtHSXEyIiwic3ViIjoiQ1B0R3hqSDN0bWQ2QUVnWDg0dEpjRFRrR0lxMiIsImlhdCI6MTY2NjkxNTg2OSwiZXhwIjoxNjY2OTE5NDY5LCJlbWFpbCI6IndlY2FmZXRlc3QxQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7Imdvb2dsZS5jb20iOlsiMTAxMDQyNTE4NzQ1NTI5MTIzNDExIl0sImVtYWlsIjpbIndlY2FmZXRlc3QxQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.AUxpv_UpdOIO_M9iHkzQzEkLN7eR',
      'Cookie':
          'ARRAffinity=eef76bc7016e3795417723304454635e1de6050271109330ad17ec80dff7ecae; ARRAffinitySameSite=eef76bc7016e3795417723304454635e1de6050271109330ad17ec80dff7ecae'
    };

    try {
      return await dio.get(url,
          options: Options(
              headers: headers,
              responseType: ResponseType.json,
              method: 'GET'));
    } catch (e) {
      // add more catch
      print(e.toString());
    }
    return null;
  }
}
