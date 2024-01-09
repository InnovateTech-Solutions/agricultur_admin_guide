import 'package:cloud_firestore/cloud_firestore.dart';

class GuidModel {
  String email;
  String name;
  String area;
  String description;
  String image;
  String userType;
  String password;
  GuidModel(
      {required this.email,
      required this.password,
      required this.name,
      required this.area,
      required this.description,
      required this.image,
      required this.userType});

  tojason() {
    return {
      "Email": email,
      "Name": name,
      "Image": image,
      "Area": area,
      "Description": description,
      "UserType": userType,
      "Password": password
    };
  }

  factory GuidModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return GuidModel(
        userType: data['UserType'],
        email: data['Email'],
        name: data['Name'],
        area: data['Area'],
        description: data['Description'],
        image: data['Image'],
        password: data['Password']);
  }
}
