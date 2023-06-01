

import 'package:flutter/material.dart';
import 'package:instagramcloneapp/services/authservice.dart';
import 'package:instagramcloneapp/services/firestore_methods.dart';

class ProfileScreen extends StatefulWidget {
  final userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GestureDetector(
        onTap: (){
          FirestoreMethods().logOut();



        },
        
        child: Text("profile")),
    );
  }
}