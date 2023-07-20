// To parse this JSON data, do
//
//     final categoryInfo = categoryInfoFromJson(jsonString);

import 'dart:convert';

CategoryInfo categoryInfoFromJson(String str) => CategoryInfo.fromJson(json.decode(str));

String categoryInfoToJson(CategoryInfo data) => json.encode(data.toJson());

class CategoryInfo {
    String messageId;
    String message;
    List<CategoryList> categoryList;

    CategoryInfo({
        required this.messageId,
        required this.message,
        required this.categoryList,
    });

    factory CategoryInfo.fromJson(Map<String, dynamic> json) => CategoryInfo(
        messageId: json["messageId"],
        message: json["message"],
        categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
    };
}

class CategoryList {
    String vCategoryId;
    String vCategoryName;

    CategoryList({
        required this.vCategoryId,
        required this.vCategoryName,
    });

    factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
        vCategoryId: json["vCategoryId"],
        vCategoryName: json["vCategoryName"],
    );

    Map<String, dynamic> toJson() => {
        "vCategoryId": vCategoryId,
        "vCategoryName": vCategoryName,
    };
}
