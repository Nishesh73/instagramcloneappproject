

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/widgets/post_card.dart';

class FriendRequestPage extends StatefulWidget {
  var snap;
   FriendRequestPage({super.key, this.snap});

  @override
  State<FriendRequestPage> createState() => _FriendRequestPageState();
}







class _FriendRequestPageState extends State<FriendRequestPage> {
  bool alreadYsendFriendRequest = false;

  getFirebaseData()async{
  var ds = await  FirebaseFirestore.instance.collection("chatFriendReqList").doc(widget.snap["id"]).get();

 List friendList = ds.data()!["friendList"];
 alreadYsendFriendRequest = friendList.contains(currentUserId);

  setState(() {
    
  });

  }

  @override
void initState() { 
  super.initState();
  getFirebaseData();
  
  
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.blue, 
      
      appBar: AppBar(

        
        backgroundColor: Colors.blue,

        title: Text("Friend Request"),

      ),

      body: SingleChildScrollView(child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            
            children: [
            Container(
              width: 190,
              height: 220,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.snap["image"]),
                  fit: BoxFit.fill,
                  
                )

              ),

            ),
            SizedBox(height: 10,),

            Text(widget.snap["name"], style: TextStyle(fontSize: 18,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            
            ),),
            SizedBox(height: 10,),

        !alreadYsendFriendRequest?    ElevatedButton(onPressed: ()async{
              // List friendName = [];
              // friendName.add(currentUserId);
              //receiver
              FirebaseFirestore.instance.collection("chatFriendReqList").doc(widget.snap["id"]).set({
                "friendList": FieldValue.arrayUnion([currentUserId]),
                

              },
              SetOptions(merge: true),
              
              );
              //sender
              FirebaseFirestore.instance.collection("chatFriendReqList").doc(currentUserId).set({
                "friendList": FieldValue.arrayUnion([widget.snap["id"]]),
               

              },
              SetOptions(merge: true),
              
              );



            }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Friend request Send",
              style: TextStyle(color: Colors.black,
              fontSize: 18,
              ),
              
              ),
            )
            
            ):
            
            FirebaseAuth.instance.currentUser!.uid == widget.snap["id"]?  ElevatedButton(onPressed: ()async{
              //  FirebaseFirestore.instance.collection("chatFriendReqList").doc(widget.snap["id"]).set({
              //   "friendList": FieldValue.arrayRemove([currentUserId]),
                

              // },
              // SetOptions(merge: true),
              
              // );
              // //sender
              // FirebaseFirestore.instance.collection("chatFriendReqList").doc(currentUserId).set({
              //   "friendList": FieldValue.arrayRemove([widget.snap["id"]]),
                

              // },
              // SetOptions(merge: true),
              
              // );
            

            }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Cancel friend request",
              style: TextStyle(color: Colors.black,
              fontSize: 18,
              ),
              
              ),
            )
            
            ): ElevatedButton(onPressed: ()async{
               FirebaseFirestore.instance.collection("chatFriendReqList").doc(widget.snap["id"]).set({
                "friendList": FieldValue.arrayRemove([currentUserId]),
                

              },
              SetOptions(merge: true),
              
              );
              //sender
              FirebaseFirestore.instance.collection("chatFriendReqList").doc(currentUserId).set({
                "friendList": FieldValue.arrayRemove([widget.snap["id"]]),
                

              },
              SetOptions(merge: true),
              
              );
            

            }, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Accept friend request",
              style: TextStyle(color: Colors.black,
              fontSize: 18,
              ),
              
              ),
            )
            
            )


            
            
            ,
            SizedBox(height: 10,),


              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                
                onPressed: (){}, child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Friend request decline",
            style: TextStyle(color: Colors.black,
            fontSize: 18,
            ),
            
            ),
            
              )),





          ],),
        ),
      )),

      


    );
  }
}