

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagramcloneapp/responsive/mobile_screen.dart';
import 'package:instagramcloneapp/responsive/responsivelayout.dart';
import 'package:instagramcloneapp/responsive/web_screen.dart';
import 'package:instagramcloneapp/screens/sign_up.dart';
import 'package:instagramcloneapp/services/authservice.dart';
import 'package:instagramcloneapp/utils/colors.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
   final _formKey =  GlobalKey<FormState>();
  String email = "", password = "";
  bool isLoading = false;

  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
         backgroundColor: mobileBackgroundColor,
        
        
        title: Text("SignIn")),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "lib/assets/ic_instagram.svg",
                    color: primaryColor,
                    height: 64.0,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  
                  

                      



               



                  Flexible(
                    child: TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) return "invalid email";
                  
                      return null;  
                      }),
                      onSaved: ((newValue) {
                        setState(() {
                          email = newValue!;
                        });
                      }),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color.fromARGB(1, 196, 12, 12),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0, color: Color.fromARGB(1, 8, 0, 0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3.0,
                                  color: Color.fromARGB(21, 0, 0, 0))),
                          hintText: "Enter email address"),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    child: TextFormField(
                      obscureText: true,
                      validator: ((value) {
                        if (value!.isEmpty) return "invalid password,";
                  
                        return null;
                      }),
                      onSaved: ((newValue) {
                        setState(() {
                          password = newValue!;
                        });
                      }),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color.fromARGB(1, 196, 12, 12),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2.0, color: Color.fromARGB(1, 8, 0, 0))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 3.0,
                                  color: Color.fromARGB(21, 0, 0, 0))),
                          hintText: "Enter password"),
                    ),
                  ),
                 

                  const SizedBox(
                    height: 15.0,
                  ),
                 Container(
                          width: double.infinity,
                          height: 50.0,
                          child: ElevatedButton(
                              onPressed: () {



                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

               


      
                                  setState(() {
                                    isLoading = true;
                                  });

                                  

                                  

                                   AuthService().signIn(
                                          email: email,
                                          password: password,
                                          context: context
                                          );
                                          

                                  setState(() {
                                    isLoading = false;
                                  });
       
                                }







                              },
                              child:
                               isLoading? Center(child: CircularProgressIndicator(
                                backgroundColor: Colors.yellow,
                               
                                
                                


                               )) : Text("LogIn") ,
                                  
                                  
                                  )),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                      onTap: (() {
                       
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  SignUp()
                                
                               
                                    
                                    
                                    ));



                      }),

                      child: Container(
                        child: 
                            Text("Don't have an account? proceed for singup"),
                            
                      ))
                ],
              ),
            ),
          ),
        ),
      ),



    );
  }
}