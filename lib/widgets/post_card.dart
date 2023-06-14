import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:instagramcloneapp/model/usermodel.dart';
import 'package:instagramcloneapp/providers/user_provider.dart';
import 'package:instagramcloneapp/screens/comments_screen.dart';
import 'package:instagramcloneapp/screens/profile_screen.dart';
import 'package:instagramcloneapp/services/firestore_methods.dart';
import 'package:instagramcloneapp/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

var currentUserName;
  var currentUserProfile;
  var currentUserId;

class PostCard extends StatefulWidget {
  
  final snap;
  PostCard({super.key, this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int length = 0;
  // bool isLikeAnimation = false;
  bool isLoading = false;
  bool showHeart = false;
  

  @override
  void initState() { 
    super.initState();
    getCommentsLength();
    
  }

  getCommentsLength()async{
    setState(() {
      isLoading = true;
    });

   var documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();

   currentUserName = documentSnapshot.data()!["userName"];
  currentUserProfile = documentSnapshot.data()!["photoUrl"];
  currentUserId = documentSnapshot.data()!["id"];



   QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("posts")
    .doc(widget.snap["postId"])
    .collection("comments").get();
  length =  querySnapshot.docs.length;

  setState(() {
    isLoading = false;
    
  });

  setState(() {
    
  });

   
   


  }
  @override
  Widget build(BuildContext context) {
    Users? users = Provider.of<UserProvider>(context).getUsers;

   
    
  
    return isLoading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
      child: Container(
        
   
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        widget.snap["profImage"]),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  GestureDetector(
                    onTap: (() {
                      Navigator.push(context, MaterialPageRoute(builder: (context
                      ) => ProfileScreen(userId: widget.snap["uid"])));
                      
                    }),
                    child: Text(
                      widget.snap["userName"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                              barrierDismissible: false ,
                              context: context, builder: (context){
                              return SimpleDialog(
                                
                                children: [
                                  SimpleDialogOption(
                                    child: Text("Delete post"),
                                    onPressed: () async{

                                      await FirestoreMethods().deletePost(widget.snap["postId"], context, widget.snap["uid"]);
                                      Navigator.of(context).pop();
                                    },

                                  ),

                                   SimpleDialogOption(
                                    child: Text("Cancel"),
                                    onPressed: () async{

                                      
                                      Navigator.of(context).pop();
                                    },

                                  ),

                                ],
                              );

                              
                            });


                          }, icon: Icon(Icons.more_vert)),
                    ),
                  )
                ],
              ),
              GestureDetector(
                onDoubleTap: ()async{

                  
                 

             var likePost =  await FirestoreMethods().likePost(widget.snap["postId"], widget.snap["uid"], widget.snap["likes"], widget.snap["userName"], widget.snap["profImage"], widget.snap["postUrl"]);

             if(likePost == true){
                 setState(() {
                    // isLikeAnimation = true;
                    showHeart = true;
                  });

                  Timer(Duration(milliseconds: 500), (() {
                    setState(() {
                      showHeart = false;
                    });
                    
                  }));


             }

                   




                 


                  
                },
                child: Stack(
                  alignment: Alignment.center,
                  children:
                  [Container(
                    padding: EdgeInsets.only(top: 10.0),
                    width: double.infinity,
                    height: 50.0,
                    child: Image.network(
                      widget.snap["postUrl"],
                      fit: BoxFit.fill,
                    ),
                  ),

                showHeart?  Center(child: Icon(Icons.favorite, color: Colors.white,
                size: 50,
                
                ))

                : Text(""),


            

                
              
                  // AnimatedOpacity(
                  //   duration: Duration(microseconds: 7000),
                  //   opacity: isLikeAnimation?1 : 0,
                  //   child: LikeAnimation(
                  //     duration: Duration(microseconds: 7000),
                  //     toWhichAnimationWillPerform: Icon(Icons.favorite, color: Colors.white,),
                  //     isAnimating: isLikeAnimation ,
                  //     animationonEndFuncion: () {
                  //       setState(() {
                  //         isLikeAnimation = false;
                  //       });
                        
                  //     },
                            
                            
                  //   ),
                  // ),


                  ]
              
              
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: ()async {
                        
                         await FirestoreMethods().likePost(widget.snap["postId"], widget.snap["uid"], widget.snap["likes"], widget.snap["userName"], widget.snap["profImage"], widget.snap["postUrl"] );
                        
                       
                      },
                      icon:
                      
                      widget.snap["likes"].contains(widget.snap["uid"])? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ):Icon(Icons.favorite_border),
                  ),



                  IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context
                        )=>CommentsScreen(
                          snap: widget.snap,

                        )
                        ));
                      },
                      icon: Icon(
                        Icons.comment_outlined,
                      )),
                
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultTextStyle(
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
                        child: Text("${widget.snap["likes"].length} likes"),
                        
                        ),
                    RichText(
                        text: TextSpan(
                      children: [
                        


                        TextSpan(text: widget.snap["description"],
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
                        
                        ),
                      ],
                    )),

                    GestureDetector(
                        onTap: (() {}),
                        child: Container(
                          child: Text(
                            "$length comment",
                         style:TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow),
                          ),
                        )),
                    Container(
                      child: Text(
                       DateFormat.yMMMd().format(widget.snap["datePublished"].toDate()) ,
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.yellow)
                      ),


                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
