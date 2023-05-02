import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';

class ApiProvider{

  final Dio _dio=Dio();

  Future<MultipartFile> uploadFile(Uint8List file, String name) async {
    return MultipartFile.fromBytes(file,
        filename: name, contentType: MediaType("image", "png"));
  }

  Future<dynamic> helpAndSupport(
      List<Uint8List>? pics, String message) async {
    try {
      List<MultipartFile> pictures = [];
      Map<String, dynamic> map = HashMap();
      if (pics!.isNotEmpty) {
        for (var i = 0; i < pics.length; i++) {
          if (pics[i].isNotEmpty) {
            pictures.add(await uploadFile(
                pics[i], "${DateTime.now().microsecondsSinceEpoch}"));
          }
        }
      }
      print("--------------$pictures");
      map["image"] = pictures;
      map["message"] = message;
      final sendData = FormData.fromMap(map);
      Response response = await _dio.post("http://202.164.42.227:8047/api/help_support", options:getHeaderToken(), data: sendData);
      return response;
    } catch (error) {
      final res = (error as dynamic).response;
      print(res);
    }
  }


  static Options? getHeaderToken() {
    String? token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6ODIsImVtYWlsIjoiYWxvazFAeW9wbWFpbC5jb20iLCJqdGkiOjE2ODMwMjgwNTMyMTgsImlhdCI6MTY4MzAyODA1MywiZXhwIjoxNjgzMTE0NDUzfQ.MW_iUz0k9eCcG0GD0WPQhAdja2oD9UFGMpztF9loFPU";
    if (token != null) {
      var headerOptions = Options(headers: {
        'Authorization': 'Bearer $token',
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials": true, // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"

      });
      return headerOptions;
    }
    return null;
  }

}
