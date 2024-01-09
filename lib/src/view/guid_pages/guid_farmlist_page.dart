import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/farm_controller.dart';
import 'package:admin_guide_agriculture/src/model/farm_model.dart';
import 'package:admin_guide_agriculture/src/view/guid_pages/guide_viewfarm.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuidFarmPage extends StatelessWidget {
  const GuidFarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FarmController());
    return SafeArea(
        child: Scaffold(
      body: FutureBuilder(
        future: controller.fetchAllFarm(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshot.hasError) {
            return Container();
          } else {
            final farm = snapshot.data!;
            return Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    headerText("FARMS"),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 350,
                      height: 650,
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            final farmName = farm[index]['FarmName'].toString();
                            final farmAddress =
                                farm[index]['FarmAddress'].toString();
                            final farmArea =
                                farm[index]['FarmsArea'].toString();
                            final farmId = farm[index]['IdNumber'].toString();
                            final farmingType =
                                List<String>.from(farm[index]['FarmingType']);
                            final image = farm[index]['Image'];

                            return GestureDetector(
                              onTap: () => Get.to(
                                GuideFarmPage(
                                    farmModel: FarmModel(
                                        image: image,
                                        farmName: farmName,
                                        farmAddress: farmAddress,
                                        farmArea: farmArea,
                                        farmingType: farmingType,
                                        idNumber: farmId)),
                              ),
                              child: Container(
                                height: 250,
                                width: 350,
                                decoration: BoxDecoration(
                                  color: ColorConst.mainScaffoldBackgroundColor,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(.2),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color:
                                        ColorConst.secScaffoldBackgroundColor,
                                    width: 2.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      headerText(farmName),
                                      secText(farmAddress),
                                      secText(farmArea),
                                      secText(farmId),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: farm.length),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    ));
  }
}
