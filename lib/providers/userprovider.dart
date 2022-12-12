import 'package:flutter/cupertino.dart';
import 'package:instagramcloneapp/models/user.dart';
import 'package:instagramcloneapp/resources/resource.dart';

class UserProvider with ChangeNotifier{
  final AuthMethods _authMethods=AuthMethods();
 User? _user;

User get getUserData=>_user!;

  Future<void> refreshUser()async{
   User user=await _authMethods.getUserDetails();
   _user=user;
   notifyListeners();



  }


  

  

  


  



}