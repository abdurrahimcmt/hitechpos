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
    String vVatCatId;
    String vVatOption;
    double  mPercentage;
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
        required this.vVatCatId,
        required this.vVatOption,
        required this.mPercentage,
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
        vVatCatId: json["vVatCatId"],
        vVatOption: json["vVatOption"],
        mPercentage: json["mPercentage"].toDouble(),
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
        "vVatCatId": vVatCatId,
        "vVatOption": vVatOption,
        "mPercentage": mPercentage,
        "itemPriceList": List<dynamic>.from(itemPriceList.map((x) => x.toJson())),
        "onlineModifierLists": List<dynamic>.from(onlineModifierLists.map((x) => x.toJson())),
    };
}

class ItemPriceList {
    String vUnitId;
    String vUnitName;
    String vVatCatId;
    String vVatOption;
    double mPercentage;
    double mMainPrice;
    double mVatAmount;
    double mWoVatAmount;
    double mFinalPrice;

    ItemPriceList({
        required this.vUnitId,
        required this.vUnitName,
        required this.vVatCatId,
        required this.vVatOption,
        required this.mPercentage,
        required this.mMainPrice,
        required this.mVatAmount,
        required this.mWoVatAmount,
        required this.mFinalPrice,
    });

    factory ItemPriceList.fromJson(Map<String, dynamic> json) => ItemPriceList(
        vUnitId: json["vUnitId"],
        vUnitName: json["vUnitName"],
        vVatCatId: json["vVatCatId"],
        vVatOption: json["vVatOption"],
        mPercentage: json["mPercentage"]?.toDouble(),
        mMainPrice: json["mMainPrice"]?.toDouble(),
        mVatAmount: json["mVatAmount"]?.toDouble(),
        mWoVatAmount: json["mWoVatAmount"]?.toDouble(),
        mFinalPrice: json["mFinalPrice"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "vUnitId": vUnitId,
        "vUnitName": vUnitName,
        "vVatCatId": vVatCatId,
        "vVatOption": vVatOption,
        "mPercentage": mPercentage,
        "mMainPrice": mMainPrice,
        "mVatAmount": mVatAmount,
        "mWoVatAmount": mWoVatAmount,
        "mFinalPrice": mFinalPrice,
    };
}

class OnlineModifierList {
    dynamic iSerial;
    String vItemIdModifier;
    String vItemName;
    String iUnitId;
    String vUnitName;
    String vQuantity;
    String vMainPrice;
    double mQuantity;
    double mMainPrice;
    double mVatAmount;
    double mWoVatAmount;
    double mFinalPrice;
    String vVatCatId;
    String vVatOption;
    double mPercentage;

    OnlineModifierList({
        this.iSerial,
        required this.vItemIdModifier,
        required this.vItemName,
        required this.iUnitId,
        required this.vUnitName,
        required this.vQuantity,
        required this.vMainPrice,
        required this.mQuantity,
        required this.mMainPrice,
        required this.mVatAmount,
        required this.mWoVatAmount,
        required this.mFinalPrice,
        required this.vVatCatId,
        required this.vVatOption,
        required this.mPercentage,
    });

    factory OnlineModifierList.fromJson(Map<String, dynamic> json) => OnlineModifierList(
        iSerial: json["iSerial"],
        vItemIdModifier: json["vItemIdModifier"],
        vItemName: json["vItemName"],
        iUnitId: json["iUnitId"],
        vUnitName: json["vUnitName"],
        vQuantity: json["vQuantity"],
        vMainPrice: json["vMainPrice"],
        mQuantity: json["mQuantity"]?.toDouble(),
        mMainPrice: json["mMainPrice"]?.toDouble(),
        mVatAmount: json["mVatAmount"]?.toDouble(),
        mWoVatAmount: json["mWoVatAmount"]?.toDouble(),
        mFinalPrice: json["mFinalPrice"]?.toDouble(),
        vVatCatId: json["vVatCatId"],
        vVatOption: json["vVatOption"],
        mPercentage: json["mPercentage"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "iSerial": iSerial,
        "vItemIdModifier": vItemIdModifier,
        "vItemName": vItemName,
        "iUnitId": iUnitId,
        "vUnitName": vUnitName,
        "vQuantity": vQuantity,
        "vMainPrice": vMainPrice,
        "mQuantity": mQuantity,
        "mMainPrice": mMainPrice,
        "mVatAmount": mVatAmount,
        "mWoVatAmount": mWoVatAmount,
        "mFinalPrice": mFinalPrice,
        "vVatCatId": vVatCatId,
        "vVatOption": vVatOption,
        "mPercentage": mPercentage,
    };
}
