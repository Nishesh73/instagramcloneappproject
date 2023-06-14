import 'package:cloud_firestore/cloud_firestore.dart';

class Posts {
  String description;
  String uid;
  String userName;
  String postId;
  final datePublished;
  String postUrl;
  String profImage;
  final likes;

  Posts(
      {required String this.description,
      required String this.uid,
      required String this.userName,
      required String this.postId,
      required this.datePublished,
      required this.postUrl,
      required this.profImage,
      required this.likes});

  //to store in firebase mapdata

  Map<String, dynamic> toMapdata(){

    return{
      "description": description,
      "uid": uid,
      "userName": userName,
      "postId": postId,
      "datePublished": datePublished,
      "postUrl": postUrl,
      "profImage": profImage,
      "likes" : likes,
 };
} 

  Posts mapDataToRequireData(DocumentSnapshot snapshot){

    return Posts(
         description: snapshot.get("description"),
     uid: snapshot.get("uid"), 
     userName: snapshot.get("userName"),
      postId: snapshot.get("postId"), 
      datePublished: snapshot.get("datePublished"), 
      postUrl: snapshot.get("postUrl"), 
      profImage: snapshot.get("profImage"), 
      likes: snapshot.get("likes")
      
   
    );


  }





}
