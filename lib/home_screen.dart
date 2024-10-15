

import 'package:flutter/material.dart';
import 'package:flutter_web/input_component.dart';
import 'package:flutter_web/page_info.dart';
import 'package:get/get.dart';

import 'component_list.dart';
import 'home_controller.dart';
import 'web_header.dart';

class HomeScreen extends StatelessWidget {
  // final HomeController _controller = Get.put(HomeController());
  final PageInfo pageInfo;
  const HomeScreen({super.key,required this.pageInfo}); // Initialize the controller


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  WebHeader(),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                '${pageInfo.pageName} Page' ,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InputComponent(pageInfo: pageInfo,),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: MyComponentList(pageInfo: pageInfo,),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}