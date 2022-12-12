import 'package:cloud_firestore/cloud_firestore.dart';

class Post{

  
  final String description;
  final String uid;
  final String name;
  final String postId;
  final datePublished;
  
  final String postUrl;
  final String profileImage;
  final  likes;

  Post({
    required this.description,
    required this.uid,
     required this.name,
    required this.postId,
     required this.datePublished,
    required this.postUrl,
    required this.profileImage,
    required this.likes,
    
    


  });

  Map<String,dynamic> toJson()=>{

    "description":description,
    "uid":uid,
    "name":name,
    "postId":postId,
    "datePublished":datePublished,
    "postUrl":postUrl,
    "profileImage":profileImage,
    "likes":likes




  };

  static Post fromSnap(DocumentSnapshot documentSnapshot ){
    
    return Post(
      description:documentSnapshot.get("description"),
      uid:documentSnapshot.get("uid"),
      name:documentSnapshot.get("name"),
      postId:documentSnapshot.get("postId"),
      datePublished: documentSnapshot.get("datePublished"),
      postUrl: documentSnapshot.get("postUrl"),
      profileImage: documentSnapshot.get("profileImage"),
      likes: documentSnapshot.get("likes"),


    );


  }
 



}