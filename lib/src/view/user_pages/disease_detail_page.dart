import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getx/disease_controller.dart';
import '../../model/disease_model.dart';

class DiseaseDetailPage extends StatelessWidget {
  const DiseaseDetailPage({super.key, required this.disease});
  final Disease disease;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DiseaseController());
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: controller.fetchDiseaseDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No information available ');
            } else {
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: ColorConst.secScaffoldBackgroundColor,
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            headerText(disease.name),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(disease.image),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        headerText('What is ${disease.name}?'),
                        Divider(
                          thickness: 3,
                          color: ColorConst.iconColor,
                        ),
                        secText(disease.transmission),
                        const SizedBox(
                          height: 20,
                        ),
                        headerText("Symptoms and Signs"),
                        Divider(
                          thickness: 3,
                          color: ColorConst.iconColor,
                        ),
                        SizedBox(
                          height: 100,
                          width: 350,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: disease.symptoms.length,
                              itemBuilder: (context, index) => Text(
                                  "${index + 1} - ${disease.symptoms[index]}")),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        headerText("How To Control?"),
                        Divider(
                          thickness: 3,
                          color: ColorConst.iconColor,
                        ),
                        SizedBox(
                          height: 150,
                          width: 350,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: disease.control.length,
                              itemBuilder: (context, index) => Text(
                                  "${index + 1} - ${disease.control[index]}")),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
