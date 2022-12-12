import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/models/user.dart';
import 'package:instagramcloneapp/resources/firestore_methods.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/widgets/comment_card.dart';
import 'package:provider/provider.dart';

import '../providers/userprovider.dart';

class CommentScreen extends StatefulWidget {
  final snap;

  const CommentScreen({super.key, this.snap});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commenController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commenController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUserData;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text("Comments"),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .doc(widget.snap["postId"])
            .collection("comments").orderBy("datePublished",descending: false)
            .snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: ((context, index) {
                return CommentCard(
                  snap:snapshot.data.docs[index].data(),
                );
              }));
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: EdgeInsets.only(left: 16, right: 8),
          child: Row(
            children: [
              CircleAvatar(backgroundImage: NetworkImage(user.photourl)),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 8, right: 7),
                  child: TextField(
                    controller: commenController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Comment as ${user.name}"),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await FirestoreMethods().postComment(
                      widget.snap["postId"],
                      commenController.text,
                      user.uid,
                      user.name,
                      user.photourl);

                      setState(() {
                        commenController.text="";
                        
                      });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Text(
                    "Post",
                    style: TextStyle(
                      color: blueColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
