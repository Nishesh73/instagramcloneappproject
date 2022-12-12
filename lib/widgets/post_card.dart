import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:instagramcloneapp/models/user.dart';
import 'package:instagramcloneapp/providers/userprovider.dart';
import 'package:instagramcloneapp/resources/firestore_methods.dart';
import 'package:instagramcloneapp/screen/commenscreen.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({super.key, this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;

  getCommentlen() async {

    try{
      QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("posts")
        .doc(widget.snap["postId"])
        .collection("comments")
        .get();

        
   
   commentLen=snap.docs.length;

    }catch(e){
      showSnackBar(e.toString(), context);

    }
    setState(() {
      
    });
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommentlen();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUserData;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      color: mobileBackgroundColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                .copyWith(right: 0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.snap["profileImage"]),
                  radius: 16.0,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.snap["name"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: ListView(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                shrinkWrap: true,
                                children: ["Delete"]
                                    .map((e) => InkWell(
                                          onTap: () {
                                            FirestoreMethods().deletePost(widget.snap["postId"]);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12, horizontal: 16),
                                            child: Text(e),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ));
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.35,
            child: Image.network(
              widget.snap["postUrl"],
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  FirestoreMethods().likePost(
                      widget.snap["postId"], user.uid, widget.snap["likes"]);
                },
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CommentScreen(
                              snap: widget.snap,
                            ))),
                icon: Icon(Icons.comment),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.bookmark_border)),
              ))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      "${widget.snap["likes"].length} likes",
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                Container(
                  padding: EdgeInsets.only(top: 8.0),
                  width: double.infinity,
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                              text: widget.snap["name"],
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: " ${widget.snap["description"]}",
                          ),
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "View all $commentLen comments",
                      style: TextStyle(fontSize: 16, color: secondaryColor),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    DateFormat.yMd()
                        .format(widget.snap["datePublished"].toDate()),
                    style: TextStyle(fontSize: 16, color: secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
