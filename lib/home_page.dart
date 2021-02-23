import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  // Open websocket connection on test server
  final channel = IOWebSocketChannel.connect("ws://echo.websocket.org");
  final VoidCallback shouldLogOut;

  HomePage({Key key, this.shouldLogOut}) : super(key: key);
  
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void dispose() {
    widget.channel.sink.close();  // Close web socket connection
    super.dispose();
  }

  @override
  void initState() { 
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF18a1d7),
        title: Text("Home Screen"),
        leading: GestureDetector(
          child: Icon(Icons.menu),
          onTap: () {},
        ),
        actions: [
          // Log out button
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              child: Icon(Icons.logout),
              onTap: widget.shouldLogOut,
            ),
          )
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:48.0),
              child: BrandLogo(
                width: 64,
                height: 64
              ),
            ),
            // Stream builder with websocket stream
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                return Text(snapshot.hasData ? "${snapshot.data}" : "");
              }
            ),
            FlatButton(
              child: Icon(Icons.message),
              onPressed: () {
                widget.channel.sink.add("Brand ID");
              },
            )
          ],
        )
      )
    );
  }

}