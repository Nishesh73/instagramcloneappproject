
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