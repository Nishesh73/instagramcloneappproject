
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethod{


//for profile image
storeToFirebaStorage(String childName, Uint8List photoFile)async {

Reference reference = FirebaseStorage.instance.ref().child(childName).child(FirebaseAuth.instance.currentUser!.uid);
UploadTask uploadTask = reference.putData(photoFile);

String photoUrl = await (await uploadTask).ref.getDownloadURL();

return photoUrl;
 }
 
 //for post image

 postImagetoStorage(String childName, Uint8List photo)async{
  String postId = Uuid().v1();
 Reference reference = await FirebaseStorage.instance.ref().child(childName).child(FirebaseAuth.instance.currentUser!.uid).child(postId);

 UploadTask uploadTask = reference.putData(photo);

    String postImageUrl = await (await uploadTask).ref.getDownloadURL();
    return postImageUrl;





 }



}