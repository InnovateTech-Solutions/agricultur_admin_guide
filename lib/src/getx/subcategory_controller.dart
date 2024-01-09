import 'dart:io';

import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/model/subcategory_model.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/admin_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SubCategoryController extends GetxController {
  final String plant;
  SubCategoryController(this.plant);
  final formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final category = TextEditingController();
  final flowering = TextEditingController();
  final harvesting = TextEditingController();
  final planting = TextEditingController();
  final soil = TextEditingController();
  final transplanting = TextEditingController();
  final varieties = TextEditingController();
  final disease = TextEditingController();
  final watering = TextEditingController();
  final image = TextEditingController();
  final _db = FirebaseFirestore.instance;
  RxString selectedItem = "".obs;

  validName(String? field) {
    if (field!.isEmpty) {
      return "Field is not valid";
    }
    return null;
  }

  Future<List<SubCategoryModel>> fetchPlantByCategory(String category) async {
    final querySnapshot = await _db
        .collection('subcategories ')
        .where('name', isEqualTo: category)
        .get();

    return querySnapshot.docs
        .map((doc) => SubCategoryModel.fromSnapshot(doc))
        .toList();
  }

  pickSubcategoryImage() async {
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

  void upDateSelectedItem(String value) {
    selectedItem.value = value;
    category.text = selectedItem.value;
  }

  Future<void> addSubCategory(SubCategoryModel subcategory) async {
    if (formkey.currentState!.validate()) {
      try {
        Get.to(const AdminNavBar());
        await FirebaseFirestore.instance
            .collection('subcategories ')
            .add(subcategory.tojason());
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
}
