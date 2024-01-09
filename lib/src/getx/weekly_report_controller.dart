import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//controller
class WeeklyReport extends GetxController {
  final formkey = GlobalKey<FormState>();
  final missing = TextEditingController();
  final message = TextEditingController();
  RxString rating = "".obs;

  validText(String? text) {
    if (text!.isEmpty) {
      return "Data is not valid";
    }
    return null;
  }

  ratingValue(value) {
    rating.value = value.toString();

    return rating.value;
  }

  Future<void> addWeeklyReport(WeeklyReportModel weeklyReportModel) async {
    if (formkey.currentState!.validate()) {
      try {
        Get.back();
        await FirebaseFirestore.instance
            .collection('WeeklyReport')
            .add(weeklyReportModel.toJason());
        Get.snackbar("Success", "Your Report has been added",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.green);
      } catch (e) {
        Get.snackbar("Error", "Failed to add Report",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.red);
      }
    } else {
      Get.snackbar("ERROR", "Invalid data",
          snackPosition: SnackPosition.BOTTOM,
          colorText: ColorConst.mainScaffoldBackgroundColor,
          backgroundColor: Colors.red);
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllWeeklyReport() async {
    List<Map<String, dynamic>> report = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('WeeklyReport').get();

    for (var doc in querySnapshot.docs) {
      report.add(doc.data() as Map<String, dynamic>);
    }
    return report;
  }
}

//model
class WeeklyReportModel {
  String rating;
  String farmId;
  String missing;
  String message;

  WeeklyReportModel({
    required this.rating,
    required this.farmId,
    required this.missing,
    required this.message,
  });
  toJason() {
    return {
      "Rating": rating,
      "IdNumber": farmId,
      "Missing": missing,
      "Message": message,
    };
  }
}
