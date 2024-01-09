import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String name;
  String email;
  String idNumber;
  String address;
  String password;
  String userType;
  UserModel(
      {this.id,
      required this.name,
      required this.email,
      required this.idNumber,
      required this.address,
      required this.password,
      required this.userType});

  tojason() {
    return {
      "Name": name,
      "Password": password,
      "Email": email,
      "Address": address,
      "IdNumber": idNumber,
      "UserType": userType
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    final data = documentSnapshot.data()!;
    return UserModel(
        name: data['Name'],
        password: data['Password'],
        email: data['Email'],
        address: data['Address'],
        idNumber: data['IdNumber'],
        userType: data["UserType"]);
  }
}
