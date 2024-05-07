import 'package:flutter/material.dart';
import 'package:gym_member_app/attendance.dart';
import 'package:gym_member_app/change_password.dart';
import 'package:gym_member_app/dashboard.dart';
import 'package:gym_member_app/loginpage.dart';
import 'package:gym_member_app/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  List<String> pageName = ['Dashboard', 'Attendance', 'Change Password'];
  List<Widget> page = [Dashboard(), Attendance(), ChangePassword()];
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
            ...List.generate(
              pageName.length,
              (index) => ListTile(
                title: Text(pageName[index]),
                onTap: (){
                  setState(() {
                    selectedPage=index;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
      body: page[selectedPage],
    );
  }
}
