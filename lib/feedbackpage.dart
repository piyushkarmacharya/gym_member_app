import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget{
  const FeedbackPage({super.key});
  State<FeedbackPage> createState()=>_FeedbackPageState();

}
class _FeedbackPageState extends State<FeedbackPage>{
  @override
  Widget build(BuildContext context){
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
              icon: Icon(Icons.exit_to_app))
        ],
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
            Text(
              "CLUB\nDESPERADO",
              style: TextStyle(
                  color: Color(0xFF1A1363),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
      body: Text("Feedback page"),
      
    ),);
  }
}