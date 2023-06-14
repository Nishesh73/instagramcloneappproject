
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/model/post_model.dart';
import 'package:instagramcloneapp/services/storage_methods.dart';
import 'package:instagramcloneapp/utils/utils_gallery.dart';
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
    //for showing in feedactivity

    FirebaseFirestore.instance.collection("activityfeed")
    .doc(userSpecific_or_FollowId)
    .collection("feedItems")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .set({
       "timeStamp": Timestamp.now(),
          
          "type": "following",
          "name": currentUserName,

          "userId": currentUserId,
          "userSpecificId": userSpecific_or_FollowId,
          
          "profileImage": currentUserProfile , 




    });



  }

  else{

     FirebaseFirestore.instance.collection("users").doc(currentLoginUserid).update({
      "following": FieldValue.arrayRemove([userSpecific_or_FollowId])

    });

     FirebaseFirestore.instance.collection("users").doc(userSpecific_or_FollowId).update({
      "followers": FieldValue.arrayRemove([currentLoginUserid])

    });

    //removing from feed activity
     FirebaseFirestore.instance.collection("activityfeed")
    .doc(userSpecific_or_FollowId)
    .collection("feedItems")
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .get().then((documetn){

      if(documetn.exists){
        documetn.reference.delete();
        
      }

    });

    



  }

 










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

        return false;






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

          "userId": currentUserId,
          "postImage": postUrl,
          "profileImage": currentUserProfile , 


         });

         }

         return true;




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
        "userName": currentUserName,
        "comment": text,
        "userId": currentUserId,
        "profilePic": currentUserProfile,
        "datePublished": Timestamp.now()
       

      });
    } catch (e) {
      print(e); 
    }


  }

  deletePost(String postId, BuildContext context, String anyUid)async{

    try {
      if(FirebaseAuth.instance.currentUser!.uid == anyUid){

      
      await FirebaseFirestore.instance.collection("posts")
                                   .doc(postId).delete();

     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("post deleted")));                              

      }

      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Action cant be performed")));


      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));  
      print(e); 
    }
    

  }

  logOut(BuildContext context)async{

    try {
     await FirebaseAuth.instance.signOut();
    
    } catch (e) {
      mySnackBars(context, e.toString());
      print(e); 
    }
    
  }




}