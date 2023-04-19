
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagramcloneapp/model/usermodel.dart';
import 'package:instagramcloneapp/services/authservice.dart';

class UserProvider with ChangeNotifier{
  // late Users _users;
  // Users get getUsers => _users;

  Users? _users;
  AuthService authService = AuthService();
  Users? get getUsers => _users;

  
  


  updateUserData()async{

  Users users = await authService.getUserDetails();
  _users = users;
  notifyListeners();




  }






}