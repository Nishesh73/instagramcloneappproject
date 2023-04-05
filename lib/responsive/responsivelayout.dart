import "package:flutter/material.dart";
import 'package:instagramcloneapp/utils/dimension.dart';

class ResponSive extends StatelessWidget {
 final Widget? mobileScreenLayout;
 final Widget? webScreenLayout;
  const ResponSive({super.key, this.mobileScreenLayout, this.webScreenLayout});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constrains){
      if(constrains.maxWidth>=webscreenSize)
      return webScreenLayout!;
      else 
      return mobileScreenLayout!;



      


    });
  }
}