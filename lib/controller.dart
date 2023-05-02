import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'api_provider.dart';

class ControllerImage extends GetxController{

  RxList<Uint8List> picturesSentList = RxList();
  RxList<String> picturesShowPath = RxList();
  var indexPic = 0.obs;

  Future<void> openGalleryWeb() async {
    List<XFile>? _path;
    try {
      _path = await ImagePicker().pickMultiImage(imageQuality: 10);
    } catch (e) {
      print(e.toString());
    }

    if (_path != null) {
      for (var element in _path) {
        final bytes = await element.readAsBytes();
        picturesSentList.value.add(bytes);
        picturesShowPath.add(element.path);
      }
      picturesShowPath.refresh();
    }
  }

  openCamera(int index) {
    indexPic.value = index;
    openGalleryWeb();
  }


  Future initHelpSupport(String message) async {
    if(picturesSentList.isNotEmpty){
      var response = await ApiProvider().helpAndSupport(picturesSentList.value, message);
      print(response);
    }else{
      print("Empty");
    }

  }






}