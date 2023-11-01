import 'package:flutter/material.dart';
import 'package:flutter_esc_pos_utils/flutter_esc_pos_utils.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:intl/intl.dart';

class InvoiceReceipt {

  final proceedController = Get.find<ProceedController>();

  Future<List<int>> makeReceipt(InvoiceReportModel invoice) async {
    String invoiceDate = DateFormat('yyyy-MM-dd h:mm a').format(invoice.reportDetails.first.dInvoiceDate);
    String printDateTime = DateFormat('yyyy-MM-dd h:mm a').format(DateTime.now());
    double mainItemQty = 1.00;
    try {
      final orderType = invoice.reportDetails.first.vSalesType;
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm80, profile);
      List<int> bytes = [];
      bytes += generator.text('KITCHEN ORDER',
        styles: const PosStyles(
          align: PosAlign.center,
          underline: true,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),linesAfter: 1);

      bytes += generator.text(orderType, 
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size1,
        width: PosTextSize.size1,
      ));

      bytes += generator.text("Order No: ${invoice.invoiceNo.toString().substring(8,invoice.invoiceNo.toString().length)}", 
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size1,
        width: PosTextSize.size1,
      ));

      bytes += generator.text('Invoice No: ${invoice.invoiceNo}',
      styles: const PosStyles(align: PosAlign.left));

      bytes += generator.text('Invoice Date: $invoiceDate',
      styles: const PosStyles(align: PosAlign.left));

      bytes += generator.text('Terminal: ${invoice.reportDetails.first.vTerminal}',
      styles: const PosStyles(align: PosAlign.left));

      bytes += generator.text('Cashier: ${invoice.reportDetails.first.vUserName}',
      styles: const PosStyles(align: PosAlign.left));
      bytes += generator.text(' ');
      bytes += generator.row([
        PosColumn(
          text: 'QTY X ITEM - SIZE',
          width: 9,
          styles: const PosStyles(
            align: PosAlign.center,
            bold: true,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          )
        ),
        PosColumn(
          text: 'PRICE',
          width: 3,
          styles: const PosStyles(
            align: PosAlign.center,
            bold: true,
            height: PosTextSize.size1,
            width: PosTextSize.size1,
          )
        ),
      ]);
      for (var i = 0; i < invoice.reportDetails.length; i++) {
        ReportDetail invoiceDetails = invoice.reportDetails[i];
        bool isModifier = false;
        List<String> listOfString = [];
        String modifierId = '';
        // ignore: unused_local_variable
        String itemExtraPrefex = '';

        if(invoiceDetails.vItemExtra.contains("#")){
          listOfString = invoiceDetails.vItemExtra.split('#');
        }

        if(listOfString.isNotEmpty){
          itemExtraPrefex = listOfString[0];
          modifierId = listOfString[1];
        }

        if(modifierId == invoiceDetails.vItemId){
          //For show unit of multiple item
          mainItemQty = invoiceDetails.mQuantity;
          isModifier = false;
        }

        if(modifierId != invoiceDetails.vItemId){
          isModifier = true;
        }
        if(!isModifier){
            bytes += generator.text(' ');
            bytes += generator.row([
            PosColumn(
              text: '${invoiceDetails.mQuantity.toStringAsFixed(0)} x ${invoiceDetails.vItemName}  - ${invoiceDetails.vUnitName}',
              width: 9,
              styles: const PosStyles(
                bold: true,
                align: PosAlign.left,
              )
            ),
            PosColumn(
              text: invoiceDetails.mFinalAmount.toStringAsFixed(3) + " BHD",
              width: 3,
              styles: const PosStyles(
                align: PosAlign.right,
                bold: true,
              )
            ),
          ]);
          if(invoiceDetails.vKitchenNote.isNotEmpty)
            bytes += generator.row([
            PosColumn(
              text: "  KN: ${invoiceDetails.vKitchenNote}",
              width: 9,
              styles: const PosStyles(
                align: PosAlign.left,
              )
            ),
            PosColumn(
              text: '',
              width: 3,
              styles: const PosStyles(
                align: PosAlign.right,
              )
            ),
          ]);
          if(invoiceDetails.vInvoiceNote.isNotEmpty)
          bytes += generator.row([
            PosColumn(
              text: "  IN: ${invoiceDetails.vInvoiceNote}",
              width: 9,
              styles: const PosStyles(
                align: PosAlign.left,
              )
            ),
            PosColumn(
              text: '',
              width: 3,
              styles: const PosStyles(
                align: PosAlign.right,
              )
            ),
          ]);

        }
        else{
            bytes += generator.row([
            PosColumn(
              text: '   ${(invoiceDetails.mQuantity/(invoiceDetails.mQuantity/mainItemQty)).toStringAsFixed(0)} x ${(invoiceDetails.mQuantity/mainItemQty).toStringAsFixed(0)}  ${invoiceDetails.vItemName} - ${invoiceDetails.vUnitName}',
              width: 9,
              styles: const PosStyles(
                align: PosAlign.left,
              )
            ),
            PosColumn(
              text: invoiceDetails.mFinalAmount.toStringAsFixed(3) + " BHD",
              width: 3,
              styles: const PosStyles(
                align: PosAlign.right,
              )
            ),
          ]);
        }
      };
      bytes += generator.text(' ');
      if(orderType == "Dine In")
      bytes += generator.text('Table Name: ${invoice.reportDetails.first.vTableName}',
      styles: const PosStyles(align: PosAlign.left,bold: true,));

      if(orderType == "Take Away" || orderType == "Delivery" || orderType == "Drive Thru" )
      bytes += generator.text('Customer Name: ${invoice.reportDetails.first.vCustomerName}',
      styles: const PosStyles(align: PosAlign.left));

      if(orderType == "Delivery" || orderType == "Drive Thru")
      bytes += generator.text('Address: ${invoice.reportDetails.first.vCustomerAddress}',
      styles: const PosStyles(align: PosAlign.left));
      
      if(orderType == "Drive Thru")
      bytes += generator.text('Car Number: ${invoice.reportDetails.first.vCarNumber}',
      styles: const PosStyles(align: PosAlign.left));
      
      bytes += generator.text('Print Datetime: $printDateTime',
      styles: const PosStyles(align: PosAlign.left));

      bytes += generator.feed(2);
      bytes += generator.cut();
      return bytes;
    } catch (e) {
      debugPrint('Error generating PDF: $e');
      rethrow;
    }
  }

}
