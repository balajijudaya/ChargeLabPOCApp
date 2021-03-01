import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final VoidCallback shouldLogOut;  // Callback to trigger user to logout and be routed to login page
  final PartnerBrand partnerBrand;  // PartnerBrand Obj containing whitelabel assets

  HomePage({Key key, this.shouldLogOut, this.partnerBrand}) : super(key: key);
  
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void dispose() {
    super.dispose();
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
              child: widget.partnerBrand.logo
            
            
            ),
            
          ],
        )
      )
    );
  }

}