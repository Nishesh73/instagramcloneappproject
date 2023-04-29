import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';


import 'package:instagramcloneapp/all_chat_message_screen.dart/message_model.dart';

class ChatScreen extends StatefulWidget {
  var chatUserData;
  ChatScreen({super.key, this.chatUserData});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isEmojiShowing = false;
  String chatRoomide = "";
  List messageList = [];
  var logInUserId = "";
  TextEditingController _textEditingController = TextEditingController();

  

  chatRoomId() {
    // String id = FirebaseAuth.instance.currentUser!.uid.toString();
    if (logInUserId.hashCode <= widget.chatUserData["id"].hashCode) {
      return chatRoomide = logInUserId + "-" + widget.chatUserData["id"];
    } else
      return chatRoomide = widget.chatUserData["id"] + "-" + logInUserId;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    logInUserId = FirebaseAuth.instance.currentUser!.uid.toString();

    chatRoomId();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: (() {
          if(_isEmojiShowing){
            setState(() {
              _isEmojiShowing = false;
              
            });

          return  Future.value(false);



          }
         

          else return Future.value(true);

          
        }),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: _appBarDesign(),
          ),
          body: SingleChildScrollView(
            child: Expanded(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("chatMessages")
                              .doc(chatRoomide)
                              .collection("messages")
                              .orderBy("sentTime", descending: true)
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var messageData = snapshot.data.docs[index].data();
                          
                                    return logInUserId == messageData["fromId"]
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                          
                          //this section  is for logged in user yellow container                   
                          
                                                 Container(
                                                  margin: EdgeInsets.only(left:MediaQuery.of(context).size.width * .03),
                                                   child: Row(
                                                     children: [
                          
                                                      if(!messageData["readTime"].isEmpty)
                                                      Icon(Icons.done_all_rounded),
                                                      
                                                       Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal: MediaQuery.of(context)
                                                                      .size
                                                                      .width *
                                                                  .04,
                                                              vertical: MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  .04),
                                                          child: Text(
                                                             TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(messageData["sentTime"])).format(context),
                                                            //  messageData["sentTime"].toString(),
                                                            style: TextStyle(
                                                                color: Color.fromARGB(
                                                                    255, 243, 236, 236)),
                                                          )
                                                          
                                                          ),
                                                          
                                                          
                                                     ],
                                                   ),
                                                 ),
                                                Flexible(
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .04,
                                                        vertical: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .04),
                                                    child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                    .03),
                                                        child: Text(
                                                          messageData["message"],
                                                          style: TextStyle(
                                                              color: Colors.black),
                                                        )),
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 231, 218, 105),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(15.0),
                                                        topRight: Radius.circular(15.0),
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(15),
                                                      ),
                                                      border:
                                                          Border.all(color: Colors.blue),
                                                    ),
                                                  ),
                                                ),
                                               
                          
                          
                                              ],
                                            )
                          
                                          // Container(
                                          //   alignment: Alignment.bottomRight,
                                          //   child: Text( messageData["message"]??""))
                                          : Row(

                                            
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        horizontal: MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .04,
                                                        vertical: MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            .04),
                                                    child: Padding(
                                                        padding: EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical:
                                                                MediaQuery.of(context)
                                                                        .size
                                                                        .height *
                                                                    .03),
                                                        child: Text(
                                                          messageData["message"],
                                                          style: TextStyle(
                                                              color: Colors.white),
                                                        )),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Color.fromARGB(255, 50, 50, 4),
                                                      borderRadius: BorderRadius.only(
                                                        topLeft: Radius.circular(15.0),
                                                        topRight: Radius.circular(15.0),
                                                        bottomLeft: Radius.circular(15),
                                                        bottomRight: Radius.circular(0),
                                                      ),
                                                      border:
                                                          Border.all(color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * .03 ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.symmetric(
                                                            horizontal: MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                .04,
                                                            vertical: MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                .04),
                                                        child: Text(
                          
                                                         TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(messageData["sentTime"])).format(context),
                                                         // messageData["sentTime"].toString(),
                                                          style: const TextStyle(
                                                              color: Color.fromARGB(
                                                                  255, 243, 236, 236)),
                                                        ),
                          
                          
                                                      ),
                          
                                                   
                          
                          
                                                    ],
                          
                                                  ),
                                                ),
                          
                                                
                                              ],
                                            );
                                    // );
                          
                                    // Container(
                                    //   alignment: Alignment.bottomLeft,
                          
                                    //   child: Text( messageData["message"]??""))
                          
                                    // return MessageCard(
                                    //   peerUserId: widget.chatUserData,
                                    //   messageData: messageData,
                                    // );
                                  });
                            } else
                              return Center(child: CircularProgressIndicator());
                          }),
                    ),
                    SafeArea(child: _designBottomChatField()),
                    
                    Expanded(
                child:  SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                  width: double.infinity ,
                  child:_isEmojiShowing? EmojiPicker(
                  
                  textEditingController: _textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                  config: Config(
                      columns: 7,
                      emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0), // Issue: https://github.com/flutter/flutter/issues/28894
                      verticalSpacing: 0,
                      // horizontalSpacing: 0,
                    
                   
                  ),
                  ):null,
                ),
                    )
                    
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _designBottomChatField() {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: TextButton(
                        onPressed: () {
                        FocusScope.of(context).unfocus();

                          setState(() {
                            _isEmojiShowing = !_isEmojiShowing;
                            
                          });

                          
                        }, child: Icon(Icons.emoji_emotions))),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    autofocus: true,
                    onTap: (() {
                      if(_isEmojiShowing){
                        setState(() {
                          _isEmojiShowing = !_isEmojiShowing;
                        });
                      }
                      
                    }),
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
                    child:
                        TextButton(onPressed: () {}, child: Icon(Icons.image))),
                Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: TextButton(
                        onPressed: () async{

                         List <XFile?> xfiles = await ImagePicker().pickMultiImage();

                         if(xfiles.isNotEmpty){

                         for(var xfile in xfiles){
                          await xfile!.readAsBytes();


                         }
                         
                         }






                        }, child: Icon(Icons.camera))),
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
                onPressed: () async {

                  if(_textEditingController.text.isNotEmpty){
                  var time = DateTime.now().millisecondsSinceEpoch;
                  MessageModel messageModel = new MessageModel(toId:widget.chatUserData["id"], fromId: FirebaseAuth.instance.currentUser!.uid
                  , sentTime: time, readTime: "", message: _textEditingController.text, messageType: "");


                await FirebaseFirestore.instance
                  .collection("chatMessages")
                  .doc(chatRoomide)
                  .collection("messages")
                  .doc(time.toString())
                  .set(messageModel.toStoreInFirebase());

                  setState(() {
                    _textEditingController.text = "";
                  });
                  }
                 
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.send),
                ))),
      ],
    );
  }

  Widget _appBarDesign() {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            width: 24,
            height: 24,
            imageUrl: widget.chatUserData!["image"] ?? "",
            // placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.chatUserData["name"]),
              Text("last seen at"),
            ],
          ),
        )
      ],
    );
  }
}
