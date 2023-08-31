// To parse this JSON data, do
//
//     final userDetailsModel = userDetailsModelFromJson(jsonString);

import 'dart:convert';

UserDetailsModel userDetailsModelFromJson(String str) => UserDetailsModel.fromJson(json.decode(str));

String userDetailsModelToJson(UserDetailsModel data) => json.encode(data.toJson());

class UserDetailsModel {
    String messageId;
    String message;
    List<UserInfoList> userInfoList;

    UserDetailsModel({
        required this.messageId,
        required this.message,
        required this.userInfoList,
    });

    factory UserDetailsModel.fromJson(Map<String, dynamic> json) => UserDetailsModel(
        messageId: json["messageId"],
        message: json["message"],
        userInfoList: List<UserInfoList>.from(json["userInfoList"].map((x) => UserInfoList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "userInfoList": List<dynamic>.from(userInfoList.map((x) => x.toJson())),
    };
}

class UserInfoList {
    String vBranchName;
    String vFullName;
    String vUserImage;
    String vRoleName;
    String vMobileNo;
    String vEmailId;
    String vUserTypeName;
    String dExpiryDate;

    UserInfoList({
        required this.vBranchName,
        required this.vFullName,
        required this.vUserImage,
        required this.vRoleName,
        required this.vMobileNo,
        required this.vEmailId,
        required this.vUserTypeName,
        required this.dExpiryDate,
    });

    factory UserInfoList.fromJson(Map<String, dynamic> json) => UserInfoList(
        vBranchName: json["vBranchName"],
        vFullName: json["vFullName"],
        vUserImage: json["vUserImage"],
        vRoleName: json["vRoleName"],
        vMobileNo: json["vMobileNo"],
        vEmailId: json["vEmailId"],
        vUserTypeName: json["vUserTypeName"],
        dExpiryDate: json["dExpiryDate"],
    );

    Map<String, dynamic> toJson() => {
        "vBranchName": vBranchName,
        "vFullName": vFullName,
        "vUserImage": vUserImage,
        "vRoleName": vRoleName,
        "vMobileNo": vMobileNo,
        "vEmailId": vEmailId,
        "vUserTypeName": vUserTypeName,
        "dExpiryDate": dExpiryDate,
    };
}
