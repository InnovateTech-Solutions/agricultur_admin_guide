import 'package:admin_guide_agriculture/src/view/admin_pages/admin_navbar.dart';
import 'package:admin_guide_agriculture/src/view/form_pages/login_page.dart';
import 'package:admin_guide_agriculture/src/view/guid_pages/guide_navbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserAuthWrapper extends StatelessWidget {
  const UserAuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return FutureBuilder<String>(
              future: _getUserType(FirebaseAuth.instance.currentUser!.email!),
              builder: (context, userTypeSnapshot) {
                if (userTypeSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  String userType = userTypeSnapshot.data ?? '';
                  switch (userType) {
                    case 'Farmer':
                      return LoginPage();
                    case 'Guide':
                      return const GuideNavBar();
                    case 'admin':
                      return const AdminNavBar();
                    default:
                      return LoginPage();
                  }
                }
              },
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }

  // ... (rest of your code)

  // Modify the _getUserType function to handle 'Guide' and 'Admin' cases
  Future<String> _getUserType(String email) async {
    QuerySnapshot userQuery = await FirebaseFirestore.instance
        .collection('User')
        .where('Email', isEqualTo: email)
        .get();

    if (userQuery.docs.isNotEmpty) {
      return userQuery.docs.first['UserType'];
    }

    QuerySnapshot guideQuery = await FirebaseFirestore.instance
        .collection('Guide')
        .where('Email', isEqualTo: email)
        .get();

    if (guideQuery.docs.isNotEmpty) {
      return guideQuery.docs.first['UserType'];
    }

    QuerySnapshot adminQuery = await FirebaseFirestore.instance
        .collection('Admin')
        .where('Email', isEqualTo: email)
        .get();

    if (adminQuery.docs.isNotEmpty) {
      return 'Admin';
    }

    return '';
  }
}
