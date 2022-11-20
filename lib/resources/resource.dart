
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagramcloneapp/resources/storage_methods.dart';

class AuthMethods{
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
Future<String> signUpWithUser ({required String email,required String password,required String username,required String bio,required Uint8List file}) async{
   String res="some error occured";
  try{
    if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty||file!=null){
    UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);

    String photourl=await StorageMethods().uploadImageToStorage("profilePics", file, false);

    _firestore.collection("users").doc(userCredential.user!.uid).set({
      "name":username,
      "uid":userCredential.user!.uid,
      "email":email,
      "bio":bio,
      "followers":[],
      "following":[],
      "photourl":photourl,


    });
    res="Success";
   

    //userCredential.user.uid
    }

  }
  catch(err){
    res=err.toString();
    

  }
  return res;





}

Future<String> signInUser({required String email,required String password }) async{
  String res="some error has occured";
  try{
    if(email.isNotEmpty||password.isNotEmpty){

 await _auth.signInWithEmailAndPassword(email: email, password: password);
 res="Success";
    }
    else{

      res="Please enter all the fields";


    }

  }
  catch(err){
    res=err.toString();

  }

  return res;



}





}

