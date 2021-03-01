import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/*
  Object that stores white label assets, pulled from a Firebase Real-time Database and
  instatiated in _ChargeLabPoCAppState -> void getBrandAssets()
*/
class PartnerBrand {
  final String greetMsg;
  final CachedNetworkImage logo;
  final String supportPhone;
  final ThemeData brandTheme;

  PartnerBrand({
      @required this.greetMsg,
      @required this.logo,
      @required this.supportPhone,
      @required this.brandTheme,
  });

}



/*
  Object responsible for displaying post launch SplashScreen with animated fade in logo.
  Created for use with a logo pulled from a Firebase Real-time database
*/
class BrandSplash extends StatefulWidget {
  final Widget home;
  final Function func;
  final CachedNetworkImage logo;
  final int duration;
  final Color backGroundColor;
  final double logoSize;

  BrandSplash({
    @required this.logo,
    @required this.home,
    this.func,
    this.duration,
    this.backGroundColor = Colors.white,
    this.logoSize = 250.0,
  });


  @override
  _BrandSplashState createState() => _BrandSplashState();
}

class _BrandSplashState extends State<BrandSplash> with SingleTickerProviderStateMixin {
  AnimationController _animController;
  Animation _anim;


@override
  void initState() {
    super.initState();

    // Instatiate animation controller, create fade in animation and play it
    _animController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _anim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animController, curve: Curves.easeInCirc));
    _animController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animController.reset();
  }


  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: widget.duration)).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => widget.home));
    });

    return Scaffold(
      backgroundColor: widget.backGroundColor,
      body: FadeTransition(
        opacity: _anim,
        child: Center(
          child:
            SizedBox(
              height: widget.logoSize,
              child: widget.logo,
            )
          )
      )
    );
  }
}