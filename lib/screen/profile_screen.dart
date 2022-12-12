import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/utils.dart';
import 'package:instagramcloneapp/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var snapdata;
  var postLength;
  var followerLength;
  var followingLength;

  bool isFollowing=false;
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading=true;
    });
    try {
      var snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(widget.uid)
          .get();
      snapdata = snap.data();

      followerLength=snapdata["followers"].length;
      followingLength=snapdata["following"].length;

      isFollowing=snap.data()!["followers"].contains(FirebaseAuth.instance.currentUser!.uid);



      //postdata
      var postdata = await FirebaseFirestore.instance
          .collection("posts")
          .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLength=postdata.docs.length;

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?Center(child: CircularProgressIndicator()): Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: Text(snapdata["name"]),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(snapdata["photourl"]),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          columIntems(postLength, "posts"),
                          columIntems(followerLength, "follower"),
                          columIntems(followingLength, "following"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FirebaseAuth.instance.currentUser!.uid==widget.uid? FollowButtons(
                            text: "Edit Profile",
                            function: () {},
                            backgroundColor: mobileBackgroundColor,
                            borderColor: Colors.grey,
                            textColor: primaryColor,
                          ):isFollowing? FollowButtons(
                            text: "Unfollow",
                            function: () {},
                            backgroundColor: Colors.white,
                            borderColor: Colors.black,
                            textColor: primaryColor,):FollowButtons(
                            text: "Follow",
                            function: () {},
                            backgroundColor: mobileBackgroundColor,
                            borderColor: Colors.blue,
                            textColor: primaryColor,
                            ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 6),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapdata["name"],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 6),
                        alignment: Alignment.centerLeft,
                        child: Text(snapdata["bio"]),
                      ),
                      Divider(),

                      FutureBuilder(
                        future: FirebaseFirestore.instance.collection("posts").where("uid",isEqualTo: widget.uid).get(),
                        builder: (context,snapshot){

                          if(snapshot.connectionState==ConnectionState.waiting){

                            return CircularProgressIndicator();
                          }


                          return GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 1) ,
                            itemCount: (snapshot.data as dynamic).docs.length,
                             itemBuilder:(context,index){
                              DocumentSnapshot snap=(snapshot.data as dynamic).docs[index];

                              return Container(
                                child: Image(image: NetworkImage(snap["postUrl"]),
                                fit: BoxFit.cover,
                                
                                ),

                              );

                             } );



                        })
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget columIntems(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
        ),
        Container(
            margin: EdgeInsets.only(top: 4.0),
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.0,
                  color: Colors.grey),
            )),
      ],
    );
  }
}
