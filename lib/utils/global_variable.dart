import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:instagramcloneapp/screens/add_post.dart';
import 'package:instagramcloneapp/screens/favourite_screen.dart';
import 'package:instagramcloneapp/screens/feed_screen.dart';
import 'package:instagramcloneapp/screens/profile_screen.dart';

import 'package:instagramcloneapp/screens/search_screen.dart';

const webscreenSize = 700;

 List pageViewScreens = [
   FeedScreen(),
               SearchScreen(),
              AddPost(),
             FavouriteScreen(),
              ProfileScreen(userId: FirebaseAuth.instance.currentUser!.uid,),

                // ProfileScreen(),


];