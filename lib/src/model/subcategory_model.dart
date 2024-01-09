import 'package:cloud_firestore/cloud_firestore.dart';

class SubCategoryModel {
  String category;
  String flowering;
  String harvesting;
  String planting;
  String soil;
  String transplanting;
  String varieties;
  String watering;
  String? disease;
  String image;
  String name;

  SubCategoryModel(
      {required this.planting,
      required this.soil,
      required this.disease,
      required this.transplanting,
      required this.varieties,
      required this.watering,
      required this.category,
      required this.flowering,
      required this.harvesting,
      required this.image,
      required this.name});

  tojason() {
    return {
      "name": name,
      "image": image,
      "Varieties": varieties,
      "Categories ": category,
      "Flowering": flowering,
      "Harvesting": harvesting,
      "Planting": planting,
      "Soil": soil,
      "Disease": disease,
      "Transplanting": transplanting,
      "Watering": watering,
    };
  }

  factory SubCategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return SubCategoryModel(
        planting: data['Planting'],
        soil: data['Soil'],
        disease: data['Disease'],
        transplanting: data['Transplanting'],
        varieties: data['Varieties'],
        watering: data['Watering'],
        category: data['Categories '],
        flowering: data['Flowering'],
        harvesting: data['Harvesting'],
        image: data['image'],
        name: data['name']);
  }
}
