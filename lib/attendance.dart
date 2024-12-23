import "dart:convert";

import "package:flutter/material.dart";
import "package:gym_member_app/user_provider.dart";
import "package:provider/provider.dart";
import "package:simple_barcode_scanner/simple_barcode_scanner.dart";
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  const Attendance({super.key});
  @override
  State<Attendance> createState() => _Attendance();
}

class _Attendance extends State<Attendance> {
  String result = "";
  String qrStr = "";

  Future<void> getQrString() async {
    String url = Provider.of<UserProvider>(context, listen: false).getUrl();
    final res = await http.get(Uri.parse("http://$url:8000/api/AttendanceQr"));
    if (res.statusCode == 200) {
      setState(() {
        qrStr = jsonDecode(res.body)['qrstr'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Connection problem"),
        ),
      );
    }
  }

  Future<void> attend() async {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    if (result == qrStr) {
      int mid = Provider.of<UserProvider>(context, listen: false).getMid();
      String url = Provider.of<UserProvider>(context, listen: false).getUrl();
      final res = await http.post(
        Uri.parse("http://$url:8000/api/attendance"),
        headers: {'content-Type': 'application/json'},
        body: jsonEncode({'mid': mid}),
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(20))),
            backgroundColor:
                jsonDecode(res.body)['message'] == "Checked in successfully"
                    ? Colors.green
                    : Colors.red,
            margin: EdgeInsets.fromLTRB(
                0, 0.8 * screenHeight, 0.1 * screenWidth, 10),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
            content: Center(child: Text(jsonDecode(res.body)['message'])),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Connection problem mid : $mid"),
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } else {
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(20))),
          backgroundColor: Colors.red,
          margin:
              EdgeInsets.fromLTRB(0, 0.8 * screenHeight, 0.1 * screenWidth, 10),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          content: const Center(child: Text("Qr donot match")),
        ),
      );
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xFF1A1363)),
                  shape: WidgetStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24)),
                  ),
                ),
                onPressed: () async {
                  getQrString();
                  var res = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const SimpleBarcodeScannerPage();
                      },
                    ),
                  );
                  setState(() {
                    if (res is String) {
                      result = res;
                    }
                  });

                  attend();
                },
                child: const Text(
                  "Open Scanner",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              const Text(
                "Please use Scanner for attendance",
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
