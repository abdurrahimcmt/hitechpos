// To parse this JSON data, do
//
//     final OrderListModel = orderListFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListFromJson(String str) => OrderListModel.fromJson(json.decode(str));

String orderListToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
    String messageId;
    String message;
    List<InvoiceStatusList> invoiceStatusList;

    OrderListModel({
        required this.messageId,
        required this.message,
        required this.invoiceStatusList,
    });

    factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
        messageId: json["messageId"],
        message: json["message"],
        invoiceStatusList: List<InvoiceStatusList>.from(json["invoiceStatusList"].map((x) => InvoiceStatusList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "invoiceStatusList": List<dynamic>.from(invoiceStatusList.map((x) => x.toJson())),
    };
}

class InvoiceStatusList {
    String vSalesType;
    String vInvoiceId;
    String vInvoiceNo;
    String vCustomerName;
    String vTable;
    double mTotalAmount;
    String vInvoiceDate;
    String vStatusId;
    String vStatus;

    InvoiceStatusList({
        required this.vSalesType,
        required this.vInvoiceId,
        required this.vInvoiceNo,
        required this.vCustomerName,
        required this.vTable,
        required this.mTotalAmount,
        required this.vInvoiceDate,
        required this.vStatusId,
        required this.vStatus,
    });

    factory InvoiceStatusList.fromJson(Map<String, dynamic> json) => InvoiceStatusList(
        vSalesType: json["vSalesType"],
        vInvoiceId: json["vInvoiceId"],
        vInvoiceNo: json["vInvoiceNo"],
        vCustomerName: json["vCustomerName"],
        vTable: json["vTable"],
        mTotalAmount: json["mTotalAmount"]?.toDouble(),
        vInvoiceDate: json["vInvoiceDate"],
        vStatusId: json["vStatusId"],
        vStatus: json["vStatus"],
    );

    Map<String, dynamic> toJson() => {
        "vSalesType": vSalesType,
        "vInvoiceId": vInvoiceId,
        "vInvoiceNo": vInvoiceNo,
        "vCustomerName": vCustomerName,
        "vTable": vTable,
        "mTotalAmount": mTotalAmount,
        "vInvoiceDate": vInvoiceDate,
        "vStatusId": vStatusId,
        "vStatus": vStatus,
    };
}
