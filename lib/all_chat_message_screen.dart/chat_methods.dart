


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

updateUserInfo(String name, String about) async{

 await FirebaseFirestore.instance.collection("chatUser").doc( FirebaseAuth.instance.currentUser!.uid).update({
  "name": name.toString(),
  "about": about.toString(),




  });

  




}