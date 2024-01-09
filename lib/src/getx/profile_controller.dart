import 'package:admin_guide_agriculture/src/auth_repo/auth_repo.dart';
import 'package:admin_guide_agriculture/src/auth_repo/user_repo.dart';
import 'package:admin_guide_agriculture/src/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());
  late UserModel userModel;

  getUserDataForGuide() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserGuideDetails(email);
    } else {
      Get.snackbar("Error", "Login to get email");
    }
  }

  Future<List<Map<String, dynamic>>> fetchAllFarm(String idNumber) async {
    List<Map<String, dynamic>> farm = [];

    final QuerySnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection('farms')
        .where("IdNumber", isEqualTo: idNumber)
        .get();
    for (var doc in result.docs) {
      farm.add(doc.data());
    }
    return farm;
  }
}
