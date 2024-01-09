import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryModel {
  String image;
  String title;
  VoidCallback? callback;

  CategoryModel({required this.image, required this.title, this.callback});

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return CategoryModel(
      title: data['Category'],
      image: data['Image'],
    );
  }
}
