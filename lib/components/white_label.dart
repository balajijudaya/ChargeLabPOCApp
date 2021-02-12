/*
  File containing all the definitions for messages, logos, etc., for easy and quick
  brand specific app customization all in one place.
*/
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

/*
  Custom Brand Logo
*/
class BrandLogo extends StatelessWidget {
  final double width;
  final double height;
  
  BrandLogo({@required this.width, @required this.height});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/logos/chargelab-logo-white.svg",
      semanticsLabel: "ChargeLab Logo",
      color: Colors.black,
      width: width,
      height: height,
    );
  }
}

/*
  Custom Brand Message
*/
class BrandMessage extends StatelessWidget {
  final TextStyle style;

  BrandMessage({this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Custom Brand Message",
      style: style,
    );
  }
}

/*
  Custom Brand Theme
*/
ThemeData brandTheme() {
  return ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primarySwatch: Colors.blue,
    primaryColor: Color(0xFF18a1d7),
    accentColor: Colors.lightBlueAccent,
    backgroundColor: Colors.white,
    
  );
}


/*
  Custom Brand Splash Screen
*/
