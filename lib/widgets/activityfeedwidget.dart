
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/screens/profile_screen.dart';
import 'package:instagramcloneapp/widgets/dummy_file.dart';
import 'package:instagramcloneapp/widgets/show_fullscreen.dart';
// import 'package:instagramcloneapp/widgets/textinput_field.dart';
import 'package:intl/intl.dart';





String? activityText;
Widget? mediaPreview;
class ActivityFeed extends StatelessWidget {
  String? type;
  String? commentData;
  String? postId;
  String? postImage;
  String profileImage;
  Timestamp? timestamp;
  String userId;
  String currnetUserName;

  

   ActivityFeed({super.key,  required this.type, required this.commentData, 
  required this.postId, required this.postImage, required this.profileImage,
  required this.timestamp, required this.userId, required this.currnetUserName});

    

configureMediaPreViewFun(BuildContext context){

if(type == "like" || type == "comment"){
 mediaPreview = GestureDetector(
  onTap: (){
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowFullScreen(postId: postId,
    userId: userId,
    
    )));
  },
   child: Container(width: 50,
      height: 50,
      child: AspectRatio(aspectRatio: 16/9,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(postImage!,
          
          
          
          ),
          
          fit: BoxFit.fill)
        ),
 
      ),
 
      
      
      ) ,
      
      ),
 );


  }
  else mediaPreview = Text("");

  if(type == "like"){
    activityText = "likes your post";

  }
  else if(type == "comment"){
    activityText = "replied: $commentData";

  }
  else if(type == "following"){
    activityText = "following you";

  }
  else{

    activityText = "Error: unknown type $type";
  }




  // return Text("");


}

  @override
  Widget build(BuildContext context) {
  configureMediaPreViewFun(context);



    return Padding(
      padding: EdgeInsets.all(8),
      child: ListTile(
        subtitle: Text("${DateFormat.yMMMd().format(timestamp!.toDate())}"),

        title: GestureDetector(
          onTap: (() {

             Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: userId)));
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => DummyFile()  ));
            
          }),
          child: RichText(
            overflow: TextOverflow.ellipsis,
        
            
            text: TextSpan(
            style: TextStyle(fontSize: 15, color: Colors.yellow),
            children: [
              TextSpan(text: currnetUserName, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,
              fontSize: 18.0,
              )),
              TextSpan(text: " $activityText"),
        
        
            ]
        
        
            
          )),
        ),
        
         trailing: mediaPreview,
        
         
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profileImage == null? "" : profileImage),


      

         

        

      ),




    )
    );
  }
}