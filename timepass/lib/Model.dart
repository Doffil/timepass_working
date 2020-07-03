// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
    Welcome({
        this.name,
        this.imageUrl,
        this.haveSubCategory,
        this.id,
        this.subCategory,
    });

    String name;
    String imageUrl;
    String haveSubCategory;
    String id;
    List<SubCategory> subCategory;

    factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        name: json["name"],
        imageUrl: json["imageUrl"],
        haveSubCategory: json["haveSubCategory"],
        id: json["id"],
        subCategory: List<SubCategory>.from(json["subCategory"].map((x) => SubCategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "imageUrl": imageUrl,
        "haveSubCategory": haveSubCategory,
        "id": id,
        "subCategory": List<dynamic>.from(subCategory.map((x) => x.toJson())),
    };
}

class SubCategory {
    SubCategory({
        this.subName,
        this.subId,
        this.subPrice,
        this.subQuantity,
        this.subImageUrl,
    });

    String subName;
    String subId;
    String subPrice;
    String subQuantity;
    String subImageUrl;

    factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        subName: json["subName"],
        subId: json["subId"],
        subPrice: json["subPrice"],
        subQuantity: json["subQuantity"],
        subImageUrl: json["subImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "subName": subName,
        "subId": subId,
        "subPrice": subPrice,
        "subQuantity": subQuantity,
        "subImageUrl": subImageUrl,
    };
}

