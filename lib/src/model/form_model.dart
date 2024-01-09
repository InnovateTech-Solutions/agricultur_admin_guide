import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormModel {
  TextEditingController controller = TextEditingController();
  String hintText;
  bool invisible;
  bool enableText;

  final String? Function(String?)? validator;
  TextInputType type;
  void Function(String?)? onChange;
  List<TextInputFormatter>? inputFormat;

  FormModel(
      {required this.controller,
      required this.enableText,
      required this.hintText,
      required this.invisible,
      required this.validator,
      required this.type,
      required this.onChange,
      required this.inputFormat});
}
