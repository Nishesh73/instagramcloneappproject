import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagramcloneapp/models/post.dart';
import 'package:instagramcloneapp/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth=FirebaseAuth.instance;

  // upload post

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String name, String profileImage) async {
    String res = "some error has occured";
    String postId = Uuid().v1();
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage("posts", file, true);
      Post post = Post(
        description: description,
        uid: uid,
        name: name,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        profileImage: profileImage,
        likes: [],
      );
      firestore.collection("posts").doc(postId).set(post.toJson());
      res="success";

    } catch (err) {
      res=err.toString();


    }
    return res;
  }

  Future<void> likePost(String postId, String uid, List likes) async{

    try{
      if(likes.contains(uid)){
       await firestore.collection("posts").doc(postId).update({
          "likes":FieldValue.arrayRemove([uid])


        });


      }else{
        await firestore.collection("posts").doc(postId).update({
          "likes":FieldValue.arrayUnion([uid])


        });


      }


    }catch(e){
      print(e.toString());
    }



  }

  Future<void> postComment(String postId,String text,String uid, String name,String profilePic)async{

    String commentId=Uuid().v1();

    try{
      if(text.isNotEmpty){
      await firestore.collection("posts").doc(postId).collection("comments").doc(commentId).set({
       "profilePic":profilePic,
       "name":name,
       "uid":uid,
       "text":text,
       "commentId":commentId,
       "datePublished":DateTime.now(),



      });


      }else{

        print("Text is empty");
      }


    }catch(e){
      print(e.toString());
    }



  }

  Future<void> deletePost(String postId)async{
    try{
      await firestore.collection("posts").doc(postId).delete();

    }catch(e){
      print(e.toString());
    }



  }

  Future<void> followUser(String uid,String followId) async{
   

    try {
       DocumentSnapshot documentSnapshot=await firestore.collection("users").doc(uid).get();
       List followIng=(documentSnapshot.data() as dynamic)["followIng"];
       if(followIng.contains(followId)){

      await firestore.collection("users").doc(followId).update({
        "followers":FieldValue.arrayRemove([uid]),
});      

   await firestore.collection("users").doc(followId).update({
        "following":FieldValue.arrayRemove([followId]),
});



       }
       else{
          await firestore.collection("users").doc(followId).update({
        "followers":FieldValue.arrayUnion([uid]),
});      

   await firestore.collection("users").doc(followId).update({
        "following":FieldValue.arrayUnion([followId]),
});


       }
      
    } catch (e) {
      print(e.toString());
      
    }




  }

  Future<void> signOut() async{
   await _auth.signOut();
   
    


  }
}
