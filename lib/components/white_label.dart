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
