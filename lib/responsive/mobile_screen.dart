import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getUserName();
  }

  void getUserName() async {
    DocumentSnapshot snapDocu = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print(snapDocu.data());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Hello"),
          ElevatedButton(onPressed: ()async{

            await FirebaseAuth.instance.signOut();
          }, child: Text("Logout"))
        ],
      ),
    );
  }
}
