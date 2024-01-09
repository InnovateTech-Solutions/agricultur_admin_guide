import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/view/guid_pages/guide_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  final formkey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController videoId = TextEditingController();
  final TextEditingController newvideo = TextEditingController();

  validName(String? name) {
    if (name!.isEmpty) {
      return "name is not valid";
    }
    return null;
  }

  Future<List<Map<String, dynamic>>> fetchVideo() async {
    List<Map<String, dynamic>> video = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Video').get();

    for (var doc in querySnapshot.docs) {
      video.add(doc.data() as Map<String, dynamic>);
    }
    return video;
  }

  void addVideo(VideoModel videoModel) {
    if (formkey.currentState!.validate()) {
      try {
        Get.to(const GuideNavBar());
        FirebaseFirestore.instance
            .collection('Video')
            .add(videoModel.toJason());
      } catch (error) {
        Get.snackbar(error.toString(), "Something went wrong , try agin",
            snackPosition: SnackPosition.BOTTOM,
            colorText: ColorConst.mainScaffoldBackgroundColor,
            backgroundColor: Colors.red);
      }
    }
  }
}

class VideoModel {
  String title;
  String videoURL;
  VideoModel({required this.videoURL, required this.title});
  toJason() {
    return {"Title": title, "VideoId": videoURL};
  }
}
