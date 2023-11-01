// To parse this JSON data, do
//
//     final printers = printersFromJson(jsonString);

import 'dart:convert';

Printers printersFromJson(String str) => Printers.fromJson(json.decode(str));

String printersToJson(Printers data) => json.encode(data.toJson());

class Printers {
    String totalPrinters;
    List<PrinterList> printerList;

    Printers({
        required this.totalPrinters,
        required this.printerList,
    });

    factory Printers.fromJson(Map<String, dynamic> json) => Printers(
        totalPrinters: json["totalPrinters"],
        printerList: List<PrinterList>.from(json["printerList"].map((x) => PrinterList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalPrinters": totalPrinters,
        "printerList": List<dynamic>.from(printerList.map((x) => x.toJson())),
    };
}

class PrinterList {
    String vPrinterType;
    String vPrinterLocation;
    String vPrinterId;
    String vPrinterName;
    String vPaperSize;
    String vPrinterIp;
    String vPort;
    String vMacAddress;

    PrinterList({
        required this.vPrinterType,
        required this.vPrinterLocation,
        required this.vPrinterId,
        required this.vPrinterName,
        required this.vPaperSize,
        required this.vPrinterIp,
        required this.vPort,
        required this.vMacAddress,
    });

    factory PrinterList.fromJson(Map<String, dynamic> json) => PrinterList(
        vPrinterType: json["vPrinterType"],
        vPrinterLocation: json["vPrinterLocation"],
        vPrinterId: json["vPrinterId"],
        vPrinterName: json["vPrinterName"],
        vPaperSize: json["vPaperSize"],
        vPrinterIp: json["vPrinterIp"],
        vPort: json["vPort"],
        vMacAddress: json["vMacAddress"],
    );

    Map<String, dynamic> toJson() => {
        "vPrinterType": vPrinterType,
        "vPrinterLocation": vPrinterLocation,
        "vPrinterId": vPrinterId,
        "vPrinterName": vPrinterName,
        "vPaperSize": vPaperSize,
        "vPrinterIp": vPrinterIp,
        "vPort": vPort,
        "vMacAddress": vMacAddress,
    };
}
