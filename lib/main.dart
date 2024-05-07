import 'package:flutter/material.dart';
import 'package:gym_member_app/attendance.dart';
import 'package:gym_member_app/homepage.dart';
import 'package:gym_member_app/loginpage.dart';
import 'package:gym_member_app/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
 
 @override
 Widget build(BuildContext context){
  return ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  );
 }
}
