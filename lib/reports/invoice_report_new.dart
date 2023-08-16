import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoiceReportNew {
  final proceedController = Get.find<ProceedController>();
  final pdf = pw.Document();
  pw.Widget sizeBox = pw.SizedBox(height: 5);
  pw.TextStyle titleTextStyle = pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold,font: pw.Font.timesBold(),);
  pw.TextStyle textStyle = pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.normal,font: pw.Font.times(),);
  
  pw.Widget _buildPageContent(List<ReportDetail> items,bool isFirstPage,bool isLastPage,var orderType,String invoiceDate,String printDateTime,InvoiceReportModel invoice){
    return pw.Column(
      children: [ 
          if(isFirstPage)
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              sizeBox,
              pw.Center(
                child:pw.Text(
                  orderType,
                  style: titleTextStyle,
                ),
              ),

              sizeBox,
              pw.Center(
                child: pw.Text(
                  "Order No: ${invoice.invoiceNo.toString().substring(8,invoice.invoiceNo.toString().length)}",
                  style: titleTextStyle,
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
            ],
          ),
          pw.ListView.builder(
            itemCount: items.length,
            itemBuilder:(context, index) {

              ReportDetail invoiceDetails = items[index];

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
              }

              if(modifierId != invoiceDetails.vItemId){
                debugPrint("${invoiceDetails.vItemExtra} is modifier of ${invoiceDetails.vItemId}");
              }
              if(modifierId.isNotEmpty){
                String qty = invoiceDetails.mQuantity.toStringAsFixed(0);
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    sizeBox,
                    pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 10,
                          child: pw.Text(
                            "$qty x ${invoiceDetails.vItemName}  - ${invoiceDetails.vUnitName}",
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


        if(isLastPage)
        pw.Column(
          children: [
            sizeBox,
            pw.Divider(
              height: 1,
              borderStyle: pw.BorderStyle.dotted,
            ),
            sizeBox,
            sizeBox,
            pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Text(
                    "Print Datetime:",
                    textAlign: pw.TextAlign.left,
                    style: textStyle,
                  ),
                ),
                pw.Expanded(
                  flex: 8,
                  child: pw.Text(": $printDateTime",
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
                  flex: 1,
                  child: pw.Text(
                    "IN:",
                    textAlign: pw.TextAlign.left,
                    style: textStyle,
                  ),
                ),
                pw.Expanded(
                  flex: 11,
                  child: pw.Text(invoice.reportDetails.first.vInvoiceNote,
                    textAlign: pw.TextAlign.left,
                    style: textStyle,
                  ),
                ),
                sizeBox,
              ]
            ),          
          ]
        ),
      ]
    );

  }
   
  Future<Uint8List> makePdf(InvoiceReportModel invoice) async {
    double pageSize = 250;
    String invoiceDate = DateFormat('yyyy-MM-dd h:mm a').format(invoice.reportDetails.first.dInvoiceDate);
    String printDateTime = DateFormat('yyyy-MM-dd h:mm a').format(DateTime.now());
    try {
      final orderType = invoice.reportDetails.first.vSalesType;
      pageSize = pageSize + (invoice.reportDetails.length * 20) + 50;
      pdf.addPage(
        pw.MultiPage(
          header: buildHeader,
          pageTheme: pw.PageTheme(
            orientation: pw.PageOrientation.portrait,
            margin: const pw.EdgeInsets.only(left: 10, right: 10),
            pageFormat: PdfPageFormat(216, pageSize),
          ),
          
          build: (context) {
            // This is doing for multipage pagination but now using for single page
            // int itemsPerPage = invoice.reportDetails.length;
            int itemsPerPage = invoice.reportDetails.length;
            
            final totalItems = invoice.reportDetails.length;
            final pages = <pw.Widget>[];
            bool isFirstPage = true;

            for(var i = 0; i < totalItems; i += itemsPerPage ){
              if(i == 0){
                isFirstPage = true;
              }
              else{
                isFirstPage = false;
              }
              final endIndex = (i + itemsPerPage < totalItems) ? i + itemsPerPage : totalItems;
              bool isLastPage = (i + itemsPerPage < totalItems) ? false : true;
              final itemsSubset = invoice.reportDetails.sublist(i, endIndex);
              pages.add(_buildPageContent(itemsSubset,isFirstPage,isLastPage,orderType,invoiceDate,printDateTime,invoice));
            }
            return pages;
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
