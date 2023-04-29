import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:instagramcloneapp/responsive/mobile_screen.dart';
import 'package:instagramcloneapp/responsive/responsivelayout.dart';
import 'package:instagramcloneapp/responsive/web_screen.dart';
import 'package:instagramcloneapp/screens/sign_up.dart';
import 'package:instagramcloneapp/services/firestore_methods.dart';


class ProfileScreen extends StatefulWidget {
  final userId;
  
  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 var userData = {};
 var userPostdata = {};
 var userPostlength = 0;
 var followersCount = 0;
 var followingCount = 0;
 var isFollowing = false;
 bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromFirestore();
  }

  getDataFromFirestore()async{

    setState(() {
      
      isLoading = true;
    });

    try {
      
       var snpUser = await FirebaseFirestore.instance.collection("users").doc(widget.userId).get();
       userData = snpUser.data()!;

       isFollowing = userData["following"].contains(FirebaseAuth.instance.currentUser!.uid);

       followersCount = userData["followers"].length;
       followingCount = userData["following"].length;
  //for docusnapshot .data.docs[index] not required
  var postSnap = await FirebaseFirestore.instance.collection("posts").where("id", isEqualTo: widget.userId).get();
  //userPostdata = postSnap.data();
  userPostlength = postSnap.docs.length;

  

  setState(() {
    
  });

    } catch (e) {
      print(e); 
    }
 
setState(() {
  isLoading = false;
});







  }

  
  @override
  Widget build(BuildContext context) {
    return isLoading?Center(child: CircularProgressIndicator()): Scaffold(
      appBar: AppBar(
        title: Text(userData["userName"]),
      ),

      body: ListView(
        
        children: [

          Column(
            children: [
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              
              children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(backgroundImage: NetworkImage(userData["photoUrl"]),),
              ),
              reUsableFoll(userPostlength, "posts"),
              reUsableFoll(followersCount, "Followers"),
              reUsableFoll(followingCount, "Following"),
          
          
            ],),
            InkWell(
              onTap: ()async {
              await  FirebaseAuth.instance.signOut();
                
              },
              child: Container(
                child: Text("Sing out"),
              
               
              ),
            )
              
             
              ,

          
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Container(
          child: Text( userData["userName"],style: TextStyle(fontWeight: FontWeight.bold),),
                 ),
            Container(
          child: Text(userData["bio"],style: TextStyle(fontWeight: FontWeight.bold),),
          
                 )
          
                 
          
            ],),
          
            Divider(color: Colors.yellow,),
          
            Container(
              height: 800,
           
              width: double.infinity,
              child: FutureBuilder(
                future: FirebaseFirestore.instance.collection("posts").where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString()).get(),
                builder: ((context, snapshot) {
                      
                  if(snapshot.hasData){
                    return ListView.builder(
                      // shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                      
                        return Container(
                          height: 50,
                          width: 50,
                          margin: EdgeInsets.only(top: 10.0),
                          
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            
                            
                           
                          ),
                          child: ListTile(
                            
                           
                            
                             leading: Image.network(snapshot.data!.docs[index]["postUrl"],
                             
                             fit: BoxFit.fill,)
                             
                            
                            ),
                        );
                          
                      }));
                      
                  
                      
                  }
                  return Text("Loading......");
                      
                  
                })),
            )
          
            
          
          
          
              
                
          
          
          
          ],)


        ],

      ),




    );
  }

  Column reUsableFoll(int num, String label){

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(num.toString()),
        Text(label),

      ],

    );
  }
}