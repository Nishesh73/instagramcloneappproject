import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';




 picksImage(ImageSource sourceType) async{
  XFile? xFile = await ImagePicker().pickImage(source: sourceType);


  if(xFile!=null){
   return await xFile.readAsBytes();
    print("success");
    }

    else
    print("error is occured");

 }





