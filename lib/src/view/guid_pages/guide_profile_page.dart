import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/profile_controller.dart';
import 'package:admin_guide_agriculture/src/model/guide_model.dart';
import 'package:admin_guide_agriculture/src/view/user_pages/intro_page.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideProfilePage extends StatelessWidget {
  const GuideProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final _auth = FirebaseAuth.instance;

    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConst.mainScaffoldBackgroundColor,
            body: FutureBuilder(
                future: controller.getUserDataForGuide(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.done) {
                    if (snapShot.hasData) {
                      GuidModel guideData = snapShot.data as GuidModel;

                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                    onTap: () async {
                                      await _auth.signOut();
                                      Get.offAll(const IntroPage());
                                    },
                                    child: Icon(
                                      Icons.logout,
                                      color: ColorConst.iconColor,
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  height: 220,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image: NetworkImage(guideData.image),
                                          fit: BoxFit.cover)),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    thirdText(guideData.name),
                                    thirdText(guideData.area),
                                    guideData.rating != null
                                        ? Row(
                                            children: [
                                              thirdText(guideData.rating!),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Divider(
                              thickness: 3,
                              color: ColorConst.iconColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            thirdText(guideData.description),
                          ],
                        ),
                      );
                    } else if (snapShot.hasError) {
                      return Center(child: Text('Error${snapShot.error}'));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
