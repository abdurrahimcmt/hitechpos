import 'dart:convert';

ItemInfo itemInfoFromJson(String str) => ItemInfo.fromJson(json.decode(str));

String itemInfoToJson(ItemInfo data) => json.encode(data.toJson());

class ItemInfo {
    String messageId;
    String message;
    List<ItemList> itemList;

    ItemInfo({
        required this.messageId,
        required this.message,
        required this.itemList,
    });

    factory ItemInfo.fromJson(Map<String, dynamic> json) => ItemInfo(
        messageId: json["messageId"],
        message: json["message"],
        itemList: List<ItemList>.from(json["itemList"].map((x) => ItemList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "itemList": List<dynamic>.from(itemList.map((x) => x.toJson())),
    };
}

class ItemList {
    String vItemId;
    String vItemName;
    String vItemPrice;
    String vItemImage;

    ItemList({
        required this.vItemId,
        required this.vItemName,
        required this.vItemPrice,
        required this.vItemImage,
    });

    factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        vItemId: json["vItemId"],
        vItemName: json["vItemName"],
        vItemPrice: json["vItemPrice"],
        vItemImage: json["vItemImage"],
    );

    Map<String, dynamic> toJson() => {
        "vItemId": vItemId,
        "vItemName": vItemName,
        "vItemPrice": vItemPrice,
        "vItemImage": vItemImage,
    };
}
