
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
 
class StorageMethods{

  final FirebaseStorage firebaseStorage=FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  //adding image to storage
  Future<String> uploadImageToStorage(String childName,Uint8List file,bool isPost) async{

  Reference ref=  firebaseStorage.ref().child(childName).child(firebaseAuth.currentUser!.uid);
  if(isPost){
    String id=Uuid().v1();
    ref=ref.child(id);//creating postid inside userid of firebase
  }
 UploadTask uploadTask= ref.putData(file);
 TaskSnapshot taskSnapshot= await uploadTask;
 String url=await taskSnapshot.ref.getDownloadURL();
 return url;
 
 
    



  }



}