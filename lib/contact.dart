import "package:flutter/material.dart";

class Contact extends StatefulWidget {
  const Contact({super.key});
  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
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
        padding: const EdgeInsets.fromLTRB(16,50,16,16),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding:  EdgeInsets.fromLTRB(8.0,0,0,0),
                child: Text("Club Desperado",style: TextStyle(
                        
                        fontSize: 20,
                        fontWeight: FontWeight.bold),),
              ),
              const Text("   Byasi, Bhaktapur-15"),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,16,8,8),
                child: Table(
                  children: const [
                    TableRow(children: [
                      Row(
                        children: [
                          Icon(Icons.phone,color: Color(0xFF1A1363),),
                          Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text("Contact : "),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text("+9779851044356"),
                          ),
                        ],
                      )
                    ]),
                    TableRow(children: [
                      Row(
                        children: [
                          Icon(Icons.mail,color: Color(0xFF1A1363),),
                          Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text("Email : "),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text("clubdesperado@gmail.com"),
                          ),
                        ],
                      )
                    ]),
                    TableRow(children: [
                      Row(
                        children: [
                          Icon(Icons.public,color: Color(0xFF1A1363),),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Website : "),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(8.0),
                            child: Text("https://clubdesperado.com.np"),
                          ),
                        ],
                      )
                    ]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
