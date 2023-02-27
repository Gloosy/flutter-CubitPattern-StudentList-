import 'dart:convert';
import 'dart:io';
import 'package:rive_animation/data/app_exception.dart';
import 'package:http/http.dart' as http;
class NetworkApiService {
  //dynamic responseJson;
  dynamic responseJson;

  Future<dynamic> getAll(String url) async{
    try{
      var response = await http.get(Uri.parse(url));
      responseJson = returnJsonResponse(response);
    }on SocketException{
      throw FetchDataException('no internet connection');
    }
    return responseJson;
  }
  dynamic returnJsonResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        return jsonDecode(response.body);
      case 400: 
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnAuthorizedException(response.body.toString());
      default:
        throw FetchDataException('unexception error occured');
    }
  }
}