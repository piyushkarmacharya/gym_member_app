import "dart:convert";
//Required for jsonDecode

import "package:flutter/material.dart";
import 'package:gym_member_app/homepage.dart';
import "package:gym_member_app/user_provider.dart";
import "package:http/http.dart" as http;
import "package:provider/provider.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> ctr = [
    TextEditingController(),
    TextEditingController()
  ];
  Map data ={};
  String? email;
  Future fetchData() async {
    String url=Provider.of<UserProvider>(context,listen: false).getUrl();
    try{
      final res = await http.post(
        Uri.parse("http://$url:8000/api/Member/login"),
        headers: {'content-Type': 'application/json'},
        body: jsonEncode({'email': ctr[0].text, 'password': ctr[1].text}));
        if (res.statusCode == 200) {
      setState(() {
        data = jsonDecode(res.body);
        Provider.of<UserProvider>(context,listen: false).setMid(data['mid']);
      });
    } 
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration: Duration(seconds: 1),content: Text("Connection problem"))
      );
    }
      
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.people,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blueGrey,
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Container(
            height: double.infinity,
            child: Card(
              elevation: 24,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 300,
                        ),
                      ),
                      
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email),
                              ),
                              controller: ctr[0],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter email";
                                }
                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return "Please enter valid email";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock),
                              ),
                              controller: ctr[1],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter password";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  
                                });
                                if (_formKey.currentState!.validate()) {
                                  
                                  await fetchData();
                                  
                                    if (data['login']==true) {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return HomePage();
                                          },
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text("Email and Password doesnot match"),
                                        ),
                                      );
                                    }
                                  
                                }
                              },
                              child: Text("Login"),
                            )
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
