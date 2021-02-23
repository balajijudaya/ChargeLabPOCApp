// To parse this JSON data, do
//
//     final whiteLabel = whiteLabelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class WhiteLabel {
    WhiteLabel({
        @required this.brandId,
    });

    final BrandId brandId;

    factory WhiteLabel.fromRawJson(String str) => WhiteLabel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory WhiteLabel.fromJson(Map<String, dynamic> json) => WhiteLabel(
        brandId: BrandId.fromJson(json["BrandID"]),
    );

    Map<String, dynamic> toJson() => {
        "BrandID": brandId.toJson(),
    };
}

class BrandId {
    BrandId({
        @required this.chargeLab,
        @required this.testBrand,
    });

    final ChargeLab chargeLab;
    final ChargeLab testBrand;

    factory BrandId.fromRawJson(String str) => BrandId.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory BrandId.fromJson(Map<String, dynamic> json) => BrandId(
        chargeLab: ChargeLab.fromJson(json["ChargeLab"]),
        testBrand: ChargeLab.fromJson(json["TestBrand"]),
    );

    Map<String, dynamic> toJson() => {
        "ChargeLab": chargeLab.toJson(),
        "TestBrand": testBrand.toJson(),
    };
}

class ChargeLab {
    ChargeLab({
        @required this.greetMsg,
        @required this.logo,
        @required this.supportPhone,
    });

    final String greetMsg;
    final String logo;
    final String supportPhone;

    factory ChargeLab.fromRawJson(String str) => ChargeLab.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ChargeLab.fromJson(Map<String, dynamic> json) => ChargeLab(
        greetMsg: json["greetMsg"],
        logo: json["logo"],
        supportPhone: json["supportPhone"],
    );

    Map<String, dynamic> toJson() => {
        "greetMsg": greetMsg,
        "logo": logo,
        "supportPhone": supportPhone,
    };
}
