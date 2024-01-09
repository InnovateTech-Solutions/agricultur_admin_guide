import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/report_controller.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideReportPage extends StatelessWidget {
  const GuideReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());

    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: controller.fetchMessages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          } else {
            final messages = snapshot.data!;
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    headerText("Mssages From Farmers"),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      height: 650,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final message =
                                messages[index]['Message'].toString();
                            final farmerName =
                                messages[index]['Farmer name'].toString();

                            return Container(
                              height: 250,
                              width: 350,
                              decoration: BoxDecoration(
                                color: ColorConst.mainScaffoldBackgroundColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(.2),
                                  )
                                ],
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: ColorConst.secScaffoldBackgroundColor,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    secText(farmerName),
                                    headerText(message),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: messages.length),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    ));
  }
}
