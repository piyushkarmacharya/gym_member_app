import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gym_member_app/attendance.dart';
import 'package:gym_member_app/attendance_details.dart';
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
  
  List<String> pageName = ['Dashboard', 'Attendance', 'Change Password','Attendance Details'];
  List<Widget> page = [Dashboard(), Attendance(), ChangePassword(),AttendanceDetails()];
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<UserProvider>(context,listen: false).getCurrentPage();
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName[selectedPage]),
        actions: [GestureDetector(onTap: (){Navigator.of(context).pop();},child: Icon(Icons.exit_to_app))],
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
                    Provider.of<UserProvider>(context,listen: false).setCurrentPage(index);
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
