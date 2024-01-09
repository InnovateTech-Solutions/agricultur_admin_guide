import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:admin_guide_agriculture/src/model/form_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FormWidget extends StatefulWidget {
  FormWidget({super.key, required this.login, required this.color, this.ontap});
  FormModel login;
  Color color;
  VoidCallback? ontap;
  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.color == ColorConst.mainScaffoldBackgroundColor
        ? Center(
            child: TextFormField(
                onTap: widget.ontap,
                cursorColor: ColorConst.mainScaffoldBackgroundColor,
                readOnly: widget.login.enableText,
                inputFormatters: widget.login.inputFormat,
                keyboardType: widget.login.type,
                onChanged: widget.login.onChange,
                validator: widget.login.validator,
                obscureText: widget.login.invisible,
                style: TextStyle(color: ColorConst.mainScaffoldBackgroundColor),
                controller: widget.login.controller,
                decoration: InputDecoration(
                  hintText: widget.login.hintText,
                  hintStyle: TextStyle(
                      color: ColorConst.mainScaffoldBackgroundColor,
                      fontSize: 20),
                  labelStyle:
                      TextStyle(color: ColorConst.mainScaffoldBackgroundColor),
                  fillColor: ColorConst.secScaffoldBackgroundColor,
                  filled: true,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConst
                            .mainScaffoldBackgroundColor), // Set the underline color here
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorConst.mainScaffoldBackgroundColor),
                  ),
                )),
          )
        : TextFormField(
            onTap: widget.ontap,
            cursorColor: ColorConst.secScaffoldBackgroundColor,
            readOnly: widget.login.enableText,
            inputFormatters: widget.login.inputFormat,
            keyboardType: widget.login.type,
            onChanged: widget.login.onChange,
            validator: widget.login.validator,
            obscureText: widget.login.invisible,
            style: TextStyle(color: ColorConst.secScaffoldBackgroundColor),
            controller: widget.login.controller,
            decoration: InputDecoration(
              hintText: widget.login.hintText,
              hintStyle: TextStyle(
                  color: ColorConst.secScaffoldBackgroundColor, fontSize: 20),
              labelStyle:
                  TextStyle(color: ColorConst.mainScaffoldBackgroundColor),
              fillColor: ColorConst.mainScaffoldBackgroundColor,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConst
                        .secScaffoldBackgroundColor), // Set the underline color here
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConst.secScaffoldBackgroundColor),
              ),
            ));
  }
}
