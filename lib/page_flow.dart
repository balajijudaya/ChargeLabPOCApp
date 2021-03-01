import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:ChargeLabPoCApp/home_page.dart';
import 'package:flutter/material.dart';

class PageFlow extends StatefulWidget {
  final VoidCallback shouldLogOut;  // Callback to log out user and route back to home page
  final PartnerBrand partnerBrand;  // PartnerBrand Obj containing whitelabel assets

  PageFlow({Key key, this.shouldLogOut, this.partnerBrand}) : super(key: key);

  @override
  _PageFlowState createState() => _PageFlowState();
}

class _PageFlowState extends State<PageFlow> {

  // Returns a a list of content pages post log in
  List<MaterialPage> get _pages {
    return [
      // Home Page
      MaterialPage(child: HomePage(
        shouldLogOut: widget.shouldLogOut,
        partnerBrand: widget.partnerBrand,
      ),
      // Future Page
    ),
    
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: _pages,
      onPopPage: (route, result) => route.didPop(result),
    );
  }
}