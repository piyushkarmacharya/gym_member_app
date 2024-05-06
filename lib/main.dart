import 'package:flutter/material.dart';
import 'package:gym_member_app/homepage.dart';
import 'package:gym_member_app/loginpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});
 
 @override
 Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  );
 }
}
