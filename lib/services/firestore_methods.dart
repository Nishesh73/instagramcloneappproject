
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/model/post_model.dart';
import 'package:instagramcloneapp/services/storage_methods.dart';
import 'package:instagramcloneapp/widgets/like_notify_card.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods{

  uploadPost(String description, Uint8List file,
  String uid, String userName, String profImage
  )
  async{

    try {
      String postId = Uuid().v1();
      String postPhotoUrl = await StorageMethod().postImagetoStorage("posts", file);

      Posts posts =  Posts(
       description: description,
       uid: uid, 
       userName: userName, 
       postId: postId, 
       datePublished: DateTime.now(), 
       postUrl: postPhotoUrl, 
       profImage: profImage, 
       likes: []);

      FirebaseFirestore.instance.collection("posts").doc(postId).set(posts.toMapdata());


      
    } catch (e) {
      print(e); 
    }




  }

likePost(String postId, String userId, List likes, String userName)async{

    try {
      if(likes.contains(userId)){
        LikeNotify(userName: userName);


      return await FirebaseFirestore.instance.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([userId])


        });

      }

      else{
        userName = "No one";


       LikeNotify(userName: userName,);
        return await FirebaseFirestore.instance.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([userId])
         });
      }


       
    } catch (e) {
      print(e.toString()); 
    }


  }

  commentPost (String postId, String userName,String text, String profileImage, String userId )async{

    try {
      String commentId = Uuid().v1();
      FirebaseFirestore.instance
      .collection("posts")
      .doc(postId)
      
      .collection("comments")
      .doc(commentId)
      
      .set({
        "userName": userName,
        "comment": text,
        "userId": userId,
        "profilePic": profileImage,
        "datePublished": DateTime.now()
       

      });
    } catch (e) {
      print(e); 
    }


  }

  deletePost(String postId, BuildContext context)async{

    try {
      await FirebaseFirestore.instance.collection("posts")
                                   .doc(postId).delete();

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("post deleted")));                              

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));  
      print(e); 
    }
    

  }

  logOut()async{

    try {
     await FirebaseAuth.instance.signOut();
    
    } catch (e) {
      print(e); 
    }
    
  }




}