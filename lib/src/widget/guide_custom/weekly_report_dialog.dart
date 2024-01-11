import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/model/form_model.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/button.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/form_widget/form_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../getx/weekly_report_controller.dart';

class WeeklyReportDialog extends StatefulWidget {
  const WeeklyReportDialog(
      {super.key, required this.farmId, required this.farmName});
  final String farmId;
  final String farmName;
  @override
  State<WeeklyReportDialog> createState() => _WeeklyReportDialogState();
}

class _WeeklyReportDialogState extends State<WeeklyReportDialog> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WeeklyReport());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: ColorConst.iconColor,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Form(
          key: controller.formkey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: 350,
              height: 650,
              child: Column(
                children: [
                  headerText("Fill the form"),
                  FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                      enableText: false,
                      hintText: "Farm Shortfalls",
                      invisible: false,
                      validator: (name) => controller.validText(name),
                      type: TextInputType.name,
                      onChange: null,
                      inputFormat: null,
                      controller: controller.missing,
                    ),
                  ),
                  const SizedBox(height: 50),
                  FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                      enableText: false,
                      hintText: "Report Message",
                      invisible: false,
                      validator: (name) => controller.validText(name),
                      type: TextInputType.name,
                      onChange: null,
                      inputFormat: null,
                      controller: controller.message,
                    ),
                  ),
                  const SizedBox(height: 50),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      controller.rating.value = rating.toString();
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ButtonWidget(
                    title: "Add",
                    onTap: () {
                      final email = FirebaseAuth.instance.currentUser!.email!;
                      controller.addWeeklyReport(
                        WeeklyReportModel(
                          rating: controller.rating.value,
                          farmId: widget.farmId,
                          farmName: widget.farmName,
                          missing: controller.missing.text.trim(),
                          message: controller.message.text.trim(),
                          guideEmail: email,
                        ),
                      );
                    },
                    containerColor: ColorConst.secScaffoldBackgroundColor,
                    textColor: ColorConst.mainScaffoldBackgroundColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
