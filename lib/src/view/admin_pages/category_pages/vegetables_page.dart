import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/category_controlller.dart';
import 'package:admin_guide_agriculture/src/model/category_model.dart';
import 'package:admin_guide_agriculture/src/model/subcategory_model.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/category_pages/plant_page.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/dashboard_widget/category_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VegetablePage extends StatelessWidget {
  const VegetablePage({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryContrller());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: headerText("Vegetable"),
          ),
          leading: IconButton(
            color: ColorConst.iconColor,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: controller.fetchVegetables(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (snapshot.hasError) {
              return Container();
            } else {
              final subCategory = snapshot.data!;
              return Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 550,
                      width: 450,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: subCategory.length,
                          itemBuilder: (context, index) {
                            final subCategoryName = subCategory[index]['name'];

                            final subCategoryImage =
                                subCategory[index]['image'];
                            final flowering = subCategory[index]['Flowering'];
                            final harvesting = subCategory[index]['Harvesting'];
                            final planting = subCategory[index]['Planting'];
                            final soil = subCategory[index]['Soil'];
                            final transplanting =
                                subCategory[index]['Transplanting'];
                            final varieties = subCategory[index]['Varieties'];
                            final watering = subCategory[index]['Watering'];
                            final category = subCategory[index]['Categories '];
                            final disease = subCategory[index]['Disease'];

                            return Column(
                              children: [
                                CategoryWidget(
                                    model: CategoryModel(
                                        image: subCategoryImage,
                                        title: subCategoryName,
                                        callback: () {
                                          Get.to(PlantPage(
                                              subCategory: SubCategoryModel(
                                                  disease: disease,
                                                  planting: planting,
                                                  soil: soil,
                                                  transplanting: transplanting,
                                                  varieties: varieties,
                                                  watering: watering,
                                                  category: category,
                                                  flowering: flowering,
                                                  harvesting: harvesting,
                                                  image: subCategoryImage,
                                                  name: subCategoryName)));
                                        })),
                              ],
                            );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          )),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
