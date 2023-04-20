
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
class ChatScreen extends StatefulWidget {
  var chatUserData;
   ChatScreen({super.key, this.chatUserData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        automaticallyImplyLeading: false,
        flexibleSpace: _appBarDesign() ,

        
        

      ),

      body: Column(
        children: [
          
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("chatUser").where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                  
                    if(snapshot.hasData){
              
                  
              
                    }
              
                
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount:1 ,
                      itemBuilder: (context, index) {
              
                        return Text("No data found at all  🤲🏼 ");
                
              
                
                         
                            
                
                
                  
                        }
                        
                        
                 
                      
                      
                      
                      );
                
                
                
                  }),
              ),

          
          _designBottomChatField(),
        ],
      ),
    );
  }

  Widget _designBottomChatField(){


    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: TextButton(onPressed: (){}, child: Icon(Icons.emoji_emotions))),
          
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(color: Colors.red),
                      
                      decoration: InputDecoration(
                        hintText: "Type something....",
                        
                        border: InputBorder.none,
          
                      ),
                      
                      maxLines: null,
          
                      
                    ),
                  ),
          
                  Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: TextButton(onPressed: (){}, child: Icon(Icons.image))),
          
                  Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: TextButton(onPressed: (){}, child: Icon(Icons.camera))),
                   
               
              ],
          
            ),
          ),
        ),

         Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: MaterialButton(
                    color: Colors.red,
                   minWidth: 0,
                  
                    shape: CircleBorder(),
                    
                    onPressed: (){}, child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.send),
                    ))), 



      ],
    );
  }

  Widget _appBarDesign(){
    return Row(children: [
      IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back)

      ),

      ClipRRect(
                           borderRadius: BorderRadius.circular(12.0),
                                     child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      width: 24,
                                      height: 24,
                                              imageUrl: widget.chatUserData!["image"]??"",
                                             // placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                   ),

     Padding(
      padding: EdgeInsets.only(left: 10.0),

       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
        Text(widget.chatUserData["name"]),
        Text("last seen at"),
     
       ],),
     )                              



    ],);


  }


}