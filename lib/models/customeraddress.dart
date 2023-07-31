// To parse this JSON data, do
//
//     final customerAddress = customerAddressFromJson(jsonString);

import 'dart:convert';

CustomerAddress customerAddressFromJson(String str) => CustomerAddress.fromJson(json.decode(str));

String customerAddressToJson(CustomerAddress data) => json.encode(data.toJson());

class CustomerAddress {
    String messageId;
    String message;
    List<CustomerAddressList> customerAddressList;

    CustomerAddress({
        required this.messageId,
        required this.message,
        required this.customerAddressList,
    });

    factory CustomerAddress.fromJson(Map<String, dynamic> json) => CustomerAddress(
        messageId: json["messageId"],
        message: json["message"],
        customerAddressList: List<CustomerAddressList>.from(json["customerAddressList"].map((x) => CustomerAddressList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "customerAddressList": List<dynamic>.from(customerAddressList.map((x) => x.toJson())),
    };
}

class CustomerAddressList {
    String vCustomerId;
    String vAddId;
    String vArea;
    String vBuildingNo;
    String vFlatNo;
    String vBlockNo;
    String vRoadNo;

    CustomerAddressList({
        required this.vCustomerId,
        required this.vAddId,
        required this.vArea,
        required this.vBuildingNo,
        required this.vFlatNo,
        required this.vBlockNo,
        required this.vRoadNo,
    });

    factory CustomerAddressList.fromJson(Map<String, dynamic> json) => CustomerAddressList(
        vCustomerId: json["vCustomerId"],
        vAddId: json["vAddId"],
        vArea: json["vArea"],
        vBuildingNo: json["vBuildingNo"],
        vFlatNo: json["vFlatNo"],
        vBlockNo: json["vBlockNo"],
        vRoadNo: json["vRoadNo"],
    );

    Map<String, dynamic> toJson() => {
        "vCustomerId": vCustomerId,
        "vAddId": vAddId,
        "vArea": vArea,
        "vBuildingNo": vBuildingNo,
        "vFlatNo": vFlatNo,
        "vBlockNo": vBlockNo,
        "vRoadNo": vRoadNo,
    };
}
