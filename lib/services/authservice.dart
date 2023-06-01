

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/all_chat_message_screen.dart/chat_user_model.dart';
import 'package:instagramcloneapp/model/usermodel.dart';
import 'package:instagramcloneapp/responsive/mobile_screen.dart';
import 'package:instagramcloneapp/responsive/responsivelayout.dart';
import 'package:instagramcloneapp/responsive/web_screen.dart';
import 'package:instagramcloneapp/services/storage_methods.dart';
import 'package:instagramcloneapp/utils/global_variable.dart';

class AuthService {


  getUserDetails()async{

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
                                               .collection("users")
                                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                                 .get();


        return Users.map_Data_of_FirestoreToRequiredData(documentSnapshot);
        }


        
  signUp(
      {required String userName,
      required String email,
      required String password,
      required String bio,
      required Uint8List uintFile,
      required BuildContext context}) async {

    


    try {
    
      
      
      
  
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);



        String photoUrl =
          await StorageMethod().storeToFirebaStorage("profilePics", uintFile);

          //all section about chats

  ChatUserModel chatUserModel =  ChatUserModel(image: photoUrl,
   about: "i am happy", 
   name: userName, createdAt: "5", 
   isOnline: false, id: userCredential.user!.uid, 
   lastActive: "", 
   email: email, 
   pushToken: "");


  await  FirebaseFirestore.instance.collection("chatUser")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .set(chatUserModel.toChatMapData());

    print("data is stored in firebase");
//chat about
        

    

          Users user = Users(userName: userName,
          email: email, id: userCredential.user!.uid,
          bio: bio,
          following: [],
          followers: [],
          photoUrl: photoUrl,

          );



 await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.uid)
            .set(
              user.returnsMaptoStoreInFirebase()

              
         
        );//putting map data


          

        

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
