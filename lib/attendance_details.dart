import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:gym_member_app/user_provider.dart";
import "package:intl/intl.dart";
import 'package:http/http.dart' as http;
import "dart:convert";

import "package:provider/provider.dart";

class AttendanceDetails extends StatefulWidget {
  const AttendanceDetails({super.key});

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  List attendanceDetails=[];
  int? mid;
  TableRow getDataRow(int i) {
    TextStyle rowTextStyle=TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.normal);
    DateTime temp=DateFormat("yyyy-MM-dd HH:mm:ss").parse(attendanceDetails[i]['created_at'].toString());
    String time=DateFormat('HH:mm:ss').format(temp);
    return TableRow(
      children: [
        TableCell(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(attendanceDetails[i]['date'].toString(),style: rowTextStyle,),
        )),
        
        TableCell(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(time,style: rowTextStyle,),
        ),),
      ],
    );
  }
  Future<void> _getAttendanceDetails() async{
    try{
      String url=Provider.of<UserProvider>(context,listen: false).getUrl();
      final res = await http.get(Uri.parse("http://$url:8000/api/memberattendance/info/$mid"));
    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);
      setState(() {
        attendanceDetails=data;
      });
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Connection problem"),),);
    }
    }catch(e){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),),);

    }
      
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
          mid=Provider.of<UserProvider>(context,listen: false).getMid();
    });
    _getAttendanceDetails();
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      mid=5;
    });
    
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 362,
          width: 597,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFF77749B),
          ),
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Attendance Details",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFFFFFADF),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.fromLTRB(16,16,16,0),
                    child: Table(children: [
                            TableRow(
                              children: [
                                TableCell(child: Text('Date',style: TextStyle(color: Color(0xFFFFFADF),fontSize: 14,fontWeight: FontWeight.bold,),)),
                                TableCell(child: Text(' Attendance Time',style: TextStyle(color: Color(0xFFFFFADF),fontSize: 14,fontWeight: FontWeight.bold,),)),
                                
                              ],
                            ),]),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Table(
                        children: [
                          ...List.generate(attendanceDetails.length, (index) => getDataRow(index))
                          // Add more rows as needed
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
