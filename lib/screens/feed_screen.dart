
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

            if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }

       
       else if(snapshot.data.docs.length==0){
            return Center(child: Text("No post at all"));



          }
          

        // else if(snapshot.connectionState == ConnectionState.active){
          
       else if(snapshot.hasData){

            return Container(
              width: MediaQuery.of(context).size.width * .95,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {


                  return PostCard(
                    snap: snapshot.data?.docs[index].data(),
                  );
                  
                }),
            );

          }

        // }

      
        
          
          
         
        return Container();
        
      }
      // else return Center(child: Text("No post at all"));
      
      ,
      
      
      
      )
    );
  }
}