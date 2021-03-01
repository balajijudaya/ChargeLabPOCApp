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

*/
class BrandSplash extends StatefulWidget {
  final Widget home;
  final Function func;
  final CachedNetworkImage logo;
  int duration;
  final Color backGroundColor;
  final double logoSize;

  BrandSplash({
    @required CachedNetworkImage this.logo,
    @required Widget this.home,
    Function this.func,
    int this.duration,
    Color this.backGroundColor = Colors.white,
    double this.logoSize = 250.0,
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
    if (widget.duration < 1000)
      widget.duration = 2000;

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

  navigator(home) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) => home));
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
            SizedBox(height: widget.logoSize, child: widget.logo)
          )
      )
    );
  }
}