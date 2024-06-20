import 'package:flutter/material.dart';
import 'package:gym_member_app/attendance.dart';
import 'package:gym_member_app/attendance_details.dart';
import 'package:gym_member_app/change_password.dart';
import 'package:gym_member_app/contact.dart';
import 'package:gym_member_app/feedbackpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<String> pageName = [
  //   'Dashboard',
  //   'Attendance',
  //   'Change Password',
  //   'Attendance Details'
  // ];
  // List<Widget> page = [
  //   Dashboard(),
  //   Attendance(),
  //   ChangePassword(),
  //   AttendanceDetails()
  // ];
  @override
  Widget build(BuildContext context) {
 
   
   
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon:const  Icon(Icons.exit_to_app))
        ],
        toolbarHeight: 80,
        centerTitle: true,
        title: Row(
          children: [
            SizedBox(
              height: 60,
              width: 80,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
            const Text(
              "CLUB\nDESPERADO",
              style: TextStyle(
                  color: Color(0xFF1A1363),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      // drawer: Drawer(
      //   backgroundColor: Color(0xFF1A1363),
      //   width: 200,
      //   child: ListView(
      //     children: [
      //       DrawerHeader(
      //         child: Center(
      //             child: Text(
      //           "Welcome\n${Provider.of<UserProvider>(context, listen: false).getMemberName()}",
      //           style: TextStyle(color: Colors.white),
      //         )),
      //       ),
      //       ...List.generate(
      //         pageName.length,
      //         (index) => ListTile(
      //           title: Text(
      //             pageName[index],
      //             style: TextStyle(color: Colors.white),
      //           ),
      //           onTap: () {
      //             setState(() {
      //               Provider.of<UserProvider>(context, listen: false)
      //                   .setCurrentPage(index);
      //             });
      //             Navigator.of(context).pop();
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: double.infinity,
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AttendanceDetails(),
                        ),
                      );
                    });
                  },
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Icon(
                            Icons.date_range,
                            size: 0.2 * MediaQuery.of(context).size.width,
                          ),
                        ),
                        const Expanded(
                            child: Text(
                          "Attendance Details",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>const  Attendance(),
                        ),
                      );
                    });
                  },
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Icon(
                            Icons.check_circle,
                            size: 0.2 * MediaQuery.of(context).size.width,
                          ),
                        ),
                       const  Expanded(
                            child: Text(
                          "Do Attendance",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ChangePassword(),
                        ),
                      );
                    });
                  },
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Icon(
                            Icons.lock,
                            size: 0.2 * MediaQuery.of(context).size.width,
                          ),
                        ),
                        const Expanded(
                            child: Text(
                          "Change Password",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Contact(),
                        ),
                      );
                    });
                  },
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Icon(
                            Icons.contact_page,
                            size: 0.2 * MediaQuery.of(context).size.width,
                          ),
                        ),
                        const Expanded(
                            child: Text(
                          "Contact Us",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const FeedbackPage(),
                        ),
                      );
                    });
                  },
                  child: Card(
                    elevation: 10,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Icon(
                            Icons.feedback,
                            size: 0.2 * MediaQuery.of(context).size.width,
                          ),
                        ),
                       const  Expanded(
                            child: Text(
                          "Feedback",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
