import 'package:admin_guide_agriculture/src/model/category_model.dart';
import 'package:admin_guide_agriculture/src/widget/text_widget/app_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryWidget extends StatelessWidget {
  CategoryWidget({super.key, required this.model});
  CategoryModel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: model.callback,
      child: Column(
        children: [
          Container(
            height: 150,
            width: 180,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.black.withOpacity(.5),
                  )
                ],
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    image: NetworkImage(model.image), fit: BoxFit.cover)),
          ),
          headerText(
            model.title,
          )
        ],
      ),
    );
  }
}
