import 'package:ChargeLabPoCApp/home_page.dart';
import 'package:flutter/material.dart';

class PageFlow extends StatefulWidget {
  final VoidCallback shouldLogOut;

  PageFlow({Key key, this.shouldLogOut}) : super(key: key);

  @override
  _PageFlowState createState() => _PageFlowState();
}

class _PageFlowState extends State<PageFlow> {

  List<MaterialPage> get _pages {
    return [
      // Home Page
      MaterialPage(child: HomePage(shouldLogOut: widget.shouldLogOut,)),
    
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