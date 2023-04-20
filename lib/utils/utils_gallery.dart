import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';




 picksImage(ImageSource sourceType) async{
  XFile? xFile = await ImagePicker().pickImage(source: sourceType);


  if(xFile!=null){

   
   return await xFile.readAsBytes();
  
    }

    return null;
 }


 mySnackBars(BuildContext context, String content){

  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));



 }





