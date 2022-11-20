
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource imageSource) async{
  ImagePicker imagePicker=ImagePicker();

 XFile? xFile=await  imagePicker.pickImage(source: imageSource);
 //Xfile? mean file can be null
 if(xFile!=null){
  return await xFile.readAsBytes();


 }

 print("No image is selected");


}

showSnackBar(String contenttext,BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(contenttext)),


  );


}