import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentsCard extends StatefulWidget {
  final snapSubCol;
  const CommentsCard({super.key, this.snapSubCol});

  @override
  State<CommentsCard> createState() => _CommentsCardState();
}

class _CommentsCardState extends State<CommentsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Row(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage("${widget.snapSubCol["profilePic"]}"),

          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          RichText(text: TextSpan(
            children: [
              TextSpan(text: "${widget.snapSubCol["userName"]} ",style: TextStyle(fontWeight: FontWeight.bold)),
              
              
             TextSpan(text: '${widget.snapSubCol["comment"]}',),


              


            ]
          )),

          Text(
            DateFormat.yMMMd().format(widget.snapSubCol["datePublished"].toDate())
            
           // widget.snapSubCol["datePublished"]
            
            ),

        ],),

        Expanded(child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite))),


      ],) ,
      



    );
  }
}