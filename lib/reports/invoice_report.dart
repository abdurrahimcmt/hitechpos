import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceReport {

  double pageSize = 230;
  final proceedController = Get.find<ProceedController>();
  final pdf = pw.Document();
  pw.Widget sizeBox = pw.SizedBox(height: 5);
  pw.Widget sizeBoxS = pw.SizedBox(height: 2);
  pw.TextStyle titleTextStyle = pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold,font: pw.Font.helveticaBold(),);
  pw.TextStyle salesTypeTextStyle = pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold,font: pw.Font.helveticaBold(),);
  pw.TextStyle orderNoTextStyle = pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold,font: pw.Font.helveticaBold(),);
  pw.TextStyle textStyle = pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.normal,font: pw.Font.helvetica(),);
  
  Future<Uint8List> makePdf(InvoiceReportModel invoice) async {
    
    pageSize = pageSize = pageSize + (invoice.reportDetails.length * 15);
    //final invoiceInfoDetails = invoiceFuture;
    //InvoiceInfo invoiceInfo = invoiceInfoDetails.;
    String invoiceDate = DateFormat('yyyy-MM-dd h:mm a').format(invoice.reportDetails.first.dInvoiceDate);
    String printDateTime = DateFormat('yyyy-MM-dd h:mm a').format(DateTime.now());
    
    try {

      final orderType = invoice.reportDetails.first.vSalesType;

      pdf.addPage(

        pw.Page(
          //header: buildHeader,
          pageTheme: pw.PageTheme(
            orientation: pw.PageOrientation.portrait,
            margin: const pw.EdgeInsets.only(left: 10, right: 10),
            pageFormat: PdfPageFormat(216, pageSize),
          ),

          build: (context) {
              return pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Column(
                    children: [
                      sizeBox,
                      pw.Center(
                        child: pw.Container(
                          width: 150,
                          height: 20,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(width: 0.5),
                            borderRadius: const pw.BorderRadius.all(pw.Radius.circular(15)),
                          ),
                          child: pw.Center(
                            child: pw.Text(
                              "KITCHEN ORDER",
                              style: pw.TextStyle(
                                font: pw.Font.timesBold(),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  sizeBox,
                  pw.Center(
                    child:pw.Text(
                      orderType,
                      style: salesTypeTextStyle,
                    ),
                  ),

                  sizeBox,
                  pw.Center(
                    child: pw.Text(
                      "Order No: ${invoice.invoiceNo.toString().substring(8,invoice.invoiceNo.toString().length)}",
                      style: orderNoTextStyle,
                    ),
                  ),
                  sizeBox,
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          "Invoice No",
                          textAlign: pw.TextAlign.left,
                          style: textStyle,
                        ),
                      ),
                      pw.Expanded(
                        flex: 8,
                        child: pw.Text(
                          ": ${invoice.invoiceNo}",
                          textAlign: pw.TextAlign.left,
                          style: textStyle,
                        ),
                      ),

                    ]
                  ),
                  sizeBox,
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          "Invoice Date",
                          textAlign: pw.TextAlign.left,
                          style: textStyle,
                        ),
                      ),
                      pw.Expanded(
                        flex: 8,
                        child: pw.Text(": $invoiceDate",
                          textAlign: pw.TextAlign.left,
                          style: textStyle,
                        ),
                      ),

                    ]
                  ),
                  sizeBox,
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          "Terminal",
                          textAlign: pw.TextAlign.left,
                          style: textStyle,
                        ),
                      ),
                      pw.Expanded(
                        flex: 8,
                        child: pw.Text(": ${invoice.reportDetails.first.vTerminal}",
                          textAlign: pw.TextAlign.left,
                          style: textStyle,
                        ),
                      ),

                    ]
                  ),
                  sizeBox,
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text(
                          "Cashier",
                          textAlign: pw.TextAlign.left,
                          style: textStyle,
                        ),
                      ),
                      pw.Expanded(
                        flex: 8,
                        child: pw.Text(": ${invoice.reportDetails.first.vUserName}",
                          textAlign: pw.TextAlign.left,
                          style: textStyle,
                        ),
                      ),

                    ]
                  ),
                  sizeBox,
                  pw.Divider(
                    height: 1,
                    borderStyle: pw.BorderStyle.dotted,
                  ),
                  sizeBox,
                  pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 8,
                        child: pw.Text(
                          "QTY X ITEM - SIZE",
                          textAlign: pw.TextAlign.center,
                          style: titleTextStyle,
                        ),
                      ),
                      pw.Expanded(
                        flex: 4,
                        child: pw.Text("PRICE",
                          textAlign: pw.TextAlign.right,
                          style: titleTextStyle,
                        ),
                      ),
                    ]
                  ),
                  sizeBox,
                  pw.Divider(
                    height: 1,
                    borderStyle: pw.BorderStyle.dotted,
                  ),
                  pw.ListView.builder(
                    itemCount: invoice.reportDetails.length,
                    itemBuilder:(context, index) {

                      ReportDetail invoiceDetails = invoice.reportDetails[index];
                      bool isModifier = false;
                      debugPrint( "Details ${invoiceDetails.vItemExtra}");
                      List<String> listOfString = [];
                      String modifierId = '';
                      String itemExtraPrefex = '';

                      if(invoiceDetails.vItemExtra.contains("#")){
                        listOfString = invoiceDetails.vItemExtra.split('#');
                      }

                      if(listOfString.isNotEmpty){
                        debugPrint("String List $listOfString");
                        itemExtraPrefex = listOfString[0];
                        modifierId = listOfString[1];
                      }

                      debugPrint("Prefex $itemExtraPrefex");
                      debugPrint("Modifier $modifierId");

                      String lastMainItemId = invoiceDetails.vItemId;

                      if(modifierId == invoiceDetails.vItemId){
                        debugPrint("Main Product with Modifier: ${invoiceDetails.vItemExtra} ");
                        lastMainItemId = invoiceDetails.vItemId;
                        isModifier = false;
                      }

                      if(modifierId != invoiceDetails.vItemId){
                        debugPrint("${invoiceDetails.vItemExtra} is modifier of ${invoiceDetails.vItemId}");
                        isModifier = true;
                      }
                      
                      if(!isModifier){
                        return pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            sizeBox,
                            pw.Row(
                              children: [
                                pw.Expanded(
                                  flex: 10,
                                  child: pw.Text(
                                    "${invoiceDetails.mQuantity.toStringAsFixed(0)} x ${invoiceDetails.vItemName}  - ${invoiceDetails.vUnitName}",
                                    textAlign: pw.TextAlign.left,
                                    style: textStyle,
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 2,
                                  child: pw.Text(invoiceDetails.mFinalAmount.toStringAsFixed(3),
                                    textAlign: pw.TextAlign.right,
                                    style: textStyle,
                                  ),
                                ),
                              ]
                            ),
                            
                            if(invoiceDetails.vKitchenNote.isNotEmpty)
                            pw.Text(
                              "KN: ${invoiceDetails.vKitchenNote}",
                              textAlign: pw.TextAlign.left,
                              style: textStyle,
                            ),
                            
                            if(invoiceDetails.vInvoiceNote.isNotEmpty)
                            pw.Text(
                              "IN: ${invoiceDetails.vInvoiceNote}",
                              textAlign: pw.TextAlign.left,
                              style: textStyle,
                            ),                            
                          ]
                        );
                      }
                      else{
                        return pw.Row(
                          children: [
                            pw.Expanded(
                              flex: 10,
                              child: pw.Text(
                                "   ${invoiceDetails.vItemName}  - ${invoiceDetails.vUnitName}",
                                textAlign: pw.TextAlign.left,
                                style: textStyle,
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(invoiceDetails.mFinalAmount.toStringAsFixed(3),
                                textAlign: pw.TextAlign.right,
                                style: textStyle,
                              ),
                            ),
                          ]
                        );
                      }
                    },
                  ),
                  sizeBox,
                  pw.Divider(
                    height: 1,
                    borderStyle: pw.BorderStyle.dotted,
                  ),
                  sizeBox,
                  if(orderType == "Dine In")
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    children: [
                      pw.Text("Table Name: ${invoice.reportDetails.first.vTableName}",
                        textAlign: pw.TextAlign.left,
                        style: textStyle,
                      ),
                    ]
                  ),
                  // Take Way
                  if(orderType == "Take Away" || orderType == "Delivery" || orderType == "Drive Thru" )
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("Customer Name: ${invoice.reportDetails.first.vCustomerName}",
                        textAlign: pw.TextAlign.left,
                        style: textStyle,
                      ),
                    ]
                  ),

                  //Delivery
                  if(orderType == "Delivery" || orderType == "Drive Thru")
                  pw.Column(
                    children: [
                      sizeBoxS,
                      pw.Row(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Expanded(
                            flex: 2,
                            child: pw.Text(
                              "Address:",
                              textAlign: pw.TextAlign.left,
                              style: textStyle,
                            ),
                          ),
                          pw.Expanded(
                            flex: 10,
                            child: pw.Text(" ${invoice.reportDetails.first.vCustomerAddress}",
                              textAlign: pw.TextAlign.left,
                              style: textStyle,
                            ),
                          ),
                        ]
                      ),
                      
                      sizeBoxS,
                      if(orderType == "Drive Thru")
                      pw.Row(
                        children: [
                          pw.Text("Car Number: ${invoice.reportDetails.first.vCarNumber}",
                            textAlign: pw.TextAlign.left,
                            style: textStyle,
                          ),
                        ]
                      ),
                    ]
                  ),
                  sizeBoxS,
                  pw.Row(
                    children: [
                      pw.Text("Print Datetime: $printDateTime",
                        textAlign: pw.TextAlign.left,
                        style: textStyle,
                      ),
                    ]
                  ),
                 // sizeBox,
                  //   pw.Row(
                  //   children: [
                  //     pw.Expanded(
                  //       flex: 1,
                  //       child: pw.Text(
                  //         "KN:",
                  //         textAlign: pw.TextAlign.left,
                  //         style: textStyle,
                  //       ),
                  //     ),
                  //     pw.Expanded(
                  //       flex: 4,
                  //       child: pw.Text(invoice.reportDetails.first.vKitchenNote,
                  //         textAlign: pw.TextAlign.left,
                  //         style: textStyle,
                  //       ),
                  //     ),
                     
                  //     pw.Expanded(
                  //       flex: 1,
                  //       child: pw.Text(
                  //         "IN:",
                  //         textAlign: pw.TextAlign.left,
                  //         style: textStyle,
                  //       ),
                  //     ),
                  //     pw.Expanded(
                  //       flex: 11,
                  //       child: pw.Text(invoice.reportDetails.first.vInvoiceNote,
                  //         textAlign: pw.TextAlign.left,
                  //         style: textStyle,
                  //       ),
                  //     ),
                  //   ]
                  // ),
                  sizeBox,
                  // pw.Center(
                  //   child:pw.Text(
                  //     "**PAID**",
                  //     style: titleTextStyle,
                  //   ),
                  // ),

                  // Display other invoice details here
                  // You can also add a pw.Flexible widget to allow variable height content
                ],
              );
            
          },
        ),
      );

      return pdf.save();
      
    } catch (error) {
      // Handle errors here
      debugPrint('Error generating PDF: $error');
      rethrow;
    }
    
  }
  pw.Widget buildHeader(pw.Context context){
    return pw.Column(
      children: [
        sizeBox,
        pw.Center(
          child: pw.Container(
            width: 150,
            height: 20,
            decoration: pw.BoxDecoration(
              border: pw.Border.all(width: 0.5),
              borderRadius: const pw.BorderRadius.all(pw.Radius.circular(15)),
            ),
            child: pw.Center(
              child: pw.Text(
                "KITCHEN ORDER",
                style: pw.TextStyle(
                  font: pw.Font.timesBold(),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
