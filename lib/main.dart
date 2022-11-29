import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/providers/userprovider.dart';
import 'package:instagramcloneapp/responsive/mobile_screenlayout.dart';
import 'package:instagramcloneapp/responsive/responsive_screen.dart';
import 'package:instagramcloneapp/responsive/web_screenlayout.dart';
import 'package:instagramcloneapp/screen/login_screen.dart';
import 'package:instagramcloneapp/screen/signup_screen.dart';
import 'package:instagramcloneapp/utils/colors.dart';
import 'package:provider/provider.dart';
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

  //Material App-- This widget is the root of your application, now it is wrap by multiprovider
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'instagramclone',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: mobileBackgroundColor,
          ),

          //  home: ResponsiveLayout(webScreenLayout: WebScreenLayout(), mobileScreenLayout: MobileScreenLayout()));
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ResponsiveLayout(
                        webScreenLayout: WebScreenLayout(),
                        mobileScreenLayout: MobileScreenLayout());
                  } else if (snapshot.hasError) {
                    return Center(
                        child:
                            Text("some error has occured ${snapshot.error}"));
                  }
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ));
                }

                return LogInScreen();
              })),
    );
  }
}
