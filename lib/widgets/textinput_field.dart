import "package:flutter/material.dart";

class Textinput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintext;
  final TextInputType textInputType;
  const Textinput({super.key,required this.textEditingController,this.isPass=false,required this.hintext,required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller:textEditingController ,
      decoration: InputDecoration(
        
        contentPadding: EdgeInsets.all(20.0),
        border: OutlineInputBorder(
          
          
         // borderSide: Divider.createBorderSide(context),
          borderSide:BorderSide(width: 10,color: Color.fromARGB(255, 255, 255, 255)),
          
    
         
         // borderRadius: BorderRadius.circular(30.0)
          
        ),
        
        hintText:hintext,
        
      
        
        
      ),
      
      keyboardType:textInputType ,
      obscureText: isPass,
    
    
    );
  }
}