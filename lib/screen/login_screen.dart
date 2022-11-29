import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramcloneapp/resources/resource.dart';
import 'package:instagramcloneapp/responsive/web_screenlayout.dart';
import 'package:instagramcloneapp/screen/signup_screen.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/utils.dart';
import 'package:instagramcloneapp/widgets/textinput_field.dart';

import '../responsive/mobile_screenlayout.dart';
import '../responsive/responsive_screen.dart';
class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passWordController=TextEditingController();

  void navigateToSignUp(){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));

   // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout())));
  }

  bool isLoading=false;

  void signInUser() async{
    setState(() {
      isLoading=true;
      
    });

  String res=await AuthMethods().signInUser(email: emailController.text, password: passWordController.text);
  setState(() {
    isLoading=false;
  });
if(res!="Success"){
  
}
else{
  showSnackBar(res, context);


}




  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passWordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: double.infinity,
        child: Column(
          
          children: [
            Flexible(
              
              child:Container(
                height: 100.0,
              )),
            SvgPicture.asset("lib/assets/ic_instagram.svg",height: 64.0,color: primaryColor,),

            SizedBox(height:24,),
            Textinput(textEditingController: emailController,hintext: "Enter your email",textInputType: TextInputType.emailAddress,),
            SizedBox(height: 24,),
            Textinput(textEditingController: passWordController,hintext: "Enter your password",textInputType: TextInputType.text,isPass: true,),
             SizedBox(height: 24,),
            InkWell(
              onTap: signInUser,

              child: Container(
                child: isLoading?Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                ):Text("Log in"),
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(4.0),
                )
                
              ),
            ) ,

            Flexible(child: Container(
             margin: EdgeInsets.only(bottom: 5.0),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  
                  child:
                 Text("Don't have an account?"),),

                 GestureDetector(
                  onTap: navigateToSignUp,
                   child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    
                    child:
                   Text("Sign up",style: TextStyle(fontWeight: FontWeight.bold),),),
                 ),
                
                

              ],
            )

         


          ],
        ),
      )),

    );
  }
}