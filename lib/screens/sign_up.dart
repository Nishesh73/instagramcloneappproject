import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramcloneapp/responsive/mobile_screen.dart';
import 'package:instagramcloneapp/responsive/responsivelayout.dart';
import 'package:instagramcloneapp/responsive/web_screen.dart';
import 'package:instagramcloneapp/screens/login_screen.dart';
import 'package:instagramcloneapp/services/authservice.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/utils_gallery.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Uint8List? uint8list;
  AuthService authService = AuthService();
  String username = "", email = "", password = "", bio = "";
 
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: mobileBackgroundColor,
        
        
        title: Text("SignUp")),
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
                   Stack(
                          children: [
                            uint8list != null
                                ?
                                
                                 CircleAvatar(
                                    backgroundImage: MemoryImage(uint8list!),
                                    radius: 64,
                                  )
                                : CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "https://plus.unsplash.com/premium_photo-1677664964668-c9c888e6bfc2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80"),
                                    radius: 64,
                                  ),
                            Positioned(
                                right: 10.0,
                                bottom: 0.1,
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: (() async {
                                    Uint8List img =
                                        await picksImage(ImageSource.gallery);

                                    setState(() {
                                      uint8list = img;
                                    });
                                  }),
                                ))
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                          validator: ((value) {
                            if (value!.isEmpty)
                              return "please provide username";

                            return null;  
                          }),
                          onSaved: ((newValue) {
                            setState(() {
                              username = newValue!;
                            });
                          }),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color.fromARGB(1, 196, 12, 12),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.0,
                                      color: Color.fromARGB(1, 8, 0, 0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.0,
                                      color: Color.fromARGB(21, 0, 0, 0))),
                              hintText: "Enter username"),
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
                  TextFormField(
                          validator: ((value) {
                            if (value!.isEmpty) return "Empty bio";

                            return null;
                          }),
                          onSaved: ((newValue) {
                            setState(() {
                              bio = newValue!;
                            });
                          }),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Color.fromARGB(1, 196, 12, 12),
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2.0,
                                      color: Color.fromARGB(1, 8, 0, 0))),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3.0,
                                      color: Color.fromARGB(21, 0, 0, 0))),
                              hintText: "Enter bio"),
                        ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : Container(
                          width: double.infinity,
                          height: 50.0,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

       if (uint8list == null){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please provide userphoto")));

      }


       else{
                                  setState(() {
                                    _isLoading = true;
                                  });

                                   authService.signUp(
                                          userName: username,
                                          email: email,
                                          password: password,
                                          bio: bio,
                                          uintFile: uint8list!,
                                          context: context);
                                          

                                  setState(() {
                                    _isLoading = false;
                                  });
       }
                                }
                              },
                              child:
                                  Text("Sign up"))),
                  const SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                      onTap: (() {
                    

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LogInScreen()
                                
                                
                                    
                                    ));



                      }),

                      child: Container(
                        child:
                            Text("Already signup? proceed for login"),
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
