import 'package:flutter/material.dart';
import 'package:instagramcloneapp/all_chat_message_screen.dart/home_chat_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  navigateToSplash();
   
  }

  navigateToSplash()async{
    await  Future.delayed(Duration(microseconds: 2000),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeChat()));


    }


    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Text("Welcome to chat"),


    );
  }
}