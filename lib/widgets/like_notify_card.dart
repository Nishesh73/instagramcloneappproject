import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
class LikeNotify extends StatefulWidget {
  String userName;
   LikeNotify({super.key, required this.userName});

  @override
  State<LikeNotify> createState() => _LikeNotifyState();
}

class _LikeNotifyState extends State<LikeNotify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Like Notify Screen"),),

      body: ListView(children: [
        Row(children: [
          Text("${widget.userName} likes the photo posted"),

        ],)


      ],),


    );
  }
}