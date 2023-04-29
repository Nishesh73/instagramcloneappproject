import 'package:flutter/material.dart';
import 'package:instagramcloneapp/all_chat_message_screen.dart/home_chat_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var opactityVal = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  navigateToSplash();

  // _navigateToAnimateValue();
   
  }

  // _navigateToAnimateValue(){

  //   setState(() {
  //     opactityVal = 0.0;
      
  //   });


  // }

  



  navigateToSplash()async{
    await  Future.delayed(Duration(microseconds: 2000),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeChat()));


    }


    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(child: AnimatedOpacity(
        opacity: opactityVal ,
        duration: Duration(seconds: 5),



        child: Text("Welcome to chat, a Splash screen.....",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          
      
        ),),
      )),


    );
  }
}