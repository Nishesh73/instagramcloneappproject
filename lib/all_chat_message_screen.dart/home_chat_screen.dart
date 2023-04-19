import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagramcloneapp/all_chat_message_screen.dart/chat_profile.dart';

import 'package:instagramcloneapp/all_chat_message_screen.dart/chat_user_model.dart';


class HomeChat extends StatefulWidget {
  const HomeChat({super.key});

  @override
  State<HomeChat> createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {

  var dataUser;
  bool _isSearching = false;

 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      
      child: WillPopScope(
        onWillPop: (() {
          if(_isSearching){
            setState(() {
              _isSearching = false;
              
            });
            

            return Future.value(false);


          }
          else return Future.value(true);


          
        }),

        child: Scaffold(
          
          appBar: AppBar(
            leading: Icon(CupertinoIcons.home),
            title: _isSearching?TextField(
          
              onChanged: (value){
          
                
              },
              autofocus: true,
              decoration: InputDecoration(
                
                border: InputBorder.none,
                hintText: "Enter name or email"
          
              ),
          
          
            ): Text("We Chat"),
          
            actions: [
              IconButton(onPressed: (){
                setState(() {
                  _isSearching = !_isSearching;
                  
                  
                });
          
          
          
              }, icon:  Icon(_isSearching?CupertinoIcons.clear_circled_solid:Icons.search)),
          
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileChat()));
          
              }, icon: Icon(Icons.more_vert)),
              
          
            ],
          
           
          
          ),
          
          floatingActionButton: FloatingActionButton(onPressed: (){},
          child: Icon(CupertinoIcons.add),
          
          ),
          
          body: SingleChildScrollView(
            child: Container(
              
              width: double.infinity,
         
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("chatUser").where("id", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
              
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length ,
                    itemBuilder: (context, index) {
              
                       dataUser = snapshot.data!.docs[index].data();
              
                      if(snapshot.hasData){
          
                         return Card(
                          child: ListTile(
                           // leading: Image.network(dataUser["image"]??""),
                           leading: ClipRRect(
                            borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * .025 ),
                             child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width * .05,
                              height: MediaQuery.of(context).size.height * .05,
                                      imageUrl: dataUser["image"]??"",
                                     // placeholder: (context, url) => CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => Icon(Icons.error),
                                ),
                           ),
                            title: Text(dataUser["name"]??""),
                            subtitle: Text(dataUser["about"]??""),
                            // trailing: Text(dataUser["createdAt"]??""),
                            trailing: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(7.5)
                              ),
                              
                              
                              
                            ),
          
                          ),
          
                         );
              
                       
                          
              
              
                        
                       
              
                      }
                      
                              
                     else{
                          return Center(child: CircularProgressIndicator());
              
                   } 
              
                  
              
              
                      
                    },
                    
                    
                    
                    );
              
              
              
                }),
            ),
          ),
          
          // body: ChatCard() ,
          
          
        ),
      ),
    );
  }
}