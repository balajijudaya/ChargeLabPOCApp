import 'package:ChargeLabPoCApp/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ChargeLabPoCApp());
}

class ChargeLabPoCApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charge Lab PoC App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Navigator(
        pages: [
          MaterialPage(child: LoginPage())
        ],
        onPopPage: (route, result) => route.didPop(result),
      )
    );
  }
}
