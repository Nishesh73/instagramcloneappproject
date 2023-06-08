

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/services/authservice.dart';
import 'package:instagramcloneapp/services/firestore_methods.dart';
import 'package:instagramcloneapp/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  final userId;
  const ProfileScreen({super.key, required this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = false;

  String? userName;
  String? imageUrl;
  String? description;

  bool isFollowing = false;
  int postLength = 0;

  int follwingLength = 0;
  int followersLength = 0;

  getMydataFromFirebase()async{
    setState(() {
      isLoading = true;
    });

  var documentSnapshot = await  FirebaseFirestore.instance.collection("posts").where("uid", isEqualTo: widget.userId).get();
  postLength = documentSnapshot.docs.length;

  var docuForusers = await FirebaseFirestore.instance.collection("users").doc(widget.userId).get();
  setState(() {
    isLoading = false;
  });
  userName = docuForusers.get("userName");
  description = docuForusers.get("bio");
  imageUrl = docuForusers.get("photoUrl");



 follwingLength = docuForusers.get("following").length;
 followersLength = docuForusers.get("followers").length;


//if specific user id's followers contains current user id 
 isFollowing = docuForusers.get("followers").contains(FirebaseAuth.instance.currentUser!.uid);
// follwingLength = docuForusers.data()!["following"];




setState(() {
  
});



  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getMydataFromFirebase();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading?Center(child: CircularProgressIndicator()) : Scaffold(
      appBar: AppBar(
        title: Text(userName!),
        backgroundColor: mobileBackgroundColor,

      ),



      body: ListView(
        shrinkWrap: true,
        
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                
                children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                      imageUrl!
                      
                      

                    ),
          
                  ),
                ),

                Column(
                  
                  
                  children: [
                  Row(
                   
                    
                    children: [
                    buildColumn(postLength, "post"),
                    SizedBox(width: 15.0,),
                buildColumn(followersLength, "followers"),
                SizedBox(width: 15.0,),
                buildColumn(follwingLength, "following"),
                SizedBox(width: 15.0,),
                

                  ],),

              FirebaseAuth.instance.currentUser!.uid == widget.userId?
              ElevatedButton(onPressed: (() async {
                   await FirestoreMethods().logOut();
                  }), child: Text("Sign out"))
              :
              
              isFollowing? ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: ()async{
                    await  FirestoreMethods().followUnfollowUser(FirebaseAuth.instance.currentUser!.uid
                , widget.userId
                );

                setState(() {
                  isFollowing = false;

              
                  
                });


                }, child: Text("UnFollow")):

              ElevatedButton(onPressed: (()async {

              await  FirestoreMethods().followUnfollowUser(FirebaseAuth.instance.currentUser!.uid
                , widget.userId
                );

                setState(() {
                  isFollowing = true;
                
                  
                });


              
              }), child: Text("Follow")),


             


                ],)

          
                
          
          
          
              ],),

              const SizedBox(height: 15.0,),


              Text(userName!,

              style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(description!),

              Divider(thickness: 5,
              color: Colors.blueGrey,),

              FutureBuilder(
                future: FirebaseFirestore.instance.collection("posts").where("uid", isEqualTo: widget.userId).get(),
                
                builder: ((context, snapshot) {

               
                   if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                   else if(snapshot.data!.docs.length == 0){
                    return Text("no post data");


                  }
                  else if(snapshot.hasData){
                    return Container(
                      
                      width: MediaQuery.of(context).size.width * .95,
                      child: ListView.builder(
                        
                        
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        
                        itemBuilder: ((context, index) {
                         
                         


                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Image.network(
                              
                              
                              snapshot.data!.docs[index].data()["postUrl"],
                              fit: BoxFit.cover,
                              
                              
                              ),
                          );

                          
                        }

                        

                        )
                        
                        
                        
                        
                        
                        
                        ),


                        
                    );



                  }


return Container(
  
);
                  
                })
                
                
              
                
                
                )





          
          
            ],
          
          ),
        )



      ],)
      
       


    );
  }
}

Widget buildColumn(int number, String text){

  return Column(
   
    
    children: [
    Text(number.toString(),
    style: TextStyle(fontSize: 25, color: Colors.white),
    ),
    Text(text),


  ],);



}
