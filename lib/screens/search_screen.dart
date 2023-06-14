
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagramcloneapp/screens/profile_screen.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}



class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";

 @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: TextField(
          onChanged: (value){
            setState(() {

              searchQuery = value;
              
            });



          },


        ),


      ),


      body: StreamBuilder(stream: FirebaseFirestore.instance.collection("users").snapshots(),
      builder: ((context, snapshot) {

     
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());


        }
         else if(snapshot.data == null){
          return Text("There is no data in backend");
        }


        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          
          itemBuilder: (context, index){

            var querySnapshot = snapshot.data!.docs[index].data();
            var userSpecificId = querySnapshot["id"];

            if(searchQuery.isEmpty){


            //   return Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: GestureDetector(
            //       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: userSpecificId))),
            //       child: ListTile(
            //         leading: ClipRRect(
            //           borderRadius: BorderRadius.all(Radius.circular(20)),

            //           child: Container(
            //             height: 40,
            //             width: 40,
                      
                       
                                      
                       
                        
            //             child: Image.network(
                          
                          
            //               querySnapshot["photoUrl"],
            //               fit: BoxFit.fill,
                          
            //               ),
                        
                        
                        
            //             ),
            //         ),
            //         title: Text(querySnapshot["userName"]),
                
            //       ),
            //     ),
            //   );

            return Text("");
             }




            else if(querySnapshot["userName"].toString().toLowerCase().startsWith(searchQuery.toLowerCase())){
               return Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: userSpecificId))),

                   child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        height: 40,
                        width: 40,
                        
                        child: Image.network(
                          
                          
                          querySnapshot["photoUrl"],
                          fit: BoxFit.fill,
                          
                          
                          ),
                          
                          
                          ),
                    ),
                    title: Text(querySnapshot["userName"]),
                 
                               ),
                 ),
               );



            }



           return Container();

          });
       
       
          


        








        
      }),
      
      
      ),




    );

    

    
    }
    
    
    }
     