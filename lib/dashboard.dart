import "package:flutter/material.dart";

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});
  State<Dashboard> createState()=>_Dashboard();
}

class _Dashboard extends State<Dashboard>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text("This is Dashboard"),
    );
  }
}