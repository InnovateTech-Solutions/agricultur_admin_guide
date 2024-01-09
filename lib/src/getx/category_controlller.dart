import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryContrller extends GetxController {
  CategoryContrller get instance => Get.find();

  Future<List<Map<String, dynamic>>> fetchAllCategories() async {
    List<Map<String, dynamic>> category = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Categories ').get();

    for (var doc in querySnapshot.docs) {
      category.add(doc.data() as Map<String, dynamic>);
    }
    return category;
  }

  Future<List<Map<String, dynamic>>> fetchVegetables() async {
    List<Map<String, dynamic>> subcategory = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('subcategories ')
        .where('Categories ', isEqualTo: 'Vegetables')
        .get();

    for (var doc in querySnapshot.docs) {
      subcategory.add(doc.data() as Map<String, dynamic>);
    }
    return subcategory;
  }

  Future<List<Map<String, dynamic>>> fetchFruits() async {
    List<Map<String, dynamic>> subcategory = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('subcategories ')
        .where('Categories ', isEqualTo: 'Fruits')
        .get();

    for (var doc in querySnapshot.docs) {
      subcategory.add(doc.data() as Map<String, dynamic>);
    }
    return subcategory;
  }
}
