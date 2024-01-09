import 'package:admin_guide_agriculture/src/model/farm_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FarmController extends GetxController {
  final _db = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> fetchAllFarm() async {
    List<Map<String, dynamic>> farm = [];

    final QuerySnapshot<Map<String, dynamic>> result =
        await FirebaseFirestore.instance.collection('farms').get();
    for (var doc in result.docs) {
      farm.add(doc.data());
    }
    return farm;
  }

  Future<List<FarmModel>> fetchFarmById(String name) async {
    final querySnapshot =
        await _db.collection('farms').where('FarmName', isEqualTo: name).get();

    return querySnapshot.docs
        .map((doc) => FarmModel.fromSnapshot(doc))
        .toList();
  }
}
