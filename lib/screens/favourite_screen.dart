
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/widgets/activityfeedwidget.dart';


class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
       backgroundColor: mobileBackgroundColor,
        
        title: Text("Favourite or Activity Feed Screen"),),




        body: FutureBuilder(
          future: FirebaseFirestore.instance
          .collection("activityfeed")
          // .where("userId", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("feedItems")
          // .limit(1)
          // .orderBy("timeStamp", descending: true)
          .get(),
          
          builder: ((context, snapshot) {
            
          

             if(!snapshot.hasData){

              return CircularProgressIndicator();


            }

        //  else if(snapshot.data!.docs.length == 0){
        //   return Text("nothign to show");

        //     }

            return Container(
              width: MediaQuery.of(context).size.width * .95,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                
                itemBuilder: (context, index){
                  var dataFromQuery = snapshot.data!.docs[index].data();

                  // return Text(dataFromQuery["name"]);

                  return  ActivityFeed(
                    currnetUserName: dataFromQuery["name"],
                    type: dataFromQuery["type"],
                    timestamp: dataFromQuery["timeStamp"],
                    commentData: dataFromQuery["commentData"],
                    postId: dataFromQuery["postId"],
                    userId: dataFromQuery["currentUserId"],
                    postImage: dataFromQuery["postImage"],
                    profileImage: dataFromQuery["profileImage"],


                   );


                }),
            );
            
            
            


            
          })),


    );

  }
}