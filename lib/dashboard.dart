import "package:flutter/material.dart";
import "package:gym_member_app/homepage.dart";
import "package:gym_member_app/user_provider.dart";
import "package:provider/provider.dart";

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  onTap: (){
                    setState(() {
            Provider.of<UserProvider>(context, listen: false).setCurrentPage(3);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
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
                        const Expanded(child: Text("Attendance Details",style: TextStyle(fontWeight: FontWeight.bold),))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                     const  Expanded(child: Text("Do Attendance",style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                      const Expanded(child: Text("Change Password",style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                      const Expanded(child: Text("Contact Us",style: TextStyle(fontWeight: FontWeight.bold),))
                    ],
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
