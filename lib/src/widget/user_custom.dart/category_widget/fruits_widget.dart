import 'package:admin_guide_agriculture/src/getx/category_controlller.dart';
import 'package:admin_guide_agriculture/src/model/subcategory_model.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/category_pages/plant_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FruitCategoryWidget extends StatelessWidget {
  const FruitCategoryWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryContrller());
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: controller.fetchFruits(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else if (snapshot.hasError) {
          return Container();
        } else {
          final subCategory = snapshot.data!;
          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: subCategory.length,
                  itemBuilder: (context, index) {
                    final subCategoryName = subCategory[index]['name'];

                    final subCategoryImage = subCategory[index]['image'];
                    final flowering = subCategory[index]['Flowering'];
                    final harvesting = subCategory[index]['Harvesting'];
                    final planting = subCategory[index]['Planting'];
                    final soil = subCategory[index]['Soil'];
                    final transplanting = subCategory[index]['Transplanting'];
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
                        child: Container(
                          height: 160,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                width: 160,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 20,
                                        color: Colors.black.withOpacity(.2),
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(subCategoryImage),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                subCategoryName,
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18)),
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
