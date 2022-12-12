import 'package:flutter/material.dart';
import 'package:instagramcloneapp/providers/userprovider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';

class CommentCard extends StatefulWidget {
  final snap;
  const CommentCard({super.key,this.snap});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User user=Provider.of<UserProvider>(context).getUserData;
    return Container(
      padding: EdgeInsets.symmetric(vertical:18.0 ,horizontal:16.0 ),
      child: Row(
        children:[ CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage(widget.snap["profilePic"]),
        ),

        Expanded(
          child: Padding(padding: EdgeInsets.only(left: 16),
        
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        
              RichText(text: TextSpan(
                children: [
        
                  TextSpan(
                    text: widget.snap["name"],
                    style: TextStyle(fontWeight: FontWeight.bold)
        
                  ),
                    TextSpan(
                    text: " ${widget.snap["text"]}",
                   
        
                  ),
                  
        
        
                ]
        
        
              )),
        
        
              Padding(padding: EdgeInsets.only(top: 4),
        
              child: Text(DateFormat.yMd().format((widget.snap["datePublished"]).toDate())),
              
              ),
            
        
        
          ],),
        
        
          
          
          
          ),
        ),

        IconButton(onPressed: (){}, icon: Icon(Icons.favorite))

        ]
      ),





      




    );
  }
}