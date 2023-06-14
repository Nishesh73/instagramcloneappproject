

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/widgets/post_card.dart';

class ShowFullScreen extends StatefulWidget {
  String? postId; String? userId;
ShowFullScreen({super.key, this.postId, this.userId});

  @override
  State<ShowFullScreen> createState() => _ShowFullScreenState();
}

class _ShowFullScreenState extends State<ShowFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text("Show full screen"),
      ),


      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("posts").where("postId", isEqualTo: widget.postId ).get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          else{

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: ((context, index) {
                var queryShowData = snapshot.data!.docs[index].data();
                return PostCard(snap: queryShowData,);
                
              }));


          }
          

          
          
        },),



    );
  }
}