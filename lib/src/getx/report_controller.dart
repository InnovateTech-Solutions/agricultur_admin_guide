import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportController extends GetxController {
  final message = TextEditingController();
  final email = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final formkey = GlobalKey<FormState>();

  validName(String? name) {
    if (name!.isEmpty) {
      return "name is not valid";
    }
    return null;
  }

  Future<void> addReport(ReportModel report) async {
    if (formkey.currentState!.validate()) {
      try {
        Get.back();

        await FirebaseFirestore.instance
            .collection('Report')
            .add(report.tojason());
        Get.snackbar("Success", "Your Farm has been added",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.green);
      } catch (e) {
        Get.snackbar("Error", "Failed to add farm",
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

  Future<QuerySnapshot> getGuideReports() async {
    String? user = _auth.currentUser?.email;

    return await _firestore
        .collection('Report')
        .where('Guide', isEqualTo: user)
        .get();
  }

  Future<List<Map<String, dynamic>>> fetchMessages() async {
    List<Map<String, dynamic>> messages = [];
    String? user = _auth.currentUser?.email;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Report')
        .where('Guide', isEqualTo: user)
        .get();

    for (var doc in querySnapshot.docs) {
      messages.add(doc.data() as Map<String, dynamic>);
    }
    return messages;
  }
}

class ReportModel {
  String farmerName;
  String message;
  String email;
  ReportModel({
    required this.farmerName,
    required this.message,
    required this.email,
  });

  tojason() {
    return {"Farmer name": farmerName, "Message": message, "Guide": email};
  }

  factory ReportModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return ReportModel(
      farmerName: data['Farmer name'],
      message: data['Message'],
      email: data['Guide'],
    );
  }
}
