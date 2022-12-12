import 'package:flutter/material.dart';
class FollowButtons extends StatelessWidget {
  Function()? function;
  final String text;
  final Color? backgroundColor;
  Color borderColor;
  final textColor;


   FollowButtons({super.key,required this.text,this.function,this.backgroundColor,required this.borderColor,required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 28.0),
      child: TextButton(onPressed: function, child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(5),
        
        ),
        alignment: Alignment.center,
        child: Text(text,style: TextStyle(color: textColor,fontWeight: FontWeight.bold),),

        width: 250,
        height: 30,
      ),
      
      
      ),
    

    );
  }
}