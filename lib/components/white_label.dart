/*
  File containing all the definitions for messages, logos, etc., for easy and quick
  brand specific app customization.
*/
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

/*

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
  Brand Themes
*/
final brandTheme = ThemeData(
  primaryColor: Colors.blue,
  accentColor: Colors.blueAccent,
  backgroundColor: Colors.white,
  
);