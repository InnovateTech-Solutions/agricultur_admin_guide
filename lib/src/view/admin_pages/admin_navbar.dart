import 'package:admin_guide_agriculture/src/auth_repo/auth_repo.dart';
import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/add_disease.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/add_guide.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/add_subcategory.dart';
import 'package:admin_guide_agriculture/src/view/admin_pages/admin_weekly_report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({super.key});

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  final _authRepo = Get.put(AuthenticationRepository());
  late final email = _authRepo.firebaseUser.value?.email;

  final List<Widget> widgetList = const [
    AddGuide(),
    AddSubCategory(),
    AddDiseasePage(),
    AdminWeeklyReportView()
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
                      CupertinoIcons.table,
                    ),
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    label: "",
                  ),
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
                      Icons.healing_sharp,
                    ),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: const Icon(Icons.article_outlined),
                    backgroundColor: ColorConst.secScaffoldBackgroundColor,
                    label: "",
                  ),
                ]))));
  }
}
