import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/guide_controller.dart';
import 'package:admin_guide_agriculture/src/model/guide_model.dart';
import 'package:admin_guide_agriculture/src/view/user_pages/guidedetail_page.dart';
import 'package:admin_guide_agriculture/src/view/user_pages/intro_page.dart';
import 'package:admin_guide_agriculture/src/widget/admin_custom/add_guide_dialog.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGuide extends StatelessWidget {
  const AddGuide({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GuideController());
    final _auth = FirebaseAuth.instance;

    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
          future: controller.fetchAllGuide(),
          builder: (context, snapshot) {
            {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final guide = snapshot.data!;
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                headerText("Add Guide"),
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
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(const AddGuideDialog());
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: ColorConst.secScaffoldBackgroundColor,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: ColorConst.mainScaffoldBackgroundColor,
                                  size: 100,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 600,
                              width: 350,
                              child: GridView.builder(
                                  itemCount: guide.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 20),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.to(GuideDetailPage(
                                            guidModel: GuidModel(
                                                password: "",
                                                userType: "Guide",
                                                name: guide[index]['Name'],
                                                email: guide[index]['Email'],
                                                area: guide[index]['Area'],
                                                description: guide[index]
                                                    ['Description'],
                                                image: guide[index]['Image'],
                                                rating: guide[index]
                                                    ['rating'])));
                                      },
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        guide[index]['Image']),
                                                    fit: BoxFit.cover)),
                                          ),
                                          secText(guide[index]['Name'])
                                        ],
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error${snapshot.error}'));
                } else {
                  return const Text("something went wrong1");
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              } else {
                return const Text("somthing went wrong3");
              }
            }
          }),
    ));
  }
}
