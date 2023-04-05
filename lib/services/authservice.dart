import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/responsive/mobile_screen.dart';
import 'package:instagramcloneapp/responsive/responsivelayout.dart';
import 'package:instagramcloneapp/responsive/web_screen.dart';
import 'package:instagramcloneapp/services/storage_methods.dart';
import 'package:instagramcloneapp/utils/dimension.dart';

class AuthService {
  signUp(
      {required String userName,
      required String email,
      required String password,
      required String bio,
      required Uint8List uintFile,
      required BuildContext context}) async {
    try {
      if (uintFile != null) {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        String photoUrl =
          await StorageMethod().storeToFirebaStorage("profilePics", uintFile);

    
            await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set({
          "userName": userName,
          "email": email,
          "id": userCredential.user!.uid,
         
          "following": [],
          "followers": [],
          "photoUrl": photoUrl,
        });


          

        

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("successful")));
              Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResponSive(
            mobileScreenLayout: MobileScreen(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
      } else
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("please add profile pic")));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  signIn(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

          ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Successfully logged in")));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResponSive(
            mobileScreenLayout: MobileScreen(),
            webScreenLayout: WebScreenLayout(),
          ),
        ),
      );
      
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
