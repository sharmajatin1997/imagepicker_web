# imagepicker_web
 
https://user-images.githubusercontent.com/80152469/235663322-33633cfd-55f4-46b3-8c32-eece46e8ac4f.mov

After Select Images Click On Submit Button to Hit API

# Open Image Picker
```
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
        picturesSentList.value.add(bytes);  // this list used for sent data to server
        picturesShowPath.add(element.path); // this list used for show selected image
      }
      picturesShowPath.refresh();
    }
  }
```

# Example API Code

```
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
      Response response = await _dio.post("API URL", options:getHeaderToken(), data: sendData);
      return response;
```
Please Set Response according your Api Response eg. If You get {} -> Use DataResponse and if you get [] then use pageResponse
