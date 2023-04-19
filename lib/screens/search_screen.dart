
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagramcloneapp/screens/profile_screen.dart';
import 'package:instagramcloneapp/screens/view_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}



class _SearchScreenState extends State<SearchScreen> {


@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  getPostData()async{
   

  }

  String? searchQuory;
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title:Container(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(

            onFieldSubmitted: (vale){
              setState(() {
                isSearching = true;
                 searchQuory = vale;

               // isSearching = true;
              // print(searchQuory);
                
              });
            


            },
              
            decoration: InputDecoration(
              hintText: "search something"
          
            ),
          ),
      ),


      ),

      body: isSearching? FutureBuilder(
        future: FirebaseFirestore.instance
        .collection("posts")
        .where("userName", isGreaterThanOrEqualTo: searchQuory).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          if(snapshot.hasData){


            // return GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), 
            //   itemBuilder: (context, index) {

            //     return ListTile(
            //       leading: CircleAvatar(backgroundImage: NetworkImage(
            //            snapshot.data!.docs[index]["profImage"]
            //         ) ,),
            //         title: Text(snapshot.data!.docs[index]["userName"]),
                

            //     );


                
            //   });

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {

                return GestureDetector(
                  onTap: (() {
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProfile(
                    userName: snapshot.data!.docs[index]["userName"] ,
                    userPhtoUrl: snapshot.data!.docs[index]["profImage"] ,


                   ),
                   ));
                    
                  }),
                  
                  child: ListTile(
                    leading: CircleAvatar(backgroundImage: NetworkImage(
                      snapshot.data!.docs[index]["profImage"]
                    ) ,),
                    title: Text(snapshot.data!.docs[index]["userName"]),
                  
                  
                  ),
                );
                
              });



          }
          else return Text("data is loading----");
        
      },):FutureBuilder(
        future: FirebaseFirestore.instance.collection("posts").get(),
        builder: (context, snapshot) {
          if(snapshot.hasData){

            return MasonryGridView.count(
              
              crossAxisCount: 3,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              
              itemCount: snapshot.data!.docs.length,
            
            itemBuilder: (context,index){


            return ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              
              child: Image.network(snapshot.data!.docs[index]["postUrl"]));

            });

            // return GridView.builder(
            //   scrollDirection: Axis.vertical,
            //   shrinkWrap: true,
              
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,crossAxisSpacing: 3,childAspectRatio: 2/4 ),
            //   itemCount: snapshot.data!.docs.length,
            
            //  itemBuilder: (context,index){
            //    return Image.network(snapshot.data!.docs[index]["postUrl"]);
            
            
            //  });

           

            // return ListView.builder(
            //   itemCount: snapshot.data!.docs.length,
            //   itemBuilder: (context, index) {

            //     return Image.network(snapshot.data!.docs[index]["postUrl"]);
                
            //   });
            

           
          }

          else{
            return Text("loading images.......");
          }


          
        }
        )




    );
  }
}