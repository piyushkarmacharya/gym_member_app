import "dart:convert";

import "package:flutter/material.dart";
import "package:gym_member_app/user_provider.dart";
import "package:provider/provider.dart";
import "package:simple_barcode_scanner/simple_barcode_scanner.dart";
import 'package:http/http.dart' as http;

class Attendance extends StatefulWidget {
  const Attendance({super.key});
  State<Attendance> createState() => _Attendance();
}

class _Attendance extends State<Attendance> {
  String result = "";
  String qrStr="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    
  }

  Future<void> getQrString() async {
    String url = Provider.of<UserProvider>(context, listen: false).getUrl();
    final res = await http.get(Uri.parse("http://$url:8000/api/AttendanceQr"));
    if (res.statusCode == 200) {
      setState(() {
        qrStr = jsonDecode(res.body)['qrstr'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Connection problem"),
        ),
      );
    }
  }

  Future<void> attend() async {
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
            content: Text(jsonDecode(res.body)['message']),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Connection problem mid : $mid"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }else{
      
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("qr donot match"),
            duration: Duration(seconds: 1),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            ElevatedButton(
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
              child: Text("Open Scanner"),
            ),
            
          ],
        ),
      ),
    );
  }
}
