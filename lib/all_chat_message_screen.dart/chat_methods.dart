


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

updateUserInfo(String name, String about) async{

 await FirebaseFirestore.instance.collection("chatUser").doc( FirebaseAuth.instance.currentUser!.uid).update({
  "name": name.toString(),
  "about": about.toString(),




  });

}

  returnByteUintFile(XFile xFile) async{

    return await xFile.readAsBytes();
   



  }

  storeChatProfileInstorage(Uint8List uint8list)async{
    String chatProfile = Uuid().v1();
   Reference reference = FirebaseStorage.instance.ref().child("chatProfile").child(chatProfile);
   UploadTask uploadTask = reference.putData(uint8list);

 String url = await (await uploadTask).ref.getDownloadURL();

await FirebaseFirestore.instance
 .collection("chatUser")
 .doc(FirebaseAuth.instance.currentUser!.uid)
 .update({

  "image": url,

 });

   



  }


chatScreenMultiImagePicker(){


  
}
