import "dart:convert";
//Required for jsonDecode

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
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
  Map data = {};
  String? email;
  Future<void> login() async {
    String url = Provider.of<UserProvider>(context, listen: false).getUrl();
    try {
      final res = await http.post(
          Uri.parse("http://$url:8000/api/Member/login"),
          headers: {'content-Type': 'application/json'},
          body: jsonEncode({'email': ctr[0].text, 'password': ctr[1].text}));
      if (res.statusCode == 200) {
        setState(() {
          data = jsonDecode(res.body);
          Provider.of<UserProvider>(context, listen: false).setMid(data['mid']);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1), content: Text("Connection problem")));
    }
  }

  bool _showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              child: const Padding(
                padding:  EdgeInsets.all(8.0),
                child: Icon(
                  Icons.people,
                  color: Color(0xFF1A1363),
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: SizedBox(
            height: double.infinity,
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
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF332F64),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF332F64),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF332F64),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              prefixIcon: const Icon(Icons.email),
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
                         const  SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: !_showPassword,
                            decoration: InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF332F64),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF332F64),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFF332F64),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                icon: Icon(_showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            controller: ctr[1],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter password";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xFF1A1363)),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                ),
                              ),
                              onPressed: () async {
                                setState(() {});
                                if (_formKey.currentState!.validate()) {
                                  await login();
                                  if (data['login'] == true) {
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setMemberName(data['name']);
                                    Provider.of<UserProvider>(context,
                                            listen: false)
                                        .setImgStr(data['photo']);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return HomePage();
                                        },
                                      ),
                                    );
                                  } else {
                                    final screenHeight =
                                        MediaQuery.of(context).size.height;
                                    final screenWidth =
                                        MediaQuery.of(context).size.width;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        shape:const  RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(0),
                                                bottomRight:
                                                    Radius.circular(20),
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(20))),
                                        backgroundColor:
                                            Colors.red,
                                        margin: EdgeInsets.fromLTRB(
                                            0,
                                            0.8 * screenHeight,
                                            0.1 * screenWidth,
                                            10),
                                        behavior: SnackBarBehavior.floating,
                                        duration:const  Duration(seconds: 1),
                                        content:const  Center(
                                            child: Text("Email and password donot match")),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
