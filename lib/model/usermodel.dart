
import 'package:cloud_firestore/cloud_firestore.dart';

class Users{

  String userName, email, id, bio, photoUrl;
  List following, followers;

  Users({
    required String this.userName,
     required String this.email,
     required String this.id,
      required String this.bio,
       required List this.following,
       required List this.followers,
        required String this.photoUrl,




  });




  Map<String, dynamic> returnsMaptoStoreInFirebase(){


   return {
   "userName": userName,
   "email": email,
   "id": id,
   "bio":  bio,
   "following": following,
   "followers": followers,
    "photoUrl": photoUrl,

 };

  }
 
  





static Users map_Data_of_FirestoreToRequiredData(DocumentSnapshot snap){

  return Users(
  userName: snap.get("userName"), 
  email: snap.get("email"), 
  id: snap.get("id"), 
  bio: snap.get("bio"), 
  following: snap.get("following"), 
  followers: snap.get("followers"), 
  photoUrl: snap.get("photoUrl"),
  
  
  );
 






 }





}