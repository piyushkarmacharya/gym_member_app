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

    String memberName=Provider.of<UserProvider>(context,listen: false).getMemberName();
    String imgStr=Provider.of<UserProvider>(context,listen: false).getImgStr();
    int selectedPage = Provider.of<UserProvider>(context,listen: false).getCurrentPage();
    return Scaffold(
      appBar: AppBar(
                toolbarHeight: 80,
                centerTitle: true,
                title: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 80,
                      child: Image.asset(
                        "assets/images/logo.png",
                      ),
                    ),
                    Text("CLUB\nDESPERADO",style: TextStyle(color: Color(0xFF1A1363),fontSize: 20,fontWeight: FontWeight.bold),)
                  ],
                ),
                
              ),
      drawer: Drawer(
         backgroundColor: Color(0xFF1A1363),
         width: 200,
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(child: Text("Welcome\n$memberName",style: TextStyle(color: Colors.white),)),
            ),
            ...List.generate(
              pageName.length,
              (index) => ListTile(
                title: Text(pageName[index],style: TextStyle(color: Colors.white),),
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
