
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:instagramcloneapp/providers/userprovider.dart';
import 'package:instagramcloneapp/utils/globalvariable.dart';
import 'package:provider/provider.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLayout({super.key,required this.webScreenLayout,required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addData();

  }

  addData() async{
    UserProvider userProvider = Provider.of(context,listen: false);
    await userProvider.refreshUser();


  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth>webScreenSize){
          return widget.webScreenLayout;

        }
        else 
        return widget.mobileScreenLayout;



      });
  }
}