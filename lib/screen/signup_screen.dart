import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramcloneapp/resources/resource.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:instagramcloneapp/utils/utils.dart';
import 'package:instagramcloneapp/widgets/textinput_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  Uint8List? unit8file;
  bool isLoading=false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passWordController.dispose();
    userNameController.dispose();
    bioController.dispose();
  }

  signUp() async{
    setState(() {
      isLoading=true;
      
    });

     String res = await AuthMethods().signUpWithUser(
                        email: emailController.text,
                        password: passWordController.text,
                        username: userNameController.text,
                        bio: bioController.text,
                        file: unit8file!);
                  //  print(res);

              if(res!="Success"){
                showSnackBar(res, context);

              }

              setState(() {
                isLoading=false;
              });



  }

  void selectImage() async {
    Uint8List image = await pickImage(ImageSource.gallery);

    setState(() {
      unit8file = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        width: double.infinity,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Flexible(
                    child: Container(
                  height: 100.0,
                )),
                SvgPicture.asset(
                  "lib/assets/ic_instagram.svg",
                  height: 64.0,
                  color: primaryColor,
                ),
                SizedBox(
                  height: 24,
                ),
                Stack(
                  children: [
                    unit8file != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(unit8file!),
                            radius: 64.0,
                          )
                        : CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSed2qIEOqQ1Fyc1RQgJ88ZzVwQ8bOaCRlUig&usqp=CAU"),
                            radius: 64.0,
                          ),
                    Positioned(
                        bottom: 0,
                        right: 3.0,
                        child: IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: Icon(Icons.add_a_photo)))
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Textinput(
                  textEditingController: userNameController,
                  hintext: "Enter your name",
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 24,
                ),
                Textinput(
                  textEditingController: emailController,
                  hintext: "Enter your email",
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 24,
                ),
                Textinput(
                  textEditingController: passWordController,
                  hintext: "Enter your password",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                SizedBox(
                  height: 24,
                ),
                Textinput(
                  textEditingController: bioController,
                  hintext: "Enter your bio",
                  textInputType: TextInputType.text,
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                  onTap: ()async  {
                    await signUp();
                   // print("hello pooja");
                   
                  },
                  child: Container(
                      child:isLoading?Center(child: CircularProgressIndicator(
                        color: primaryColor,
                      )): Text("Sign up"),
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(4.0),
                      )),
                ),
                Flexible(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 5.0),
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text("Don't have an account?"),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          "Sign up",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
