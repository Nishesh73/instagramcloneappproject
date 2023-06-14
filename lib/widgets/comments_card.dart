import 'package:flutter/material.dart';
import 'package:instagramcloneapp/widgets/post_card.dart';
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
            backgroundImage: NetworkImage(currentUserProfile!),

          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          RichText(text: TextSpan(
            children: [
              TextSpan(text: currentUserName,style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 18, color: Colors.white
              
              )),
              
              
             TextSpan(text: ' ${widget.snapSubCol["comment"]}',
             style: TextStyle(color: Colors.yellow)),


              


            ]
          )),

          Text(
            DateFormat.yMMMd().format(widget.snapSubCol["datePublished"].toDate())
            
         
            
            ),

        ],),

      

      ],) ,
      



    );
  }
}