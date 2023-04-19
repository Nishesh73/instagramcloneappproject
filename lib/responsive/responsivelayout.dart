import "package:flutter/material.dart";
import 'package:instagramcloneapp/providers/user_provider.dart';
import 'package:instagramcloneapp/utils/global_variable.dart';
import 'package:provider/provider.dart';

class ResponSive extends StatefulWidget {
 final Widget? mobileScreenLayout;
 final Widget? webScreenLayout;
  const ResponSive({super.key, this.mobileScreenLayout, this.webScreenLayout});

  @override
  State<ResponSive> createState() => _ResponSiveState();
}

class _ResponSiveState extends State<ResponSive> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();
  }

  addData()async{

  
       UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
        await userProvider.updateUserData();


 




  }
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context,constrains){
      if(constrains.maxWidth>=webscreenSize)
      return widget.webScreenLayout!;
      else 
      return widget.mobileScreenLayout!;



      


    });
  }
}