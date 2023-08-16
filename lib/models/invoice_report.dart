// To parse this JSON data, do
//
//     final invoiceReport = invoiceReportFromJson(jsonString);

import 'dart:convert';

String formatDateForMySQL(DateTime dateTime) {
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
}

InvoiceReportModel invoiceReportFromJson(String str) => InvoiceReportModel.fromJson(json.decode(str));

String invoiceReportToJson(InvoiceReportModel data) => json.encode(data.toJson());

class InvoiceReportModel {
    String messageId;
    String message;
    String returnValue;
    String invoiceId;
    String invoiceNo;
    double billAmount;
    List<ReportDetail> reportDetails;

    InvoiceReportModel({
        required this.messageId,
        required this.message,
        required this.returnValue,
        required this.invoiceId,
        required this.invoiceNo,
        required this.billAmount,
        required this.reportDetails,
    });

    factory InvoiceReportModel.fromJson(Map<String, dynamic> json) => InvoiceReportModel(
        messageId: json["messageId"],
        message: json["message"],
        returnValue: json["returnValue"],
        invoiceId: json["invoiceId"],
        invoiceNo: json["invoiceNo"],
        billAmount: json["billAmount"]?.toDouble(),
        reportDetails: List<ReportDetail>.from(json["reportDetails"].map((x) => ReportDetail.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "messageId": messageId,
        "message": message,
        "returnValue": returnValue,
        "invoiceId": invoiceId,
        "invoiceNo": invoiceNo,
        "billAmount": billAmount,
        "reportDetails": List<dynamic>.from(reportDetails.map((x) => x.toJson())),
    };
}

class ReportDetail {
    int iAutoId;
    String vBranchName;
    String vBranchAddress;
    String vBranchContact;
    String vVatNumber;
    String vTerminal;
    String vInvoiceId;
    String vInvoiceNo;
    String vOrderNo;
    String vSalesType;
    String vInvoiceStatus;
    DateTime dInvoiceDate;
    DateTime dSettleDate;
    int iNoOfCustomers;
    String vSpecialNote;
    String vVoidRemarks;
    String vUserName;
    String vTableName;
    String vWaiterName;
    String vPromotionCode;
    String vDriverName;
    String vDriverMobile;
    String vZoneName;
    String vCustomerName;
    String vCustomerAddress;
    String vCustomerMobile;
    double mBillAmount;
    double mDiscountAmount;
    double mRefundAmount;
    double mPaidAmount;
    double mChangeAmount;
    double mNetWithoutVat;
    double mNetVatAmount;
    String vItemExtra;
    String vItemId;
    String vItemName;
    String vItemKitchenName;
    String vUnitName;
    double mQuantity;
    String mVatPercent;
    String mVatPercentMax;
    String vVatOption;
    double mAmountWithoutVat;
    double mTotalVatAmount;
    double mFinalAmount;
    String vKitchenNote;
    String vInvoiceNote;
    String vMessage;
    String vCategoryId;
    String vKitchenPrinter;
    String vPrinted;
    String vCarNumber;

    ReportDetail({
        required this.iAutoId,
        required this.vBranchName,
        required this.vBranchAddress,
        required this.vBranchContact,
        required this.vVatNumber,
        required this.vTerminal,
        required this.vInvoiceId,
        required this.vInvoiceNo,
        required this.vOrderNo,
        required this.vSalesType,
        required this.vInvoiceStatus,
        required this.dInvoiceDate,
        required this.dSettleDate,
        required this.iNoOfCustomers,
        required this.vSpecialNote,
        required this.vVoidRemarks,
        required this.vUserName,
        required this.vTableName,
        required this.vWaiterName,
        required this.vPromotionCode,
        required this.vDriverName,
        required this.vDriverMobile,
        required this.vZoneName,
        required this.vCustomerName,
        required this.vCustomerAddress,
        required this.vCustomerMobile,
        required this.mBillAmount,
        required this.mDiscountAmount,
        required this.mRefundAmount,
        required this.mPaidAmount,
        required this.mChangeAmount,
        required this.mNetWithoutVat,
        required this.mNetVatAmount,
        required this.vItemExtra,
        required this.vItemId,
        required this.vItemName,
        required this.vItemKitchenName,
        required this.vUnitName,
        required this.mQuantity,
        required this.mVatPercent,
        required this.mVatPercentMax,
        required this.vVatOption,
        required this.mAmountWithoutVat,
        required this.mTotalVatAmount,
        required this.mFinalAmount,
        required this.vKitchenNote,
        required this.vInvoiceNote,
        required this.vMessage,
        required this.vCategoryId,
        required this.vKitchenPrinter,
        required this.vPrinted,
        required this.vCarNumber,
    });

    factory ReportDetail.fromJson(Map<String, dynamic> json) => ReportDetail(
        iAutoId: json["iAutoId"],
        vBranchName: json["vBranchName"],
        vBranchAddress: json["vBranchAddress"],
        vBranchContact: json["vBranchContact"],
        vVatNumber: json["vVatNumber"],
        vTerminal: json["vTerminal"],
        vInvoiceId: json["vInvoiceId"],
        vInvoiceNo: json["vInvoiceNo"],
        vOrderNo: json["vOrderNo"],
        vSalesType: json["vSalesType"],
        vInvoiceStatus: json["vInvoiceStatus"],
        dInvoiceDate: DateTime.parse(json["dInvoiceDate"]),
        dSettleDate: DateTime.parse(json["dSettleDate"]),
        iNoOfCustomers: json["iNoOfCustomers"],
        vSpecialNote: json["vSpecialNote"],
        vVoidRemarks: json["vVoidRemarks"],
        vUserName: json["vUserName"],
        vTableName: json["vTableName"],
        vWaiterName: json["vWaiterName"],
        vPromotionCode: json["vPromotionCode"],
        vDriverName: json["vDriverName"],
        vDriverMobile: json["vDriverMobile"],
        vZoneName: json["vZoneName"],
        vCustomerName: json["vCustomerName"],
        vCustomerAddress: json["vCustomerAddress"],
        vCustomerMobile: json["vCustomerMobile"],
        mBillAmount: json["mBillAmount"]?.toDouble(),
        mDiscountAmount: json["mDiscountAmount"]?.toDouble(),
        mRefundAmount: json["mRefundAmount"]?.toDouble(),
        mPaidAmount: json["mPaidAmount"]?.toDouble(),
        mChangeAmount: json["mChangeAmount"]?.toDouble(),
        mNetWithoutVat: json["mNetWithoutVat"]?.toDouble(),
        mNetVatAmount: json["mNetVatAmount"]?.toDouble(),
        vItemExtra: json["vItemExtra"],
        vItemId: json["vItemId"],
        vItemName: json["vItemName"],
        vItemKitchenName: json["vItemKitchenName"],
        vUnitName: json["vUnitName"],
        mQuantity: json["mQuantity"]?.toDouble(),
        mVatPercent: json["mVatPercent"],
        mVatPercentMax: json["mVatPercentMax"],
        vVatOption: json["vVatOption"],
        mAmountWithoutVat: json["mAmountWithoutVat"]?.toDouble(),
        mTotalVatAmount: json["mTotalVatAmount"]?.toDouble(),
        mFinalAmount: json["mFinalAmount"]?.toDouble(),
        vKitchenNote: json["vKitchenNote"],
        vInvoiceNote: json["vInvoiceNote"],
        vMessage: json["vMessage"],
        vCategoryId: json["vCategoryId"],
        vKitchenPrinter: json["vKitchenPrinter"],
        vPrinted: json["vPrinted"],
        vCarNumber: json["vCarNumber"],
    );

    Map<String, dynamic> toJson() => {
        "iAutoId": iAutoId,
        "vBranchName": vBranchName,
        "vBranchAddress": vBranchAddress,
        "vBranchContact": vBranchContact,
        "vVatNumber": vVatNumber,
        "vTerminal": vTerminal,
        "vInvoiceId": vInvoiceId,
        "vInvoiceNo": vInvoiceNo,
        "vOrderNo": vOrderNo,
        "vSalesType": vSalesType,
        "vInvoiceStatus": vInvoiceStatus,
        "dInvoiceDate": dInvoiceDate.toIso8601String(),
        "dSettleDate": dSettleDate.toIso8601String(),
        "iNoOfCustomers": iNoOfCustomers,
        "vSpecialNote": vSpecialNote,
        "vVoidRemarks": vVoidRemarks,
        "vUserName": vUserName,
        "vTableName": vTableName,
        "vWaiterName": vWaiterName,
        "vPromotionCode": vPromotionCode,
        "vDriverName": vDriverName,
        "vDriverMobile": vDriverMobile,
        "vZoneName": vZoneName,
        "vCustomerName": vCustomerName,
        "vCustomerAddress": vCustomerAddress,
        "vCustomerMobile": vCustomerMobile,
        "mBillAmount": mBillAmount,
        "mDiscountAmount": mDiscountAmount,
        "mRefundAmount": mRefundAmount,
        "mPaidAmount": mPaidAmount,
        "mChangeAmount": mChangeAmount,
        "mNetWithoutVat": mNetWithoutVat,
        "mNetVatAmount": mNetVatAmount,
        "vItemExtra": vItemExtra,
        "vItemId": vItemId,
        "vItemName": vItemName,
        "vItemKitchenName": vItemKitchenName,
        "vUnitName": vUnitName,
        "mQuantity": mQuantity,
        "mVatPercent": mVatPercent,
        "mVatPercentMax": mVatPercentMax,
        "vVatOption": vVatOption,
        "mAmountWithoutVat": mAmountWithoutVat,
        "mTotalVatAmount": mTotalVatAmount,
        "mFinalAmount": mFinalAmount,
        "vKitchenNote": vKitchenNote,
        "vInvoiceNote": vInvoiceNote,
        "vMessage": vMessage,
        "vCategoryId": vCategoryId,
        "vKitchenPrinter": vKitchenPrinter,
        "vPrinted": vPrinted,
        "vCarNumber": vCarNumber,
    };
}
