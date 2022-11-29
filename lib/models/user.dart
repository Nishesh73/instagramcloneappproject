
import 'package:cloud_firestore/cloud_firestore.dart';

class User{

  
  final String email;
  final String uid;
  final String photourl;
  final String bio;
  final String name;
  final List followers;
  final List following;

  User({
    required this.email,
    required this.uid,
     required this.photourl,
    required this.bio,
     required this.name,
    required this.followers,
    required this.following,
    
    


  });

  Map<String,dynamic> toJson()=>{

    "email":email,
    "uid":uid,
    "photourl":photourl,
    "bio":bio,
    "name":name,
    "followers":followers,
    "following":following,




  };

  static User fromSnap(DocumentSnapshot documentSnapshot ){
    
    return User(
      email:documentSnapshot.get("email"),
      uid:documentSnapshot.get("uid"),
      photourl:documentSnapshot.get("photourl"),
      bio:documentSnapshot.get("bio"),
      name: documentSnapshot.get("name"),
      followers: documentSnapshot.get("followers"),
      following: documentSnapshot.get("following"),


    );


  }
 



}