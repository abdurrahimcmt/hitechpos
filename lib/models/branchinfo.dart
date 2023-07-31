import 'dart:convert';

BranchInfo branchInfoFromJson(String str) => BranchInfo.fromJson(json.decode(str));

String branchInfoToJson(BranchInfo data) => json.encode(data.toJson());

class BranchInfo {
    String messageId;
    String message;
    List<BranchList> branchList;

    BranchInfo({
        required this.messageId,
        required this.message,
        required this.branchList,
    });

    factory BranchInfo.fromJson(Map<String, dynamic> json) => BranchInfo(
        messageId: json["messageId"],
        message: json["message"],
        branchList: List<BranchList>.from(json["branchList"].map((x) => BranchList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "branchList": List<dynamic>.from(branchList.map((x) => x.toJson())),
    };
}

class BranchList {
    String vCompanyId;
    String vBranchId;
    String vBranchName;
    String vAddress;
    String vPhone;
    String vFax;
    String vEmail;
    String vLicenceNo;
    String vContactPerson;
    String vMobileNo;
    String vEmailId;
    int iBranchTypeId;
    int iSessionTime;
    int iDefault;
    DateTime vStartFrom;
    int iActive;
    String vCreatedBy;
    DateTime dCreatedDate;
    String vModifiedBy;
    DateTime dModifiedDate;
    String vBranchType;

    BranchList({
        required this.vCompanyId,
        required this.vBranchId,
        required this.vBranchName,
        required this.vAddress,
        required this.vPhone,
        required this.vFax,
        required this.vEmail,
        required this.vLicenceNo,
        required this.vContactPerson,
        required this.vMobileNo,
        required this.vEmailId,
        required this.iBranchTypeId,
        required this.iSessionTime,
        required this.iDefault,
        required this.vStartFrom,
        required this.iActive,
        required this.vCreatedBy,
        required this.dCreatedDate,
        required this.vModifiedBy,
        required this.dModifiedDate,
        required this.vBranchType,
    });

    factory BranchList.fromJson(Map<String, dynamic> json) => BranchList(
        vCompanyId: json["vCompanyId"],
        vBranchId: json["vBranchId"],
        vBranchName: json["vBranchName"],
        vAddress: json["vAddress"],
        vPhone: json["vPhone"],
        vFax: json["vFax"],
        vEmail: json["vEmail"],
        vLicenceNo: json["vLicenceNo"],
        vContactPerson: json["vContactPerson"],
        vMobileNo: json["vMobileNo"],
        vEmailId: json["vEmailId"],
        iBranchTypeId: json["iBranchTypeId"],
        iSessionTime: json["iSessionTime"],
        iDefault: json["iDefault"],
        vStartFrom: DateTime.parse(json["vStartFrom"]),
        iActive: json["iActive"],
        vCreatedBy: json["vCreatedBy"],
        dCreatedDate: DateTime.parse(json["dCreatedDate"]),
        vModifiedBy: json["vModifiedBy"],
        dModifiedDate: DateTime.parse(json["dModifiedDate"]),
        vBranchType: json["vBranchType"],
    );

    Map<String, dynamic> toJson() => {
        "vCompanyId": vCompanyId,
        "vBranchId": vBranchId,
        "vBranchName": vBranchName,
        "vAddress": vAddress,
        "vPhone": vPhone,
        "vFax": vFax,
        "vEmail": vEmail,
        "vLicenceNo": vLicenceNo,
        "vContactPerson": vContactPerson,
        "vMobileNo": vMobileNo,
        "vEmailId": vEmailId,
        "iBranchTypeId": iBranchTypeId,
        "iSessionTime": iSessionTime,
        "iDefault": iDefault,
        "vStartFrom": "${vStartFrom.year.toString().padLeft(4, '0')}-${vStartFrom.month.toString().padLeft(2, '0')}-${vStartFrom.day.toString().padLeft(2, '0')}",
        "iActive": iActive,
        "vCreatedBy": vCreatedBy,
        "dCreatedDate": dCreatedDate.toIso8601String(),
        "vModifiedBy": vModifiedBy,
        "dModifiedDate": dModifiedDate.toIso8601String(),
        "vBranchType": vBranchType,
    };
}
