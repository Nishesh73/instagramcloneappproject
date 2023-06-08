
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';





class ActivityFeed extends StatelessWidget {
  String? type;
  String? commentData;
  String? postId;
  String? postImage;
  String profileImage;
  Timestamp? timestamp;
  String userId;
  String currnetUserName;

   ActivityFeed({super.key,  required this.type, required this.commentData, 
  required this.postId, required this.postImage, required this.profileImage,
  required this.timestamp, required this.userId, required this.currnetUserName});

    





  @override
  Widget build(BuildContext context) {



    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
         trailing: CircleAvatar(backgroundImage: NetworkImage(postImage!),),
        title: Text("${DateTime.now().difference(timestamp!.toDate())}"),
         
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage == null? "" : profileImage),


      

         

        

      ),




    )
    );
  }
}