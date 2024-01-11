import 'dart:io';
import 'dart:math';

import 'package:admin_guide_agriculture/src/auth_repo/auth_repo.dart';
import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/model/guide_model.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/add_guide/add_guide_dialog.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/admin_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class GuideController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final area = TextEditingController();
  final description = TextEditingController();
  final image = TextEditingController();
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  validName(String? name) {
    if (name!.isEmpty) {
      return "name is not valid";
    }
    return null;
  }

  validArea(String? area) {
    if (area!.isEmpty) {
      return "Area is not valid";
    }
    return null;
  }

  validImage(String? image) {
    if (image!.isEmpty) {
      return "Image is not valid";
    }
    return null;
  }

  validDescription(String? description) {
    if (description!.isEmpty) {
      return "Description is not valid";
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchAllGuide() async {
    List<Map<String, dynamic>> guide = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Guide').get();

    for (var doc in querySnapshot.docs) {
      guide.add(doc.data() as Map<String, dynamic>);
    }
    return guide;
  }

  Future<List<GuidModel>> fetchGuideDetails() async {
    final querySnapshot =
        await _db.collection('Guide').where('Area', isEqualTo: "Amman").get();

    return querySnapshot.docs
        .map((doc) => GuidModel.fromSnapshot(doc))
        .toList();
  }

  Future<void> createFarm(GuidModel guidModel) async {
    await _db.collection("Guide").add(guidModel.tojason());
  }

  String generateRandomPassword({int length = 8}) {
    const String charset =
        "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^&*()-_=+";

    Random random = Random();
    List<String> passwordList = List.generate(
        length, (index) => charset[random.nextInt(charset.length)]);

    return passwordList.join();
  }

  Future<void> addGuide(GuidModel guidModel, String email, String password,
      BuildContext context) async {
    if (formkey.currentState!.validate()) {
      Future<bool> code = AuthenticationRepository()
          .createUserWithEmailPassword(guidModel.email, guidModel.password);

      if (await code) {
        Get.to(const AdminNavBar());
        await FirebaseFirestore.instance
            .collection('Guide')
            .add(guidModel.tojason());
        await _auth.signOut();

        Get.snackbar("Success", "Your Farm has been added",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.green);

        // ignore: use_build_context_synchronously
        guideEmailPassword(context, email, password);
      } else {
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

  pickFarmImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return;
    }

    Reference storageReference =
        FirebaseStorage.instance.ref().child('images').child('filename.jpg');
    await storageReference.putFile(File(file.path));

    String imageUrl = await storageReference.getDownloadURL();
    image.text = imageUrl;
  }
}
