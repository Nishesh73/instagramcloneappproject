import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/cupertino.dart";
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/all_chat_message_screen.dart/chat_methods.dart';
import 'package:instagramcloneapp/screens/sign_up.dart';
import 'package:instagramcloneapp/services/firestore_methods.dart';


class ProfileChat extends StatefulWidget {
  
   ProfileChat({super.key});

  @override
  State<ProfileChat> createState() => _ProfileChatState();


}






class _ProfileChatState extends State<ProfileChat> {
  final _formKey = GlobalKey<FormState>();
  String name = "";
  String about = "";
  

 
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
    
        appBar: AppBar(title: Text("Chat Profile")),
    
        floatingActionButton: FloatingActionButton.extended(onPressed: ()async{
    
    
          await Future.delayed(Duration(microseconds: 5),(){
             Center(child: CircularProgressIndicator());
    
    
          });
    
         
    
          await FirebaseAuth.instance.signOut().then((value) { 
            //circular hide
            Navigator.pop(context);
    
            //pop chatprofile
          //  Navigator.pop(context);
            //pop home screen
           // Navigator.pop(context);
            //pop splash
           // Navigator.pop(context);
            //pop feedscreen
           // Navigator.pop(context);
    
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
    
    
           } );
          
    
    
    
    
        },
        backgroundColor: Colors.yellow,
        
         label: Text("Logout"), icon: Icon(Icons.logout),),
    
    
    
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("chatUser").doc(FirebaseAuth.instance.currentUser!.uid).snapshots(),
          
          builder: (context, snapshot) {
           
            var querydata = snapshot.data;
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                child: Form(
                  key: _formKey ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    
                    children: [
                     Stack(
                       children: [
                         ClipRRect(
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * .15 ),
                                     child: CachedNetworkImage(
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width * .3,
                                      height: MediaQuery.of(context).size.height * .3,
                                              imageUrl: querydata!["image"]??"",
                                             // placeholder: (context, url) => CircularProgressIndicator(),
                                              errorWidget: (context, url, error) => Icon(Icons.error),
                                        ),
                                   ),
                    
                                   Positioned(
                                    bottom: 2 ,
                                    right: 5,
                                     child: Container(
                                      height: 16,
                                      width: 16,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        
                                        borderRadius: BorderRadius.circular(8)),
                                       child: MaterialButton(onPressed: (){


                                              _showBottomSheetPlease();
                                       },
                                       
                                       child: Icon(CupertinoIcons.pencil),
                                                                    
                                       ),
                                     ),
                                   )
                       ],
                     ),
                    
                               Text(querydata["email"], style: TextStyle(fontWeight: FontWeight.bold),),
                    
                               TextFormField(

                                validator: ((value) {
                                  if(value!.isEmpty || value==null ){
                                    return "Enter required field";
                                  }
                                  else return null;
                                  
                                }),
                                onSaved: ((newValue) {
                                  setState(() {
                                    name = newValue??"";
                                    
                                  });
                                  
                                }),


                                initialValue: querydata["name"] ,
                                
                                decoration: InputDecoration(
                                  prefixIcon: Icon(CupertinoIcons.person),
                                  
                                  hintText: "ram shyam .....",
                                  labelText: "Name",
                    
                                ),
                    
                                
                    
                    
                               ),
                               SizedBox(height:MediaQuery.of(context).size.height * 0.03),
                    
                                TextFormField(
                                   validator: ((value) {
                                  if(value!.isEmpty || value==null ){
                                    return "Enter required field";
                                  }
                                  else return null;
                                  
                                }),
                                onSaved: ((newValue) {
                                  setState(() {
                                    about = newValue??"";
                                    
                                  });
                                  
                                }),
                                initialValue: querydata["about"] ,
                                
                                decoration: InputDecoration(
                                  prefixIcon: Icon(CupertinoIcons.info),
                                  
                                  hintText: "ram shyam .....",
                                  labelText: "About",
                    
                                ),
                                ),
                    
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.03,
                                ),
                    
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.1,
                               
                                  child: ElevatedButton.icon(onPressed: ()async{

                                  if(_formKey.currentState!.validate()){
                                    _formKey.currentState!.save();
                                   await updateUserInfo(name, about);

                                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Data is updated")));

                                    
                                  }


                                  }, icon: Icon(Icons.update),
                                  style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(),
                                  )
                                  , label: Text("update")),
                                ),
                    
                    
                    
                    
                  //  Image.network(querydata!["image"]),
                    
                    
                  ],),
                ),
              ),
            );
          
        },),
    
       
    
      ),
    );
  }
 //value return garna xaina
 void _showBottomSheetPlease(){

    showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      context: context, builder: (context){
      
      


      return ListView(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .03,
        left: MediaQuery.of(context).size.height * .03, top: MediaQuery.of(context).size.height * .03 ),
        shrinkWrap: true,
        
        children: [
        
        Text("Chose one option from below", textAlign: TextAlign.center,),

        Row(children: [
          ElevatedButton(onPressed: (){}, child: Image.asset("lib/assets/camura.jpg"),

               
          )

                                         
        ],)
      ],);


    });



  }


}

