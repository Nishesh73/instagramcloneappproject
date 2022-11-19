
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthMethods{
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
Future<String> signUpWithUser ({required String email,required String password,required String username,required String bio}) async{
   String res="some error occured";
  try{
    if(email.isNotEmpty||password.isNotEmpty||username.isNotEmpty||bio.isNotEmpty){
    UserCredential userCredential=await _auth.createUserWithEmailAndPassword(email: email, password: password);

    _firestore.collection("users").doc(userCredential.user!.uid).set({
      "name":username,
      "uid":userCredential.user!.uid,
      "email":email,
      "bio":bio,
      "followers":[],
      "following":[],


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





}

