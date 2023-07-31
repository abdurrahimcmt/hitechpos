// To parse this JSON data, do
//
//     final floorAndTableInfo = floorAndTableInfoFromJson(jsonString);

import 'dart:convert';

FloorAndTableInfo floorAndTableInfoFromJson(String str) => FloorAndTableInfo.fromJson(json.decode(str));

String floorAndTableInfoToJson(FloorAndTableInfo data) => json.encode(data.toJson());

class FloorAndTableInfo {
    String messageId;
    String message;
    List<OnlineFloorTableList> onlineFloorTableList;

    FloorAndTableInfo({
        required this.messageId,
        required this.message,
        required this.onlineFloorTableList,
    });

    factory FloorAndTableInfo.fromJson(Map<String, dynamic> json) => FloorAndTableInfo(
        messageId: json["messageId"],
        message: json["message"],
        onlineFloorTableList: List<OnlineFloorTableList>.from(json["onlineFloorTableList"].map((x) => OnlineFloorTableList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "onlineFloorTableList": List<dynamic>.from(onlineFloorTableList.map((x) => x.toJson())),
    };
}

class OnlineFloorTableList {
    String vBranchId;
    String iFloorId;
    String vFloorName;
    List<OnlineTableList> onlineTableList;

    OnlineFloorTableList({
        required this.vBranchId,
        required this.iFloorId,
        required this.vFloorName,
        required this.onlineTableList,
    });

    factory OnlineFloorTableList.fromJson(Map<String, dynamic> json) => OnlineFloorTableList(
        vBranchId: json["vBranchId"],
        iFloorId: json["iFloorId"],
        vFloorName: json["vFloorName"],
        onlineTableList: List<OnlineTableList>.from(json["onlineTableList"].map((x) => OnlineTableList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vBranchId": vBranchId,
        "iFloorId": iFloorId,
        "vFloorName": vFloorName,
        "onlineTableList": List<dynamic>.from(onlineTableList.map((x) => x.toJson())),
    };
}

class OnlineTableList {
    String vBranchId;
    String vTableId;
    String vTableName;
    String vInvoiceId;
    String vInvoiceNo;

    OnlineTableList({
        required this.vBranchId,
        required this.vTableId,
        required this.vTableName,
        required this.vInvoiceId,
        required this.vInvoiceNo,
    });

    factory OnlineTableList.fromJson(Map<String, dynamic> json) => OnlineTableList(
        vBranchId: json["vBranchId"],
        vTableId: json["vTableId"],
        vTableName: json["vTableName"],
        vInvoiceId: json["vInvoiceId"],
        vInvoiceNo: json["vInvoiceNo"],
    );

    Map<String, dynamic> toJson() => {
        "vBranchId": vBranchId,
        "vTableId": vTableId,
        "vTableName": vTableName,
        "vInvoiceId": vInvoiceId,
        "vInvoiceNo": vInvoiceNo,
    };
}
