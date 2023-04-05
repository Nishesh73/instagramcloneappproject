
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageMethod{


  storeToFirebaStorage(String childName, Uint8List photoFile)async {

Reference reference = FirebaseStorage.instance.ref().child(childName).child(FirebaseAuth.instance.currentUser!.uid);
UploadTask uploadTask = reference.putData(photoFile);
 



 uploadTask.whenComplete(() {

  reference.getDownloadURL().then((downloadedStringUrl) {

   return downloadedStringUrl;


 });
 



  });


  }

}