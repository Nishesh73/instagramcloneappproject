// import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';

class ViewProfile extends StatefulWidget {
  final userName;
  final userPhtoUrl;
  
   ViewProfile({super.key, this.userName, this.userPhtoUrl});

  @override
  State<ViewProfile> createState() => _ViewProfileState();
}

class _ViewProfileState extends State<ViewProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar:AppBar(
        actions: [
          IconButton(onPressed: (() {
            Navigator.pop(context);
            
          }), icon: Icon(Icons.arrow_back)
          )
        ],

        
        
        title: Text(widget.userName)) ,


     body:  Image.network(widget.userPhtoUrl) ,


    );
  }
}