// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

UserInfo userInfoFromJson(String str) => UserInfo.fromJson(json.decode(str));

String userInfoToJson(UserInfo data) => json.encode(data.toJson());

class UserInfo {
    String messageId;
    String message;
    List<UserList> userList;

    UserInfo({
        required this.messageId,
        required this.message,
        required this.userList,
    });

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        messageId: json["messageId"],
        message: json["message"],
        userList: List<UserList>.from(json["userList"].map((x) => UserList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "userList": List<dynamic>.from(userList.map((x) => x.toJson())),
    };
}

class UserList {
    String vRoleId;
    String vBranchId;
    String vUserId;
    String vUserName;
    String vPassword;
    DateTime dExpiryDate;
    String vFullName;
    String vMobileNo;
    String vEmailId;
    int iUserTypeId;
    int iActive;
    DateTime dLastLogin;
    String vEmployeeId;
    String vUserImage;
    String vPosAccess;
    String vCreatedBy;
    DateTime dCreatedDate;
    String vModifiedBy;
    DateTime dModifiedDate;
    dynamic vUserTypeName;
    dynamic iTypeActive;

    UserList({
        required this.vRoleId,
        required this.vBranchId,
        required this.vUserId,
        required this.vUserName,
        required this.vPassword,
        required this.dExpiryDate,
        required this.vFullName,
        required this.vMobileNo,
        required this.vEmailId,
        required this.iUserTypeId,
        required this.iActive,
        required this.dLastLogin,
        required this.vEmployeeId,
        required this.vUserImage,
        required this.vPosAccess,
        required this.vCreatedBy,
        required this.dCreatedDate,
        required this.vModifiedBy,
        required this.dModifiedDate,
        this.vUserTypeName,
        this.iTypeActive,
    });

    factory UserList.fromJson(Map<String, dynamic> json) => UserList(
        vRoleId: json["vRoleId"],
        vBranchId: json["vBranchId"],
        vUserId: json["vUserId"],
        vUserName: json["vUserName"],
        vPassword: json["vPassword"],
        dExpiryDate: DateTime.parse(json["dExpiryDate"]),
        vFullName: json["vFullName"],
        vMobileNo: json["vMobileNo"],
        vEmailId: json["vEmailId"],
        iUserTypeId: json["iUserTypeId"],
        iActive: json["iActive"],
        dLastLogin: DateTime.parse(json["dLastLogin"]),
        vEmployeeId: json["vEmployeeId"],
        vUserImage: json["vUserImage"],
        vPosAccess: json["vPosAccess"],
        vCreatedBy: json["vCreatedBy"],
        dCreatedDate: DateTime.parse(json["dCreatedDate"]),
        vModifiedBy: json["vModifiedBy"],
        dModifiedDate: DateTime.parse(json["dModifiedDate"]),
        vUserTypeName: json["vUserTypeName"],
        iTypeActive: json["iTypeActive"],
    );

    Map<String, dynamic> toJson() => {
        "vRoleId": vRoleId,
        "vBranchId": vBranchId,
        "vUserId": vUserId,
        "vUserName": vUserName,
        "vPassword": vPassword,
        "dExpiryDate": dExpiryDate.toIso8601String(),
        "vFullName": vFullName,
        "vMobileNo": vMobileNo,
        "vEmailId": vEmailId,
        "iUserTypeId": iUserTypeId,
        "iActive": iActive,
        "dLastLogin": dLastLogin.toIso8601String(),
        "vEmployeeId": vEmployeeId,
        "vUserImage": vUserImage,
        "vPosAccess": vPosAccess,
        "vCreatedBy": vCreatedBy,
        "dCreatedDate": dCreatedDate.toIso8601String(),
        "vModifiedBy": vModifiedBy,
        "dModifiedDate": dModifiedDate.toIso8601String(),
        "vUserTypeName": vUserTypeName,
        "iTypeActive": iTypeActive,
    };
}
