 

 import 'package:flutter/material.dart';

class NotificationChatt extends StatefulWidget {
   const NotificationChatt({super.key});
 
   @override
   State<NotificationChatt> createState() => _NotificationChattState();
 }
 
 class _NotificationChattState extends State<NotificationChatt> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),

      ),
      body: Text("notification"),



     );
   }
 }