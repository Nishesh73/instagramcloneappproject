
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:instagramcloneapp/all_chat_message_screen.dart/home_chat_screen.dart';
import 'package:instagramcloneapp/all_chat_message_screen.dart/splash_screen.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/widgets/post_card.dart';
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset("lib/assets/ic_instagram.svg",
       // height: 64,
        color: primaryColor,),

        actions: [IconButton(onPressed: (() {


          
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SplashScreen()),
          );
        
        }), icon: Icon(Icons.chat_sharp)
        )],

      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          

          // if(snapshot.connectionState == ConnectionState.active)
          //  
          if(snapshot.hasData){

            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {


                return PostCard(
                  snap: snapshot.data?.docs[index].data(),
                );
                
              });

          }
          // else 
          
          //  return Center(child: Text("${snapshot.error}"));
         else return Center(child: CircularProgressIndicator());
        
      },)
    );
  }
}