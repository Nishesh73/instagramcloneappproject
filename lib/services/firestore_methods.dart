
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/model/post_model.dart';
import 'package:instagramcloneapp/services/storage_methods.dart';
import 'package:instagramcloneapp/widgets/post_card.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethods{


  followUnfollowUser(String currentLoginUserid, String userSpecific_or_FollowId)async{

  DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(userSpecific_or_FollowId).get();
  var userIdSpecificFollowList = documentSnapshot.get("followers");



  if(!userIdSpecificFollowList.contains(currentLoginUserid)){

    FirebaseFirestore.instance.collection("users").doc(currentLoginUserid).update({
      "following": FieldValue.arrayUnion([userSpecific_or_FollowId])

    });

     FirebaseFirestore.instance.collection("users").doc(userSpecific_or_FollowId).update({
      "followers": FieldValue.arrayUnion([currentLoginUserid])

    });


  }

  else{

     FirebaseFirestore.instance.collection("users").doc(currentLoginUserid).update({
      "following": FieldValue.arrayRemove([userSpecific_or_FollowId])

    });

     FirebaseFirestore.instance.collection("users").doc(userSpecific_or_FollowId).update({
      "followers": FieldValue.arrayRemove([currentLoginUserid])

    });




  }

  // if(userIdSpecificFollowList.contains(currentLoginUserid)){
  //   FirebaseFirestore.instance.collection("users").doc(userSpecific_or_FollowId).update({
  //     "followers": FieldValue.arrayRemove([currentLoginUserid])

  //   });

  //    FirebaseFirestore.instance.collection("users").doc(currentLoginUserid).update({
  //     "following": FieldValue.arrayRemove([userSpecific_or_FollowId])

  //   });


  // }
  // else{
  //    FirebaseFirestore.instance.collection("users").doc(userSpecific_or_FollowId).update({

  //     "followers": FieldValue.arrayUnion([currentLoginUserid])

  //   });

  //    FirebaseFirestore.instance.collection("users").doc(currentLoginUserid).update({
  //     "following": FieldValue.arrayUnion([userSpecific_or_FollowId])

  //   });





  // }






  }







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
       datePublished: Timestamp.now(), 
       postUrl: postPhotoUrl, 
       profImage: profImage, 
       likes: []);

      FirebaseFirestore.instance.collection("posts").doc(postId).set(posts.toMapdata());


      
    } catch (e) {
      print(e); 
    }




  }

likePost(String postId, String userId, List likes, String userName, String profImage, String postUrl)async{

    try {
      if(likes.contains(userId)){
        // LikeNotify(userName: userName);


       await FirebaseFirestore.instance.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayRemove([userId])


        });

        
        if(FirebaseAuth.instance.currentUser!.uid != userId){

         await FirebaseFirestore.instance.collection("activityfeed")
         .doc(userId)
         .collection("feedItems")
         .doc(postId)
         .delete();

        }






      }

      else{


        
        await FirebaseFirestore.instance.collection("posts").doc(postId).update({
          "likes": FieldValue.arrayUnion([userId])
         });

         //for add like feed activity
         
         if(FirebaseAuth.instance.currentUser!.uid != userId){
         await FirebaseFirestore.instance.collection("activityfeed")
         .doc(userId)
         .collection("feedItems")
         .doc(postId)
         .set({
          "timeStamp": Timestamp.now(),
          "postId": postId,
          "type": "like",
          "name": currentUserName,

          "currentUserId": currentUserId,
          "postImage": postUrl,
          "profileImage": currentUserProfile , 


         });

         }




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
        "datePublished": Timestamp.now()
       

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