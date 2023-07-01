

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

  
  String status = "";

cancelFriendRequest()async{
  try{
   await  FirebaseFirestore.instance
              .collection("frinedReqChat")
              .doc(currentUserId)
              .collection("requests")
              .doc(widget.snap["id"])
              .delete();

       //receiver doc
      await  FirebaseFirestore.instance
              .collection("frinedReqChat")
              .doc(widget.snap["id"])
              .collection("requests")
              .doc(currentUserId)
              .delete();

  }
  catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }



}

  getFirebaseData()async{
  var ds = await   FirebaseFirestore.instance
              .collection("frinedReqChat")
              .doc(currentUserId)
              .collection("requests")
              .doc(widget.snap["id"])
              .get();

              if(!ds.exists){
                status = "";

              }
              else{

              status = ds.data()!["status"];

              }



              

 

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

 if(status == "") ElevatedButton(onPressed: ()async{
              // List friendName = [];
              // friendName.add(currentUserId);


              //sender
              try {
                //sender
                 await  FirebaseFirestore.instance
              .collection("frinedReqChat")
              .doc(currentUserId)
              .collection("requests")
              .doc(widget.snap["id"])
              .set({
              "status": "sent"


              });
              //receivr
                await  FirebaseFirestore.instance
              .collection("frinedReqChat")
              .doc(widget.snap["id"])
              .collection("requests")
              .doc(currentUserId)
              .set({
              "status": "receiver"


              });




              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
              }
           

              // //receiver

              // FirebaseFirestore.instance
              // .collection("frinedReqChat")
              // .doc(widget.snap["id"])
              // .collection("requests")
              // .doc(currentUserId)
              // .set({
              //   "status": ""


              // });
           
               
 },
            
                

           
            


             child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Friend request Send",
              style: TextStyle(color: Colors.black,
              fontSize: 18,
              ),
              
              ),
            ),
            
             )
             
       else if(status == "sent")       ElevatedButton(onPressed: (){

        cancelFriendRequest();

        


             }, child: Text("Cancel friend request"))


      else if(status == "receiver")  ElevatedButton(onPressed: (){}, child: Text("Accept friend request")),


      // else ElevatedButton(onPressed: (){}, child: Text("Unfriend")),
     
            
                

            
              
          

            
            
            
        

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