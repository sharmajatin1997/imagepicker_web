import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagepicker_web/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Image Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Web Image Picker'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  final _controller=Get.put(ControllerImage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() => Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _controller.picturesShowPath.value.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  var model =
                  (index >= _controller.picturesShowPath.value.length)
                      ? null
                      : _controller.picturesShowPath[index];
                  String? imgUrl = model;
                  return imgUrl == null
                      ? Center(
                    child: GestureDetector(
                      onTap: () {
                        var valid = false;
                        for (var item in _controller.picturesShowPath) {
                          if (item.toString().trim().isEmpty) {
                            valid = true;
                          }
                        }
                        _controller.openCamera(-1);
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        child: const ClipRRect(
                          borderRadius:
                          BorderRadius.all(Radius.circular(12)),
                          child: SizedBox(

                              height: 35,
                              width: 35,
                              child: Icon(
                                Icons.add,
                                size: 30,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                    ),
                  )
                      : model.toString().trim().isEmpty
                      ? GestureDetector(
                    onTap: () {
                      _controller.openCamera(index);
                    },
                    child: Center(
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          child: const ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(12)),
                            child: SizedBox(

                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                  color: Colors.grey,
                                )),
                          ),
                        )),
                  )
                      : Center(
                    child: GestureDetector(
                        onTap: () {
                          _controller.openCamera(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            padding: const EdgeInsets.all(6),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(5),
                              child: SizedBox(

                                  height: 35,
                                  width: 35,
                                  child: Image.network(
                                    model!,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                        )),
                  );
                },
              ))),
          InkWell(
            onTap: () {
                _controller.initHelpSupport("Web Image");
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 15),
              height: 40,
              width: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  "Submit",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontSize: 12,
                      color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),

    );
  }
}
