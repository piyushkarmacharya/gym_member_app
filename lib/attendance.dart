import "package:flutter/material.dart";

class Attendance extends StatefulWidget {
  const Attendance({super.key});
  State<Attendance> createState() => _Attendance();
}

class _Attendance extends State<Attendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("This is Attendance"),
    );
  }
}
