import 'package:admin_guide_agriculture/src/getx/dashboard_controller.dart';
import 'package:admin_guide_agriculture/src/model/subcategory_model.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/category_pages/plant_page.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubCategoryPage extends StatelessWidget {
  const SubCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: controller.fetchAllSubCategories(),
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
                    headerText("SubCategory"),
                    const SizedBox(height: 25),
                    SizedBox(
                      height: 550,
                      width: 450,
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: subCategory.length,
                          physics: const NeverScrollableScrollPhysics(),
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

                            return GestureDetector(
                                onTap: () {
                                  Get.to(PlantPage(
                                      subCategory: SubCategoryModel(
                                          planting: planting,
                                          soil: soil,
                                          transplanting: transplanting,
                                          varieties: varieties,
                                          watering: watering,
                                          category: category,
                                          flowering: flowering,
                                          harvesting: harvesting,
                                          image: subCategoryImage,
                                          name: subCategoryName,
                                          disease: disease)));
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(.2),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  subCategoryImage),
                                              fit: BoxFit.cover)),
                                    ),
                                    thirdText(
                                      subCategoryName,
                                    )
                                  ],
                                ));
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
