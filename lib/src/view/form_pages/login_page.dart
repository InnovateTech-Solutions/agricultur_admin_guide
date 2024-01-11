import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/getx/login_controller.dart';
import 'package:admin_guide_agriculture/src/getx/user_controller.dart';
import 'package:admin_guide_agriculture/src/model/form_model.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/button.dart';
import 'package:admin_guide_agriculture/src/widget/user_custom.dart/form_widget/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(LoginController());

  clearText() {
    controller.email.clear();
    controller.password.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.secScaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: controller.fomkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      "LOGIN",
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              letterSpacing: 2,
                              fontSize: 30,
                              color: ColorConst.mainScaffoldBackgroundColor,
                              fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    FormWidget(
                        color: ColorConst.mainScaffoldBackgroundColor,
                        login: FormModel(
                            enableText: false,
                            hintText: "Email",
                            invisible: false,
                            validator: (phone) => controller.validEmail(phone),
                            type: TextInputType.name,
                            onChange: null,
                            inputFormat: null,
                            controller: controller.email)),
                    const SizedBox(
                      height: 50,
                    ),
                    FormWidget(
                        color: ColorConst.mainScaffoldBackgroundColor,
                        login: FormModel(
                            enableText: false,
                            hintText: "PASSWORD",
                            invisible: true,
                            validator: (password) =>
                                controller.vaildatePassword(password),
                            type: TextInputType.visiblePassword,
                            onChange: null,
                            inputFormat: null,
                            controller: controller.password)),
                    const SizedBox(
                      height: 150,
                    ),
                    ButtonWidget(
                        textColor: ColorConst.secScaffoldBackgroundColor,
                        title: "Login",
                        onTap: () async {
                          controller.onLogin();

                          UserController.instance.logIn();
                          clearText();
                        },
                        containerColor: ColorConst.mainScaffoldBackgroundColor),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
