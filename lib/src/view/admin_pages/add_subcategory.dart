import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/category_controlller.dart';
import 'package:admin_guide_agriculture/src/model/category_model.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/category_pages/fruit_page.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/category_pages/vegetables_page.dart';
import 'package:admin_guide_agriculture/src/widget/admin_custom/add_subcategory_dialog.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/category_widget/fruits_widget.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/category_widget/vegetables_widget.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/dashboard_widget/category_widget.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/dashboard_widget/dashboard_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSubCategory extends StatelessWidget {
  const AddSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryContrller());
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConst.mainScaffoldBackgroundColor,
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: controller.fetchAllCategories(),
          builder: (context, snapshot) {
            {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final categories = snapshot.data!;
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Categories",
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: ColorConst.mainTextColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20)),
                                ),
                              ],
                            ),
                            Divider(
                                height: 20,
                                thickness: 2,
                                color: ColorConst.secScaffoldBackgroundColor),
                            SizedBox(
                              width: 375,
                              height: 200,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: categories.length,
                                itemBuilder: ((context, index) {
                                  final categoryName =
                                      categories[index]['Category'];

                                  final categoryImageURL =
                                      categories[index]['Image'];
                                  return CategoryWidget(
                                    model: CategoryModel(
                                        image: categoryImageURL,
                                        title: categoryName,
                                        callback: () {
                                          categories[index]['Category'] ==
                                                  "Fruits"
                                              ? Get.to(const FruitPage())
                                              : Get.to(const VegetablePage());
                                        }),
                                  );
                                }),
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    width: 5,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            headerTitle("Popular vegetables", () {
                              Get.to(const VegetablePage());
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const AddSubCategoryDialog());
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ColorConst
                                            .secScaffoldBackgroundColor,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: ColorConst
                                            .mainScaffoldBackgroundColor,
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 375,
                                    height: 200,
                                    child: VegetablesCategoryWidget(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            headerTitle("Popular Fruits", () {
                              Get.to(const FruitPage());
                            }),
                            const SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const AddSubCategoryDialog());
                                    },
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: ColorConst
                                            .secScaffoldBackgroundColor,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: ColorConst
                                            .mainScaffoldBackgroundColor,
                                        size: 100,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 375,
                                    height: 200,
                                    child: FruitCategoryWidget(),
                                  ),
                                ],
                              ),
                            ),
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
