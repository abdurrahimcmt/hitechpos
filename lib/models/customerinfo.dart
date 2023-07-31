// To parse this JSON data, do
//
//     final customerInfo = customerInfoFromJson(jsonString);

import 'dart:convert';

CustomerInfo customerInfoFromJson(String str) => CustomerInfo.fromJson(json.decode(str));

String customerInfoToJson(CustomerInfo data) => json.encode(data.toJson());

class CustomerInfo {
    String messageId;
    String message;
    List<CustomerList> customerList;

    CustomerInfo({
        required this.messageId,
        required this.message,
        required this.customerList,
    });

    factory CustomerInfo.fromJson(Map<String, dynamic> json) => CustomerInfo(
        messageId: json["messageId"],
        message: json["message"],
        customerList: List<CustomerList>.from(json["customerList"].map((x) => CustomerList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "customerList": List<dynamic>.from(customerList.map((x) => x.toJson())),
    };
}

class CustomerList {
    String vBranchId;
    String vCustomerId;
    String vCustomerCode;
    String vCustomerName;
    String vVatRegNo;
    String vMobileNo;
    String vEmailId;
    int iCreditLimit;
    int iActive;
    String vCreatedBy;
    DateTime dCreatedDate;
    String vModifiedBy;
    DateTime dModifiedDate;

    CustomerList({
        required this.vBranchId,
        required this.vCustomerId,
        required this.vCustomerCode,
        required this.vCustomerName,
        required this.vVatRegNo,
        required this.vMobileNo,
        required this.vEmailId,
        required this.iCreditLimit,
        required this.iActive,
        required this.vCreatedBy,
        required this.dCreatedDate,
        required this.vModifiedBy,
        required this.dModifiedDate,
    });

    factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
        vBranchId: json["vBranchId"],
        vCustomerId: json["vCustomerId"],
        vCustomerCode: json["vCustomerCode"],
        vCustomerName: json["vCustomerName"],
        vVatRegNo: json["vVatRegNo"],
        vMobileNo: json["vMobileNo"],
        vEmailId: json["vEmailId"],
        iCreditLimit: json["iCreditLimit"],
        iActive: json["iActive"],
        vCreatedBy: json["vCreatedBy"],
        dCreatedDate: DateTime.parse(json["dCreatedDate"]),
        vModifiedBy: json["vModifiedBy"],
        dModifiedDate: DateTime.parse(json["dModifiedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "vBranchId": vBranchId,
        "vCustomerId": vCustomerId,
        "vCustomerCode": vCustomerCode,
        "vCustomerName": vCustomerName,
        "vVatRegNo": vVatRegNo,
        "vMobileNo": vMobileNo,
        "vEmailId": vEmailId,
        "iCreditLimit": iCreditLimit,
        "iActive": iActive,
        "vCreatedBy": vCreatedBy,
        "dCreatedDate": dCreatedDate.toIso8601String(),
        "vModifiedBy": vModifiedBy,
        "dModifiedDate": dModifiedDate.toIso8601String(),
    };
}
