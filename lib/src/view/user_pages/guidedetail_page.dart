import 'package:admin_guide_agriculture/src/auth_repo/auth_repo.dart';
import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/model/guide_model.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideDetailPage extends StatelessWidget {
  const GuideDetailPage({super.key, required this.guidModel});
  final GuidModel guidModel;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorConst.secScaffoldBackgroundColor,
          ),
          onPressed: () {
            Get.back();
            AuthenticationRepository.instance.logout();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 200,
                    height: 220,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(guidModel.image),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      thirdText(guidModel.name),
                      thirdText(guidModel.area),
                      guidModel.rating != null
                          ? Row(
                              children: [
                                thirdText(guidModel.rating!),
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
              thirdText(guidModel.description),
            ],
          ),
        ),
      ),
    ));
  }
}
