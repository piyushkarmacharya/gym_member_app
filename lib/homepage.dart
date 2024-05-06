import 'package:flutter/material.dart';
import 'package:gym_member_app/loginpage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  List<String> pageName = ['Dashboard', 'Attendance', 'Change Password'];
  List<Widget> page = [];
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName[selectedPage]),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Welcome"),
            ),
            ...List.generate(pageName.length, (index) => ListTile(title: Text(pageName[index]),)),
          ],
        ),
      ),
      body: Text("Welcome"),
    );
  }
}
