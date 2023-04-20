import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagramcloneapp/providers/user_provider.dart';
import 'package:instagramcloneapp/responsive/mobile_screen.dart';
import 'package:instagramcloneapp/responsive/responsivelayout.dart';
import 'package:instagramcloneapp/responsive/web_screen.dart';
import 'package:instagramcloneapp/screens/sign_up.dart';

import 'package:instagramcloneapp/utils/colors.dart';
import 'package:provider/provider.dart';
// Import the generated file
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

//        flutter run -d chrome --web-renderer html

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
        ChangeNotifierProvider(create: (_) => UserProvider(),),
        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        
        // home:SignUp())

          home: StreamBuilder(stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
    
          if(snapshot.connectionState==ConnectionState.active){
            if(snapshot.hasData){
              return ResponSive(mobileScreenLayout: MobileScreen(),
              webScreenLayout: WebScreenLayout(),);
            }
    
            
    
             
           else {
                 return SignUp();
    
              }
    
               
          
           
    
           
    
    
          }
          else{
           return Center(child: CircularProgressIndicator());
    
          }
          
        }
          )
          )
          );
      
      
        }
        }
  
        


  
  
  
      