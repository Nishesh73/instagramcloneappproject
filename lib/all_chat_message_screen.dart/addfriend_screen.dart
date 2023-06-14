
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({super.key});

  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add friends"),
      centerTitle: true,
      
      ),

      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("chatUser").where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots() ,
      builder:(context, snapshot) {


        if(snapshot.connectionState == ConnectionState.waiting){

          return Center(child: CircularProgressIndicator());

        }
        else if(snapshot.data!.docs.length == 0){
          return Text("No data to show");

        }
        else if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              var queryAddData = snapshot.data!.docs[index].data();

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(queryAddData["image"]),

                ),
                title: Text(queryAddData["name"]) ,


                trailing: Text("Add friend") ,


              ) ;
              
            }));

        }

        return Text("");
        
      } ,
      
      ),


      

    );
  }
}