import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  Future<List<Map<String, dynamic>>> fetchAllSubCategories() async {
    List<Map<String, dynamic>> subCategory = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('subcategories ').get();

    for (var doc in querySnapshot.docs) {
      subCategory.add(doc.data() as Map<String, dynamic>);
    }
    return subCategory;
  }
}
