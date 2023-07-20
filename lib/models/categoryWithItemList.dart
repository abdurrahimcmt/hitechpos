import 'dart:convert';

CategoryWithItemList categoryWithItemListFromJson(String str) => CategoryWithItemList.fromJson(json.decode(str));

String categoryWithItemListToJson(CategoryWithItemList data) => json.encode(data.toJson());

class CategoryWithItemList {
    String messageId;
    String message;
    List<OnlineCatWithItemList> onlineCatWithItemLists;

    CategoryWithItemList({
        required this.messageId,
        required this.message,
        required this.onlineCatWithItemLists,
    });

    factory CategoryWithItemList.fromJson(Map<String, dynamic> json) => CategoryWithItemList(
        messageId: json["messageId"],
        message: json["message"],
        onlineCatWithItemLists: List<OnlineCatWithItemList>.from(json["onlineCatWithItemLists"].map((x) => OnlineCatWithItemList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "onlineCatWithItemLists": List<dynamic>.from(onlineCatWithItemLists.map((x) => x.toJson())),
    };
}

class OnlineCatWithItemList {
    String vCategoryId;
    String vCategoryName;
    String vCategoryDescription;
    List<OnlineItemList> onlineItemLists;

    OnlineCatWithItemList({
        required this.vCategoryId,
        required this.vCategoryName,
        required this.vCategoryDescription,
        required this.onlineItemLists,
    });

    factory OnlineCatWithItemList.fromJson(Map<String, dynamic> json) => OnlineCatWithItemList(
        vCategoryId: json["vCategoryId"],
        vCategoryName: json["vCategoryName"],
        vCategoryDescription: json["vCategoryDescription"],
        onlineItemLists: List<OnlineItemList>.from(json["onlineItemLists"].map((x) => OnlineItemList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vCategoryId": vCategoryId,
        "vCategoryName": vCategoryName,
        "vCategoryDescription": vCategoryDescription,
        "onlineItemLists": List<dynamic>.from(onlineItemLists.map((x) => x.toJson())),
    };
}

class OnlineItemList {
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

    OnlineItemList({
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

    factory OnlineItemList.fromJson(Map<String, dynamic> json) => OnlineItemList(
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
        vItemName:  json["vItemName"],
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

