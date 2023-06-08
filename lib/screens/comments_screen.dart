import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/model/usermodel.dart';
import 'package:instagramcloneapp/providers/user_provider.dart';
import 'package:instagramcloneapp/screens/feed_screen.dart';
import 'package:instagramcloneapp/services/firestore_methods.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/widgets/comments_card.dart';
import 'package:instagramcloneapp/widgets/post_card.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final snap;
  const CommentsScreen({super.key, this.snap});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  String description = "";
  
  @override
  Widget build(BuildContext context) {
   // Users? users = Provider.of<UserProvider>(context).getUsers;
   // Users? users = Provider.of<UserProvider>(context).getUsers;
    return Scaffold
    (

    

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.snap["postId"])
        .collection("comments")
        .limit(3)
        .orderBy("datePublished", descending: true)
        .snapshots()
        ,
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.active){

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final snapSubCol = snapshot.data!.docs[index].data();

                return CommentsCard(snapSubCol: snapSubCol);
            
              });
            
          }

          else{
            return Center(child: CircularProgressIndicator());
          }
        
      },),
      
      
    //  CommentsCard(),

      appBar: AppBar(title: Text("Comments Screen"),
      backgroundColor: mobileBackgroundColor,
      
      // leading: IconButton(onPressed: (){
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FeedScreen()));

      // }, icon: Icon(Icons.arrow_back)
      // ),
      
      ),

      bottomNavigationBar: Container(
        alignment: Alignment.bottomCenter,
        height: kToolbarHeight,
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage("${widget.snap["profImage"]}"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              onChanged: ((value) {
                setState(() {
                  description = value;
                  
                });
                
              }),
              decoration: InputDecoration(
                border: InputBorder.none,
              hintText: "Comment in post of ${widget.snap["userName"]} "
              ),
            ),
          ),
          
          
          Expanded(
            child: IconButton(onPressed: ()async
            {
            


            await  FirestoreMethods().commentPost(widget.snap["postId"], widget.snap["userName"], description, widget.snap["profImage"], widget.snap["uid"]);
           


          //feedactivity comment
          if(FirebaseAuth.instance.currentUser!.uid != widget.snap["uid"]){

           await FirebaseFirestore.instance.collection("activityfeed")
         .doc(widget.snap["uid"])
         .collection("feedItems")
         .add({
          "name": currentUserName,

        
          "commentData": description,
           "timeStamp": Timestamp.now(),
          "postId": widget.snap["postId"],
          "type": "comment",

          "userId": currentUserId,
          "postImage": widget.snap["postUrl"],
          "profileImage": currentUserProfile, 




         });
          }
         

            setState(() {
              description = "";
            });


            }, icon: Icon(Icons.send
            )),
          )

        ],)
      ),
    );
  }
}