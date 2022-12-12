import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagramcloneapp/screen/profile_screen.dart';
import 'package:instagramcloneapp/utils/colors.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController=TextEditingController();
  bool isShowUsers=false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: "Search for the user"
          ),

          onFieldSubmitted: ((value) {
            // here value is same as searchController.text

            setState(() {
              isShowUsers=true;
              
            });
            
          }),
          
          
        ),

      ),

      body:isShowUsers? FutureBuilder(future: FirebaseFirestore.instance.collection("users").where("name",isGreaterThanOrEqualTo: searchController.text).get(),
        builder: (context, snapshot) {

          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: (snapshot.data as dynamic).docs.length,
            itemBuilder: (context, index){

              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen(uid: (snapshot.data as dynamic).docs[index]["uid"])));
                },
                child: ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage((snapshot.data as dynamic).docs[index]["photourl"]),),
              
                  trailing: Text((snapshot.data as dynamic).docs[index]["name"]),
                ),
              );






          } );
          
        }):FutureBuilder(
          future:FirebaseFirestore.instance.collection("posts").get() ,
          builder:(context,snapshot){

            if(!snapshot.hasData){

              return CircularProgressIndicator();
            }

            return MasonryGridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              
              
              itemCount:(snapshot.data as dynamic).docs.length
            
            ,itemBuilder: (context,index){

              return Image.network((snapshot.data as dynamic).docs[index]["postUrl"]);

            });


          } ,
        ),


    );
  }
}