import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/screen/add_post_screen.dart';
import 'package:instagramcloneapp/screen/feed_screen.dart';
import 'package:instagramcloneapp/screen/profile_screen.dart';
import 'package:instagramcloneapp/screen/search_screen.dart';

const webScreenSize=600.0;
List<Widget> homeScreens=[

        FeedScren(),
        SearchScreen(),
        AddPostScreen(),
        Center(child: Text("4")),
        ProfileScreen(uid:FirebaseAuth.instance.currentUser!.uid),
];
