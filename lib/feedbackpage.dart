import 'package:flutter/material.dart';
import 'package:gym_member_app/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});
  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  Map message = {};
  final _formKey = GlobalKey<FormState>();
  TextEditingController ctr = TextEditingController();
  Future<void> setFeedback() async {
    int mid = Provider.of<UserProvider>(context, listen: false).getMid();
    String url = Provider.of<UserProvider>(context, listen: false).getUrl();
    try {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      final res = await http.post(Uri.parse("http://$url:8000/api/feedback"),
          headers: {'content-Type': 'application/json'},
          body: jsonEncode({'mid': mid, 'feedback': ctr.text}));
      if (res.statusCode == 200) {
        setState(() {
          message = jsonDecode(res.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(20))),
              backgroundColor: Colors.green,
              margin: EdgeInsets.fromLTRB(
                  0, 0.8 * screenHeight, 0.1 * screenWidth, 10),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 1),
              content: Center(child: Text(message['message'])),
            ),
          );
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1), content: Text("Connection problem")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.exit_to_app))
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Text(
                    "Please leave your feedback below : ",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          maxLines: 10,
                          decoration: InputDecoration(
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
                          ),
                          controller: ctr,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Feedback cannot be empty";
                            }
                            if (value.length > 500) {
                              return "Feedback can only accept 500 letters";
                            }
                            if (value.length < 4) {
                              return "Too short feedback";
                            }
                            if (RegExp(r'^\s*[^\s]{0,3}$').hasMatch(value)) {
                              return "invalid feedback";
                            }

                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    setFeedback();
                                  } else {
                                    debugPrint("validate first");
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          const Color(0xFF1A1363)),
                                  shape:
                                      WidgetStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24)),
                                  ),
                                ),
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape:
                                        WidgetStateProperty.all<OutlinedBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24)),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),
                            )
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
