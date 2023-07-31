// To parse this JSON data, do
//
//     final itemDetails = itemDetailsFromJson(jsonString);

import 'dart:convert';

ItemDetails itemDetailsFromJson(String str) => ItemDetails.fromJson(json.decode(str));

String itemDetailsToJson(ItemDetails data) => json.encode(data.toJson());

class ItemDetails {
    String messageId;
    String message;
    List<ItemViewList> itemViewList;

    ItemDetails({
        required this.messageId,
        required this.message,
        required this.itemViewList,
    });

    factory ItemDetails.fromJson(Map<String, dynamic> json) => ItemDetails(
        messageId: json["messageId"],
        message: json["message"],
        itemViewList: List<ItemViewList>.from(json["itemViewList"].map((x) => ItemViewList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "itemViewList": List<dynamic>.from(itemViewList.map((x) => x.toJson())),
    };
}

class ItemViewList {
    String vItemId;
    String vItemType;
    String vItemName;
    String vDescription;
    String vItemNameAr;
    String vImagePath;
    String vItemPrice;
    String vPriceDetails;
    List<ItemPriceList> itemPriceList;
    List<OnlineModifierList> onlineModifierLists;

    ItemViewList({
        required this.vItemId,
        required this.vItemType,
        required this.vItemName,
        required this.vDescription,
        required this.vItemNameAr,
        required this.vImagePath,
        required this.vItemPrice,
        required this.vPriceDetails,
        required this.itemPriceList,
        required this.onlineModifierLists,
    });

    factory ItemViewList.fromJson(Map<String, dynamic> json) => ItemViewList(
        vItemId: json["vItemId"],
        vItemType: json["vItemType"],
        vItemName: json["vItemName"],
        vDescription: json["vDescription"],
        vItemNameAr: json["vItemNameAr"],
        vImagePath: json["vImagePath"],
        vItemPrice: json["vItemPrice"],
        vPriceDetails: json["vPriceDetails"],
        itemPriceList: List<ItemPriceList>.from(json["itemPriceList"].map((x) => ItemPriceList.fromJson(x))),
        onlineModifierLists: List<OnlineModifierList>.from(json["onlineModifierLists"].map((x) => OnlineModifierList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vItemId": vItemId,
        "vItemType": vItemType,
        "vItemName": vItemName,
        "vDescription": vDescription,
        "vItemNameAr": vItemNameAr,
        "vImagePath": vImagePath,
        "vItemPrice": vItemPrice,
        "vPriceDetails": vPriceDetails,
        "itemPriceList": List<dynamic>.from(itemPriceList.map((x) => x.toJson())),
        "onlineModifierLists": List<dynamic>.from(onlineModifierLists.map((x) => x.toJson())),
    };
}

class ItemPriceList {
    String vUnitId;
    String vUnitName;
    String vPrice;

    ItemPriceList({
        required this.vUnitId,
        required this.vUnitName,
        required this.vPrice,
    });

    factory ItemPriceList.fromJson(Map<String, dynamic> json) => ItemPriceList(
        vUnitId: json["vUnitId"],
        vUnitName: json["vUnitName"],
        vPrice: json["vPrice"],
    );

    Map<String, dynamic> toJson() => {
        "vUnitId": vUnitId,
        "vUnitName": vUnitName,
        "vPrice": vPrice,
    };
}

class OnlineModifierList {
    int iSerial;
    String vItemIdModifier;
    String vItemName;
    String vQuantity;
    String vMainPrice;

    OnlineModifierList({
        required this.iSerial,
        required this.vItemIdModifier,
        required this.vItemName,
        required this.vQuantity,
        required this.vMainPrice,
    });

    factory OnlineModifierList.fromJson(Map<String, dynamic> json) => OnlineModifierList(
        iSerial: json["iSerial"],
        vItemIdModifier: json["vItemIdModifier"],
        vItemName: json["vItemName"],
        vQuantity: json["vQuantity"],
        vMainPrice: json["vMainPrice"],
    );

    Map<String, dynamic> toJson() => {
        "iSerial": iSerial,
        "vItemIdModifier": vItemIdModifier,
        "vItemName": vItemName,
        "vQuantity": vQuantity,
        "vMainPrice": vMainPrice,
    };
}
