import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/guide_controller.dart';
import 'package:admin_guide_agriculture/src/model/form_model.dart';
import 'package:admin_guide_agriculture/src/model/guide_model.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user_custom.dart/form_widget/form_widget.dart';

class AddGuideDialog extends StatefulWidget {
  const AddGuideDialog({super.key});

  @override
  State<AddGuideDialog> createState() => _AddGuideDialogState();
}

class _AddGuideDialogState extends State<AddGuideDialog> {
  final controller = Get.put(GuideController());

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
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Guide Name",
                        invisible: false,
                        validator: (name) => controller.validName(name),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.name)),
                const SizedBox(
                  height: 50,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Guide Email",
                        invisible: false,
                        validator: (name) => controller.validName(name),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.email)),
                const SizedBox(
                  height: 50,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Guide Descriptin",
                        invisible: false,
                        validator: (description) =>
                            controller.validDescription(description),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.description)),
                const SizedBox(
                  height: 50,
                ),
                DropdownButton<String>(
                  value: controller.selectedArea,
                  onChanged: (String? newValue) {
                    setState(() {
                      controller.selectedArea = newValue!;
                    });
                  },
                  items: controller.areas
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: ColorConst.secScaffoldBackgroundColor,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }).toList(),
                  isExpanded: true,
                  style: TextStyle(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  underline: Container(
                    height: 1,
                    color: ColorConst
                        .secScaffoldBackgroundColor, // Set your desired underline color here
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    ontap: () => controller.pickFarmImage(),
                    login: FormModel(
                        enableText: true,
                        hintText: "Guide Image",
                        invisible: false,
                        validator: (image) => controller.validImage(image),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.image)),
                const Spacer(),
                ButtonWidget(
                    title: "Add",
                    onTap: () {
                      controller.addGuide(
                          GuidModel(
                              password: controller.generateRandomPassword(),
                              userType: "Guide",
                              email: controller.email.text.trim(),
                              name: controller.name.text.trim(),
                              area: controller.selectedArea,
                              description: controller.description.text.trim(),
                              image: controller.image.text.trim(),
                              rating: ''),
                          controller.email.text.trim(),
                          controller.generateRandomPassword(),
                          context);
                    },
                    containerColor: ColorConst.secScaffoldBackgroundColor,
                    textColor: ColorConst.mainScaffoldBackgroundColor)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
