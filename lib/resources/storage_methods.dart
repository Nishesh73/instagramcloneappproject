
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
 
class StorageMethods{

  final FirebaseStorage firebaseStorage=FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  //adding image to storage
  Future<String> uploadImageToStorage(String childName,Uint8List file,bool isPost) async{

  Reference ref=  firebaseStorage.ref().child("profilePics").child(firebaseAuth.currentUser!.uid);
 UploadTask uploadTask= ref.putData(file);
 TaskSnapshot taskSnapshot= await uploadTask;
 String url=await taskSnapshot.ref.getDownloadURL();
 return url;
 
 
    



  }



}