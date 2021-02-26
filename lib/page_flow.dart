import 'package:ChargeLabPoCApp/components/white_label.dart';
import 'package:ChargeLabPoCApp/home_page.dart';
import 'package:flutter/material.dart';

class PageFlow extends StatefulWidget {
  final VoidCallback shouldLogOut;
  final PartnerBrand partnerBrand;

  PageFlow({Key key, this.shouldLogOut, this.partnerBrand}) : super(key: key);

  @override
  _PageFlowState createState() => _PageFlowState();
}

class _PageFlowState extends State<PageFlow> {

  List<MaterialPage> get _pages {
    return [
      // Home Page
      MaterialPage(child: HomePage(
        shouldLogOut: widget.shouldLogOut,
        partnerBrand: widget.partnerBrand,
      ),
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