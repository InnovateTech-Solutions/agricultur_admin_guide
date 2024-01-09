import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/disease_controller.dart';
import 'package:admin_guide_agriculture/src/model/disease_model.dart';
import 'package:admin_guide_agriculture/src/model/form_model.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../user_custom.dart/form_widget/form_widget.dart';

class AddDiseaseDialog extends StatefulWidget {
  const AddDiseaseDialog({super.key});

  @override
  State<AddDiseaseDialog> createState() => _AddDiseaseDialogState();
}

class _AddDiseaseDialogState extends State<AddDiseaseDialog> {
  final controller = Get.put(DiseaseController());

  void clearText() {
    controller.name.clear();
    controller.transmission.clear();
    controller.image.clear();
    controller.control.clear();
    controller.symptoms.clear();
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
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "Disease Name",
                          invisible: false,
                          validator: (name) => controller.validName(name),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.name)),
                  const SizedBox(
                    height: 40,
                  ),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "Symptoms(comma-separated)",
                          invisible: false,
                          validator: (name) => controller.validName(name),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.symptoms)),
                  const SizedBox(
                    height: 40,
                  ),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "Controller(comma-separated)",
                          invisible: false,
                          validator: (description) =>
                              controller.validName(description),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.control)),
                  const SizedBox(
                    height: 40,
                  ),
                  FormWidget(
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: false,
                          hintText: "Transmission",
                          invisible: false,
                          validator: (area) => controller.validName(area),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.transmission)),
                  const SizedBox(
                    height: 40,
                  ),
                  FormWidget(
                      ontap: () {
                        controller.pickFarmImage();
                      },
                      color: ColorConst.secScaffoldBackgroundColor,
                      login: FormModel(
                          enableText: true,
                          hintText: "Image",
                          invisible: false,
                          validator: (area) => controller.validName(area),
                          type: TextInputType.name,
                          onChange: null,
                          inputFormat: null,
                          controller: controller.image)),
                  const Spacer(),
                  ButtonWidget(
                      title: "Add",
                      onTap: () {
                        String name = controller.name.text;
                        List<String> control = controller.control.text
                            .split(',')
                            .map((e) => e.trim())
                            .toList();
                        List<String> symptoms = controller.symptoms.text
                            .split(',')
                            .map((e) => e.trim())
                            .toList();
                        String transmission = controller.transmission.text;
                        String image = controller.image.text;
                        controller.addDisease(Disease(
                            name: name,
                            control: control,
                            symptoms: symptoms,
                            transmission: transmission,
                            image: image));

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
