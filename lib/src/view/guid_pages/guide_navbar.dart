import 'package:admin_guide_agriculture/src/auth_repo/auth_repo.dart';
import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/view/guid_pages/guid_farmlist_page.dart';
import 'package:admin_guide_agriculture/src/view/guid_pages/guide_add_video.dart';
import 'package:admin_guide_agriculture/src/view/guid_pages/guide_profile_page.dart';
import 'package:admin_guide_agriculture/src/view/guid_pages/guide_report_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GuideNavBar extends StatefulWidget {
  const GuideNavBar({super.key});

  @override
  State<GuideNavBar> createState() => _GuideNavBarState();
}

class _GuideNavBarState extends State<GuideNavBar> {
  final _authRepo = Get.put(AuthenticationRepository());
  late final email = _authRepo.firebaseUser.value?.email;

  final List<Widget> widgetList = const [
    GuidFarmPage(),
    GuideReportPage(),
    AddVideoWidget(),
    GuideProfilePage(),
  ];

  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() => Scaffold(
            body: Center(
              child: widgetList[selectedIndex.value],
            ),
            bottomNavigationBar: BottomNavigationBar(
                backgroundColor: ColorConst.secScaffoldBackgroundColor,
                selectedItemColor: ColorConst.mainScaffoldBackgroundColor,
                unselectedItemColor: ColorConst.mainScaffoldBackgroundColor,
                onTap: (value) {
                  selectedIndex.value = value;
                },
                currentIndex: selectedIndex.value,
                items: [
                  BottomNavigationBarItem(
                    icon: const Icon(
                      CupertinoIcons.book,
                    ),
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    icon: const Icon(
                      Icons.report,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    icon: const Icon(
                      Icons.video_call_outlined,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    icon: const Icon(
                      Icons.person_2_outlined,
                    ),
                    label: "",
                  ),
                ]))));
  }
}
