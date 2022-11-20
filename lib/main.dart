import 'package:flutter/material.dart';
import 'package:instagramcloneapp/responsive/mobile_screenlayout.dart';
import 'package:instagramcloneapp/responsive/responsive_screen.dart';
import 'package:instagramcloneapp/responsive/web_screenlayout.dart';
import 'package:instagramcloneapp/screen/login_screen.dart';
import 'package:instagramcloneapp/screen/signup_screen.dart';
import 'package:instagramcloneapp/utils/colors.dart';
// Import the generated file
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'instagramclone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      
        
    //  home: ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout()));
    home: const LogInScreen(),
    );
    
  }
}

