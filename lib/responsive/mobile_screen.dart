import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/providers/user_provider.dart';

import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/global_variable.dart';
import 'package:provider/provider.dart';

import '../model/usermodel.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  PageController pageController = PageController();

  

int pageIndex = 0;
   

  @override
  Widget build(BuildContext context) {
   // Users users = Provider.of<UserProvider>(context).getUsers;
    
    
    return Scaffold(
      
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height-90,
            child: PageView(

             


             controller: pageController,

                  onPageChanged: (inedx){
                    setState(() {
                      pageIndex = inedx;
                    });



                  },

              children: [
             pageViewScreens[0],
              pageViewScreens[1],
              pageViewScreens[2],
               pageViewScreens[3],
                pageViewScreens[4],
              
             


            ],),
          )
          
          
        ],


      ),
      
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange,

        

         currentIndex: pageIndex, //only for changing color and other properties

        type: BottomNavigationBarType.fixed,

       onTap: (int bottomTabIndexes){

        setState(() {
 
          pageController.jumpToPage(bottomTabIndexes);
          
          
        });



       },

      
        
        items: [
      BottomNavigationBarItem(icon: Icon(Icons.home,color: pageIndex==0?primaryColor:secondaryColor,), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.search, color: pageIndex==1?primaryColor:secondaryColor,), label: ""),

      BottomNavigationBarItem(icon: Icon(Icons.add, color: pageIndex==2?primaryColor:secondaryColor,), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.favorite, color: pageIndex==3?primaryColor:secondaryColor,), label: ""),
      BottomNavigationBarItem(icon: Icon(Icons.person, color: pageIndex==4?primaryColor:secondaryColor,), label: ""),




      ]),
    );
  }
}
