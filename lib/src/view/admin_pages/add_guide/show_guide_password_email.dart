import 'package:admin_guide_agriculture/src/constant/color.dart';
import 'package:flutter/material.dart';

void guideEmailPassword(BuildContext context, String email, String password) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: ColorConst.secScaffoldBackgroundColor,
        title: Text(
          email,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          password,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
