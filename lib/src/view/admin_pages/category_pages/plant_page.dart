import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/subcategory_controller.dart';
import 'package:admin_guide_agriculture/src/model/subcategory_model.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlantPage extends StatelessWidget {
  const PlantPage({super.key, required this.subCategory});
  final SubCategoryModel subCategory;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubCategoryController(subCategory.name));
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
        backgroundColor: ColorConst.mainScaffoldBackgroundColor,
        body: FutureBuilder(
            future: controller.fetchPlantByCategory(subCategory.name),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              "How To Grow ${subCategory.name}",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          Container(
                            width: 350,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(subCategory.image))),
                          ),
                          headerText("Choosing ${subCategory.name} Varieties"),
                          Divider(
                            color: ColorConst.iconColor,
                            thickness: 3,
                          ),
                          secText(subCategory.varieties),
                          const SizedBox(
                            height: 20,
                          ),
                          headerText("Soil Preparation"),
                          Divider(
                            color: ColorConst.iconColor,
                            thickness: 3,
                          ),
                          secText(subCategory.soil),
                          const SizedBox(
                            height: 20,
                          ),
                          headerText("Planting"),
                          Divider(
                            color: ColorConst.iconColor,
                            thickness: 3,
                          ),
                          secText(subCategory.planting),
                          const SizedBox(
                            height: 20,
                          ),
                          headerText("Watering"),
                          Divider(
                            color: ColorConst.iconColor,
                            thickness: 3,
                          ),
                          secText(subCategory.watering),
                          const SizedBox(
                            height: 20,
                          ),
                          headerText("Flowering Development:"),
                          Divider(
                            color: ColorConst.iconColor,
                            thickness: 3,
                          ),
                          secText(subCategory.flowering),
                          const SizedBox(
                            height: 20,
                          ),
                          headerText("Harvesting"),
                          Divider(
                            color: ColorConst.iconColor,
                            thickness: 3,
                          ),
                          secText(subCategory.harvesting),
                          const SizedBox(
                            height: 20,
                          ),
                          headerText("Disease"),
                          Divider(
                            color: ColorConst.iconColor,
                            thickness: 3,
                          ),
                          subCategory.disease == null
                              ? secText("No disease")
                              : secText(subCategory.disease!),
                          const SizedBox(
                            height: 20,
                          ),
                          Image.asset("assets/graphic.jpg"),
                        ],
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error${snapshot.error}'));
                } else {
                  return const Text("something went wrong");
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return const Text("something went wrong");
              }
            }),
      ),
    );
  }
}
