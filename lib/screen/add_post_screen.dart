import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramcloneapp/models/user.dart';
import 'package:instagramcloneapp/providers/userprovider.dart';
import 'package:instagramcloneapp/resources/firestore_methods.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  TextEditingController _descriptionController = TextEditingController();
  bool _isLoading=false;

  void clearImage(){
    _file=null;
  }

  void postImage(String uid, String name, String profileImage) async {
    
    try {
      setState(() {
      _isLoading=true;
        
      });
      String res = await FirestoreMethods().uploadPost(
          _descriptionController.text, _file!, uid, name, profileImage);
      if (res == "success") {
         setState(() {
      _isLoading=false;
        
      });

        showSnackBar("Posted", context);
        clearImage();
      } else {
         setState(() {
      _isLoading=false;
        
      });
        showSnackBar(res, context);
      }
    } catch (err) {
       setState(() {
      _isLoading=false;
        
      });
      showSnackBar(err.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Create a post"),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Take a photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Choose a photo from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUserData;
    return _file == null
        ? Center(
            child: IconButton(
                onPressed: () {
                  _selectImage(context);
                },
                icon: Icon(Icons.upload)),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading:
                  IconButton(onPressed: clearImage, icon: Icon(Icons.arrow_back)),
              title: Text("Post to"),
              centerTitle: false,
              actions: [
                TextButton(
                    onPressed: () =>
                        postImage(user.uid, user.name, user.photourl),
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    )),
              ],
            ),
            body: Column(
              children: [
                _isLoading?Container(
                  margin: EdgeInsets.all(10.0),
                  child: LinearProgressIndicator()):Padding(padding:EdgeInsets.only(top: 0.0) ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.photourl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.40,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Write a caption....",
                        ),
                        maxLines: 7,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      height: 45,
                      child: AspectRatio(
                        aspectRatio: 480 / 489,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: MemoryImage(_file!),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                )
              ],
            ),
          );
  }
}
