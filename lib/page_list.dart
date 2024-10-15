import 'package:flutter/material.dart';
import 'package:flutter_web/add_page_controller.dart';
import 'package:flutter_web/common.dart';
import 'package:flutter_web/home_screen.dart';
import 'package:get/get.dart';

import 'page_info.dart';

class PageList extends StatelessWidget {
  final AddPageController componentController = Get.put(AddPageController());

  PageList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Obx(() {
            return componentController.pageList.isEmpty
                ? SizedBox(
              height: 100,
              child: Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.teal.shade200, width: 1.5),
                ),
                child: const Center(
                    child: Text(
                      'No Data Found',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    )),
              ),
            )
                : Card(
              elevation: 8,
              margin: const EdgeInsets.all(5.0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.teal.shade200, width: 1.5),
              ),
              child: Column(
                children: componentController.pageList
                    .asMap()
                    .map((index, component) {
                  final componentData =
                  Map<String, dynamic>.from(component['value']);
                  return MapEntry(
                    index,
                    Dismissible(
                      key: Key(componentData.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        componentController.deleteComponent(
                            component['key'].toString());
                        componentController.pageList.removeAt(index);

                        Get.snackbar(
                          'Deleted',
                          '${componentData['PageName']} has been deleted',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildPageWidget(context, componentData),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                    .values
                    .toList(),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildPageWidget(BuildContext context, Map<String, dynamic> componentData) {
    return GestureDetector(
      onTap: () {
       // Common.showFlutterSnackbar(context, 'Page Clicked', Colors.blueAccent);
        final info = PageInfo(
          pageName: componentData['PageName'],
          pageRoute: componentData['PageRoute']
        );
        Get.to(() => HomeScreen(pageInfo: info,));
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.teal,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),

            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.pages,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '${componentData['PageName']} Page',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white70,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
