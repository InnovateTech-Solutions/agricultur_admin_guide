import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/farm_controller.dart';
import 'package:admin_guide_agriculture/src/model/farm_model.dart';
import 'package:admin_guide_agriculture/src/widget/guide_custom/view_farm_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtherFarmWidget extends StatelessWidget {
  const OtherFarmWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FarmController());
    return FutureBuilder(
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
                  SizedBox(
                    width: 350,
                    height: 200,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final farmName = farm[index]['FarmName'].toString();
                          final farmAddress =
                              farm[index]['FarmAddress'].toString();
                          final farmArea = farm[index]['FarmsArea'].toString();
                          final farmId = farm[index]['IdNumber'].toString();
                          final farmingType =
                              List<String>.from(farm[index]['FarmingType']);
                          // final image = farm[index]['Image'];

                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FarmPage(
                                    farmModel: FarmModel(
                                        image: "",
                                        farmName: farmName,
                                        farmAddress: farmAddress,
                                        farmArea: farmArea,
                                        farmingType: farmingType,
                                        idNumber: farmId)),
                              ),
                            ),
                            child: Container(
                              height: 250,
                              width: 200,
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
                                  color: ColorConst.secScaffoldBackgroundColor,
                                  width: 2.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [],
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 20,
                          );
                        },
                        itemCount: 4),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
