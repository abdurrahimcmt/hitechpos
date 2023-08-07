// To parse this JSON data, do
//
//     final invoiceInfoDetails = invoiceInfoDetailsFromJson(jsonString);

import 'dart:convert';

String formatDateForMySQL(DateTime dateTime) {
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
}
InvoiceInfoDetails invoiceInfoDetailsFromJson(String str) => InvoiceInfoDetails.fromJson(json.decode(str));

String invoiceInfoDetailsToJson(InvoiceInfoDetails data) => json.encode(data.toJson());

class InvoiceInfoDetails {
    List<InvoiceInfo> invoiceInfo;

    InvoiceInfoDetails({
        required this.invoiceInfo,
    });

    factory InvoiceInfoDetails.fromJson(Map<String, dynamic> json) => InvoiceInfoDetails(
        invoiceInfo: List<InvoiceInfo>.from(json["invoiceInfo"].map((x) => InvoiceInfo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "invoiceInfo": List<dynamic>.from(invoiceInfo.map((x) => x.toJson())),
    };
}

class InvoiceInfo {
    String vBranchId;
    String vInvoiceId;
    String vInvoiceNo;
    String vBarcode;
    String vSplitTicketId;
    String iSalesTypeId;
    String iStatusId;
    String iClosed;
    String vTableId;
    String vWaiterId;
    String vPromotionId;
    String vDriverId;
    String vZoneId;
    String vCustomerId;
    String vCustomerAddress;
    String iNoOfCustomers;
    DateTime dSaveDate;
    DateTime dSettleDate;
    DateTime dDeliveryDate;
    String mBillAmount;
    String mPaidAmount;
    String vSpecialNote;
    String vRemarksForVoid;
    String vTerminalName;
    String vCreatedBy;
    DateTime dCreatedDate;
    String vModifiedBy;
    DateTime dModifiedDate;
    String  vSyncedMacId;
    String  iSynced;
    String vUniqueId;
    List<InvoiceDetail> invoiceDetails;
    List<dynamic> invoiceSettle;
    
    InvoiceInfo({
        required this.vBranchId,
        required this.vInvoiceId,
        required this.vInvoiceNo,
        required this.vBarcode,
        required this.vSplitTicketId,
        required this.iSalesTypeId,
        required this.iStatusId,
        required this.iClosed,
        required this.vTableId,
        required this.vWaiterId,
        required this.vPromotionId,
        required this.vDriverId,
        required this.vZoneId,
        required this.vCustomerId,
        required this.vCustomerAddress,
        required this.iNoOfCustomers,
        required this.dSaveDate,
        required this.dSettleDate,
        required this.dDeliveryDate,
        required this.mBillAmount,
        required this.mPaidAmount,
        required this.vSpecialNote,
        required this.vRemarksForVoid,
        required this.vTerminalName,
        required this.vCreatedBy,
        required this.dCreatedDate,
        required this.vModifiedBy,
        required this.dModifiedDate,
        required this.invoiceDetails,
        required this.invoiceSettle,
        required this.vSyncedMacId,
        required this.iSynced,
        required this.vUniqueId,
    });

    factory InvoiceInfo.fromJson(Map<String, dynamic> json) => InvoiceInfo(
        vBranchId: json["vBranchId"],
        vInvoiceId: json["vInvoiceId"],
        vInvoiceNo: json["vInvoiceNo"],
        vBarcode: json["vBarcode"],
        vSplitTicketId: json["vSplitTicketId"],
        iSalesTypeId: json["iSalesTypeId"],
        iStatusId: json["iStatusId"],
        iClosed: json["iClosed"],
        vTableId: json["vTableId"],
        vWaiterId: json["vWaiterId"],
        vPromotionId: json["vPromotionId"],
        vDriverId: json["vDriverId"],
        vZoneId: json["vZoneId"],
        vCustomerId: json["vCustomerId"],
        vCustomerAddress: json["vCustomerAddress"],
        iNoOfCustomers: json["iNoOfCustomers"],
        dSaveDate: DateTime.parse(json["dSaveDate"]),
        dSettleDate: DateTime.parse(json["dSettleDate"]),
        dDeliveryDate: DateTime.parse(json["dDeliveryDate"]),
        mBillAmount: json["mBillAmount"],
        mPaidAmount: json["mPaidAmount"],
        vSpecialNote: json["vSpecialNote"],
        vRemarksForVoid: json["vRemarksForVoid"],
        vTerminalName: json["vTerminalName"],
        vCreatedBy: json["vCreatedBy"],
        dCreatedDate: DateTime.parse(json["dCreatedDate"]),
        vModifiedBy: json["vModifiedBy"],
        dModifiedDate: DateTime.parse(json["dModifiedDate"]),
        vSyncedMacId: json["vSyncedMacId"],
        iSynced: json["iSynced"],
        vUniqueId: json["vUniqueId"],
        invoiceDetails: List<InvoiceDetail>.from(json["invoiceDetails"].map((x) => InvoiceDetail.fromJson(x))),
        invoiceSettle: List<dynamic>.from(json["invoiceSettle"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "vBranchId": vBranchId,
        "vInvoiceId": vInvoiceId,
        "vInvoiceNo": vInvoiceNo,
        "vBarcode": vBarcode,
        "vSplitTicketId": vSplitTicketId,
        "iSalesTypeId": iSalesTypeId,
        "iStatusId": iStatusId,
        "iClosed": iClosed,
        "vTableId": vTableId,
        "vWaiterId": vWaiterId,
        "vPromotionId": vPromotionId,
        "vDriverId": vDriverId,
        "vZoneId": vZoneId,
        "vCustomerId": vCustomerId,
        "vCustomerAddress": vCustomerAddress,
        "iNoOfCustomers": iNoOfCustomers,
        "dSaveDate": formatDateForMySQL(dSaveDate),
        "dSettleDate": formatDateForMySQL(dSettleDate),
        "dDeliveryDate": formatDateForMySQL(dDeliveryDate),
        "mBillAmount": mBillAmount,
        "mPaidAmount": mPaidAmount,
        "vSpecialNote": vSpecialNote,
        "vRemarksForVoid": vRemarksForVoid,
        "vTerminalName": vTerminalName,
        "vCreatedBy": vCreatedBy,
        "dCreatedDate":  formatDateForMySQL(dCreatedDate),
        "vModifiedBy": vModifiedBy,
        "dModifiedDate": formatDateForMySQL(dModifiedDate) ,
        "vSyncedMacId": vSyncedMacId,
        "iSynced": iSynced,
        "vUniqueId": vUniqueId,
        "invoiceDetails": List<dynamic>.from(invoiceDetails.map((x) => x.toJson())),
        "invoiceSettle": List<dynamic>.from(invoiceSettle.map((x) => x)),
    };
}

class InvoiceDetail {
    String vInvoiceId;
    String vItemId;
    String vUnitId;
    String mQuantity;
    String mCosting;
    String vVatCatId;
    String mVatPercent;
    String vVatOption;
    String mMainPrice;
    String mNetAmount;
    String mDisPercent;
    String mDisAmount;
    String mDisCalculated;
    String mAmountAfterDis;
    String mVoidPercent;
    String mVoidAmount;
    String mVoidCalculated;
    String mAmountAfterDisVoid;
    String mAmountWithoutVat;
    String mTotalVatAmount;
    String mFinalPrice;
    String mFinalAmount;
    String iClosed;
    String vItemExtra;
    String vKitchenNote;
    String vInvoiceNote;
    String vRemarks;
    String iInvoiceStatusId;
    String vStatusRemarks;
    String vCreatedBy;
    DateTime dCreatedDate;
    String vModifiedBy;
    DateTime dModifiedDate;

    InvoiceDetail({
        required this.vInvoiceId,
        required this.vItemId,
        required this.vUnitId,
        required this.mQuantity,
        required this.mCosting,
        required this.vVatCatId,
        required this.mVatPercent,
        required this.vVatOption,
        required this.mMainPrice,
        required this.mNetAmount,
        required this.mDisPercent,
        required this.mDisAmount,
        required this.mDisCalculated,
        required this.mAmountAfterDis,
        required this.mVoidPercent,
        required this.mVoidAmount,
        required this.mVoidCalculated,
        required this.mAmountAfterDisVoid,
        required this.mAmountWithoutVat,
        required this.mTotalVatAmount,
        required this.mFinalPrice,
        required this.mFinalAmount,
        required this.iClosed,
        required this.vItemExtra,
        required this.vKitchenNote,
        required this.vInvoiceNote,
        required this.vRemarks,
        required this.iInvoiceStatusId,
        required this.vStatusRemarks,
        required this.vCreatedBy,
        required this.dCreatedDate,
        required this.vModifiedBy,
        required this.dModifiedDate,
    });

    factory InvoiceDetail.fromJson(Map<String, dynamic> json) => InvoiceDetail(
        vInvoiceId: json["vInvoiceId"],
        vItemId: json["vItemId"],
        vUnitId: json["vUnitId"],
        mQuantity: json["mQuantity"],
        mCosting: json["mCosting"],
        vVatCatId: json["vVatCatId"],
        mVatPercent: json["mVatPercent"],
        vVatOption: json["vVatOption"],
        mMainPrice: json["mMainPrice"],
        mNetAmount: json["mNetAmount"],
        mDisPercent: json["mDisPercent"],
        mDisAmount: json["mDisAmount"],
        mDisCalculated: json["mDisCalculated"],
        mAmountAfterDis: json["mAmountAfterDis"],
        mVoidPercent: json["mVoidPercent"],
        mVoidAmount: json["mVoidAmount"],
        mVoidCalculated: json["mVoidCalculated"],
        mAmountAfterDisVoid: json["mAmountAfterDisVoid"],
        mAmountWithoutVat: json["mAmountWithoutVat"],
        mTotalVatAmount: json["mTotalVatAmount"],
        mFinalPrice: json["mFinalPrice"],
        mFinalAmount: json["mFinalAmount"],
        iClosed: json["iClosed"],
        vItemExtra: json["vItemExtra"],
        vKitchenNote: json["vKitchenNote"],
        vInvoiceNote: json["vInvoiceNote"],
        vRemarks: json["vRemarks"],
        iInvoiceStatusId: json["iInvoiceStatusId"],
        vStatusRemarks: json["vStatusRemarks"],
        vCreatedBy: json["vCreatedBy"],
        dCreatedDate: DateTime.parse(json["dCreatedDate"]),
        vModifiedBy: json["vModifiedBy"],
        dModifiedDate: DateTime.parse(json["dModifiedDate"]),
    );

    Map<String, dynamic> toJson() => {
        "vInvoiceId": vInvoiceId,
        "vItemId": vItemId,
        "vUnitId": vUnitId,
        "mQuantity": mQuantity,
        "mCosting": mCosting,
        "vVatCatId": vVatCatId,
        "mVatPercent": mVatPercent,
        "vVatOption": vVatOption,
        "mMainPrice": mMainPrice,
        "mNetAmount": mNetAmount,
        "mDisPercent": mDisPercent,
        "mDisAmount": mDisAmount,
        "mDisCalculated": mDisCalculated,
        "mAmountAfterDis": mAmountAfterDis,
        "mVoidPercent": mVoidPercent,
        "mVoidAmount": mVoidAmount,
        "mVoidCalculated": mVoidCalculated,
        "mAmountAfterDisVoid": mAmountAfterDisVoid,
        "mAmountWithoutVat": mAmountWithoutVat,
        "mTotalVatAmount": mTotalVatAmount,
        "mFinalPrice": mFinalPrice,
        "mFinalAmount": mFinalAmount,
        "iClosed": iClosed,
        "vItemExtra": vItemExtra,
        "vKitchenNote": vKitchenNote,
        "vInvoiceNote": vInvoiceNote,
        "vRemarks": vRemarks,
        "iInvoiceStatusId": iInvoiceStatusId,
        "vStatusRemarks": vStatusRemarks,
        "vCreatedBy": vCreatedBy,
        "dCreatedDate": formatDateForMySQL(dCreatedDate),
        "vModifiedBy": vModifiedBy,
        "dModifiedDate": formatDateForMySQL(dModifiedDate),
    };
}
