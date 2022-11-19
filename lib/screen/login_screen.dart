import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/widgets/textinput_field.dart';
class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passWordController=TextEditingController();

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
              onTap: (){},

              child: Container(
                child: Text("Log in"),
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
                  onTap: (){},
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