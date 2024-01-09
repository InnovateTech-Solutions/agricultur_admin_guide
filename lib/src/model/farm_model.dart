import 'package:cloud_firestore/cloud_firestore.dart';

class FarmModel {
  String farmName;
  String farmAddress;
  String farmArea;
  List<String> farmingType;
  String idNumber;
  String image;
  FarmModel(
      {required this.farmName,
      required this.farmAddress,
      required this.farmArea,
      required this.farmingType,
      required this.idNumber,
      required this.image});

  tojason() {
    return {
      "FarmName": farmName,
      "FarmAddress": farmAddress,
      "FarmsArea": farmArea,
      "FarmingType": farmingType,
      "IdNumber": idNumber,
      "Image": image
    };
  }

  factory FarmModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return FarmModel(
        farmName: data["FarmName"] ?? '',
        farmAddress: data["FarmAddress"] ?? '',
        farmArea: data["FarmArea"] ?? '',
        farmingType: List<String>.from(data["FarmingType"] ?? []),
        idNumber: data["IdNumber"] ?? '',
        image: data["Image"] ?? '');
  }
}
