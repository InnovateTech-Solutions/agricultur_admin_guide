import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/subcategory_controller.dart';
import 'package:admin_guide_agriculture/src/model/form_model.dart';
import 'package:admin_guide_agriculture/src/model/subcategory_model.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../user_custom.dart/form_widget/form_widget.dart';

void clearText() {
  controller.name.clear();
  controller.category.clear();
  controller.watering.clear();
  controller.image.clear();
  controller.planting.clear();
  controller.harvesting.clear();
  controller.varieties.clear();
  controller.disease.clear();
  controller.flowering.clear();
  controller.soil.clear();
  controller.transplanting.clear();
}

final controller = Get.put(SubCategoryController(""));

class AddSubCategoryDialog extends StatefulWidget {
  const AddSubCategoryDialog({super.key});

  @override
  State<AddSubCategoryDialog> createState() => _AddSubCategoryDialogState();
}

class _AddSubCategoryDialogState extends State<AddSubCategoryDialog> {
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
        title: Text(
          "Add Subcategory",
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                fontSize: 20,
                color: ColorConst.secScaffoldBackgroundColor,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Form(
        key: controller.formkey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            height: 1.4 * MediaQuery.of(context).size.height,
            width: 350,
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Name",
                        invisible: false,
                        validator: (name) => controller.validName(name),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.name)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Soil Preparation",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.soil)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Varieties",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.varieties)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Planting",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.planting)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Watering",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.watering)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Flowering Development",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.flowering)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Harvesting",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.harvesting)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Transplanting",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.transplanting)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    login: FormModel(
                        enableText: false,
                        hintText: "Disease",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.disease)),
                const SizedBox(
                  height: 20,
                ),
                FormWidget(
                    color: ColorConst.secScaffoldBackgroundColor,
                    ontap: () => controller.pickSubcategoryImage(),
                    login: FormModel(
                        enableText: true,
                        hintText: "Image",
                        invisible: false,
                        validator: (field) => controller.validName(field),
                        type: TextInputType.name,
                        onChange: null,
                        inputFormat: null,
                        controller: controller.image)),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => dropDown(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ButtonWidget(
                          title: "cancel",
                          onTap: () {
                            Get.back();
                            clearText();
                          },
                          containerColor:
                              ColorConst.mainScaffoldBackgroundColor,
                          textColor: ColorConst.secScaffoldBackgroundColor),
                    ),
                    SizedBox(
                      height: 50,
                      width: 100,
                      child: ButtonWidget(
                          title: "Add",
                          onTap: () {
                            controller.addSubCategory(SubCategoryModel(
                              planting: controller.planting.text,
                              soil: controller.soil.text,
                              transplanting: controller.transplanting.text,
                              varieties: controller.varieties.text,
                              watering: controller.watering.text,
                              category: controller.category.text,
                              flowering: controller.flowering.text,
                              harvesting: controller.harvesting.text,
                              image: controller.image.text,
                              name: controller.name.text,
                              disease: controller.disease.text,
                            ));
                            clearText();
                          },
                          containerColor: ColorConst.secScaffoldBackgroundColor,
                          textColor: ColorConst.mainScaffoldBackgroundColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Container dropDown() {
    return Container(
      height: 60,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: ColorConst.mainScaffoldBackgroundColor,
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        hint: Text(
          'Select an option',
          style: TextStyle(
            color: ColorConst.secScaffoldBackgroundColor,
            fontSize: 20,
          ),
        ),
        value: controller.selectedItem.value == ""
            ? null
            : controller.selectedItem.value,
        onChanged: (newValue) {
          controller.upDateSelectedItem(newValue.toString());
        },
        items: [
          const DropdownMenuItem<String>(
            value: '',
            child: Text('Select an option'),
          ),
          ...dropDownList.map<DropdownMenuItem<String>>((value) {
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
          }),
        ],
        underline: Container(
          height: 1,
          color: ColorConst.secScaffoldBackgroundColor,
        ),
      ),
    );
  }

  List dropDownList = ["Fruits", "Vegetables"];
}
