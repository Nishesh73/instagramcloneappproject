import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:instagramcloneapp/model/usermodel.dart';
import 'package:instagramcloneapp/providers/user_provider.dart';
import 'package:instagramcloneapp/screens/comments_screen.dart';
import 'package:instagramcloneapp/services/firestore_methods.dart';
import 'package:instagramcloneapp/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  
  final snap;
  PostCard({super.key, this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int length = 0;
  bool isLikeAnimation = false;
  bool isLoading = false;

  @override
  void initState() { 
    super.initState();
    getCommentsLength();
    
  }

  getCommentsLength()async{
    setState(() {
      isLoading = true;
    });

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

    // if(users==null)
    // return Center(child: CircularProgressIndicator());
    
  
    return isLoading?Center(child: CircularProgressIndicator()): SingleChildScrollView(
      child: Container(
        
      //  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                Text(
                  widget.snap["userName"],
                  style: TextStyle(fontWeight: FontWeight.bold),
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

                                    await FirestoreMethods().deletePost(widget.snap["postId"], context);
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

                 setState(() {
                  isLikeAnimation = true;
                });
                await FirestoreMethods().likePost(widget.snap["postId"], widget.snap["uid"], widget.snap["likes"], widget.snap["userName"]);


               


                
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
            
                AnimatedOpacity(
                  duration: Duration(microseconds: 7000),
                  opacity: isLikeAnimation?1 : 0,
                  child: LikeAnimation(
                    duration: Duration(microseconds: 7000),
                    toWhichAnimationWillPerform: Icon(Icons.favorite, color: Colors.white,),
                    isAnimating: isLikeAnimation ,
                    animationonEndFuncion: () {
                      setState(() {
                        isLikeAnimation = false;
                      });
                      
                    },
                          
                          
                  ),
                ),
                ]
            
            
              ),
            ),
            Row(
              children: [
                IconButton(
                    onPressed: ()async {
                      
                       await FirestoreMethods().likePost(widget.snap["postId"], widget.snap["uid"], widget.snap["likes"], widget.snap["userName"] );
                      
                     
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
                // IconButton(
                //     onPressed: () {},
                //     icon: Icon(
                //       Icons.send,
                //     )),
                // Expanded(
                //   child: Align(
                //       alignment: Alignment.bottomRight,
                //       child: IconButton(
                //           onPressed: () {},
                //           icon: Icon(
                //             Icons.save,
                //           ))),
                // ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultTextStyle(
                      style: TextStyle(fontWeight: FontWeight.bold),
                      child: Text("${widget.snap["likes"].length} likes")),
                  RichText(
                      text: TextSpan(
                    children: [
                      TextSpan(
                          text: "${  widget.snap["userName"]}",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: widget.snap["description"]),
                    ],
                  )),
                  GestureDetector(
                      onTap: (() {}),
                      child: Container(
                        child: Text(
                          "$length",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                  Container(
                    child: Text(
                     DateFormat.yMMMd().format(widget.snap["datePublished"].toDate()) ,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
