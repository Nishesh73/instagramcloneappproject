import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramcloneapp/model/usermodel.dart';
import 'package:instagramcloneapp/providers/user_provider.dart';
import 'package:instagramcloneapp/services/firestore_methods.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/utils_gallery.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
 Uint8List? uintfile;
  String? description;
  bool isLinearIndicatorLoading = false;
  bool isCircularBarloading = false;

  clearPostImage(){

    setState(() {
      uintfile = null;
    });
  }

  showMyDialogBox(){

    return showDialog(
      barrierDismissible: false,
      context: context, builder: ((context) {
      
      return SimpleDialog(
        
        title: Text("Choose an option"),
        children: [
          SimpleDialogOption(
            child: Text("Choose image from gallery"),
            onPressed: (() async {

              setState(() {
                isCircularBarloading = true;
              });
            Uint8List uFile = await picksImage(ImageSource.gallery);
            setState(() {
              isCircularBarloading = false;
            });
            Navigator.of(context).pop();


            setState(() {
              uintfile = uFile;
            });

              
            }),
          ),

          SimpleDialogOption(child: Text("Choose from camera"),
          onPressed: (()async {
              Uint8List uinFile =  await picksImage(ImageSource.camera);

            setState(() {
              uintfile = uinFile;
            });
            
          }),),
           SimpleDialogOption(child: Text("Cancel.."),
          onPressed: (() {
            Navigator.of(context).pop();
            
          }),),
        ],

      );
      
    }));
  }
  
  @override
  Widget build(BuildContext context) {
     Users? users = Provider.of<UserProvider>(context).getUsers;
    //  if(users == null){
    //  return Center(child: CircularProgressIndicator(
    //     color: Colors.white,
    //  ),
    //  );

    //  }

    return uintfile==null? Center(child: IconButton(onPressed: (){
      showMyDialogBox();
      

    }, icon: Icon(Icons.upload),),):

    isCircularBarloading?Center(child: CircularProgressIndicator()): Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        leading: IconButton(
          onPressed: (() {
            clearPostImage();
          }),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Post to."),
        actions: [
          TextButton(
              onPressed: ()async {
                  setState(() {
                    isLinearIndicatorLoading = true;
                  });

                try {
                
                    await FirestoreMethods().uploadPost(description!, uintfile!, users!.id, users.userName, users.photoUrl);
                    setState(() {
                      isLinearIndicatorLoading = false;
                    });
                    mySnackBars(context, "posted");
                    clearPostImage();
                } catch (e) {
                    setState(() {
                      isLinearIndicatorLoading = false;
                    });
                  mySnackBars(context, e.toString());
                 // print(e); 
                }



              


                
              },
              child: Text(
                "Post",
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Column(
        children: [
         isLinearIndicatorLoading? LinearProgressIndicator():Container(margin: EdgeInsets.only(top: 5.0),),
         Divider(color: Colors.white,),
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(10.0),
                child: CircleAvatar(
                  // backgroundImage: Image.network(users.photoUrl)
                  child: Image.network(users!.photoUrl),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  onChanged: ((value) {
                    setState(() {
                      description = value;
                      
                    });
                  }),
                  maxLength: 100,
                  maxLines: 2,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: InputBorder.none,
                      hintText: "Write a caption"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 200),
                child: SizedBox(
                  height: 40,
                  width: 40,
                
                  child: AspectRatio(
                    aspectRatio: 5 / 4,
                    child:Container(
                     
                      decoration: BoxDecoration(
                        image:DecorationImage(image: MemoryImage(uintfile!) ,
                        fit: BoxFit.fill ),
                         
                      ),
                    )
                        

                    
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
