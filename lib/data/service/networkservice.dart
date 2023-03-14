import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:rive_animation/data/model/studentmodel.dart';
import 'package:rive_animation/data/model/updatemodel.dart';
import 'package:rive_animation/data/repository/getrepository.dart';
import 'app_url.dart';
import 'dart:convert';

class DioService {
  Dio dio = Dio();

  Future<Response?> updateInfo(String name, String DOB, String examDate, String fatherName,
      String motherName, String url) async {
    //Dio dio = Dio();
    var headers = {
      'appid': 'BEB03CD3-7204-405F-BE41-58EC27F2AEBD',
      'Content-Type': 'application/json',
      'Cookie':
          'ARRAffinity=eef76bc7016e3795417723304454635e1de6050271109330ad17ec80dff7ecae; ARRAffinitySameSite=eef76bc7016e3795417723304454635e1de6050271109330ad17ec80dff7ecae'
    };
     var formData = {
        "Id"        : "1,360",
        "name"      : name,
        "DOB"       : DOB,
        "examDate"  : examDate,
        "fatherName": fatherName,
        "motherName": motherName
    };

    try {
      // var response to post basically your url
      var response = await dio.post(url,
          data: formData,
          options: Options(headers: headers, responseType: ResponseType.json));
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            "==================>>>>>   Error response   <<<<<==================");
      } else if (e.type == DioErrorType.connectionTimeout) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            "==================>>>>>   Error Timeout   <<<<<==================");
      } else if (e.type == DioErrorType.receiveTimeout) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            '==================>>>>>   unable to connect to the server   <<<<<==================');
      }
      // add more catch
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // method for upload file image
  Future<Response?> uploadedMultipleFiles(File file, String url) async {
    var headers = {
      'appid': 'BEB03CD3-7204-405F-BE41-58EC27F2AEBD',
      'Cookie':
          'ARRAffinity=eef76bc7016e3795417723304454635e1de6050271109330ad17ec80dff7ecae; ARRAffinitySameSite=eef76bc7016e3795417723304454635e1de6050271109330ad17ec80dff7ecae'
    };

    try {
      String fileName = file.path.split('/').last;

      var formData = FormData.fromMap({
        // upload only one image
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      // var response to post basically your url
      var response = await dio.post(url,
          data: formData, options: Options(headers: headers));
      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            "==================>>>>>   Error response   <<<<<==================");
      } else if (e.type == DioErrorType.connectionTimeout) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            "==================>>>>>   Error Timeout   <<<<<==================");
      } else if (e.type == DioErrorType.receiveTimeout) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            '==================>>>>>   unable to connect to the server   <<<<<==================');
      }
      // add more catch
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // method for fetch or get data from api
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
    } on DioError catch (e) {
      if (e.type == DioErrorType.badResponse) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            "==================>>>>>   Error response   <<<<<==================");
      } else if (e.type == DioErrorType.connectionTimeout) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            "==================>>>>>   Error Timeout   <<<<<==================");
      } else if (e.type == DioErrorType.receiveTimeout) {
        print(
            "/////////////////////////////////////////////////////////////////////////////////");
        print(
            '==================>>>>>   unable to connect to the server   <<<<<==================');
      }
      // add more catch
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
