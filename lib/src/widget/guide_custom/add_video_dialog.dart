import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/video_controller.dart';
import 'package:admin_guide_agriculture/src/model/form_model.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../user_custom.dart/form_widget/form_widget.dart';

class AddVideoDialog extends StatefulWidget {
  const AddVideoDialog({super.key});

  @override
  State<AddVideoDialog> createState() => _AddVideoDialogState();
}

class _AddVideoDialogState extends State<AddVideoDialog> {
  final controller = Get.put(VideoController());
  void clearText() {
    controller.videoId.clear();
    controller.title.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: ColorConst.iconColor,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Form(
          key: controller.formkey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              margin: const EdgeInsets.all(20),
              width: 350,
              height: 650,
              child: Column(
                children: [
                  Text(
                    "Add Video Details",
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 20,
                            color: ColorConst.secScaffoldBackgroundColor,
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "Video Title",
                          invisible: false,
                          validator: (name) => controller.validName(name),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.title)),
                  const SizedBox(
                    height: 50,
                  ),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "Video Id",
                          invisible: false,
                          validator: (name) => controller.validName(name),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.videoId)),
                  const SizedBox(
                    height: 20,
                  ),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "Video Id",
                          invisible: false,
                          validator: (name) => controller.validName(name),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.newvideo)),
                  const SizedBox(
                    height: 20,
                  ),
                  const Spacer(),
                  ButtonWidget(
                      title: "Add",
                      onTap: () {
                        controller.addVideo(VideoModel(
                            videoURL: controller.videoId.text.trim(),
                            title: controller.title.text.trim()));
                        clearText();
                      },
                      containerColor: ColorConst.secScaffoldBackgroundColor,
                      textColor: ColorConst.mainScaffoldBackgroundColor)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
