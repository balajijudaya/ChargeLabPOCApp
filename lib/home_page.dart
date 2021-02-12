import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final VoidCallback shouldLogOut;

  HomePage({Key key, this.shouldLogOut}) : super(key: key);

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
              onTap: shouldLogOut,
            ),
          )
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: Center(
          child: BrandLogo(
            width: 64,
            height: 64
          ),
        ),
      )
    );
  }
}