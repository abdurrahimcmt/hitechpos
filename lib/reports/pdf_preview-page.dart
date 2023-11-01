import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:hitechpos/reports/invoice_report.dart';
import 'package:hitechpos/views/order/orderlist.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {

  final InvoiceReportModel invoice;
  final String screen;

  const PdfPreviewPage({Key ? key, required this.invoice, required this.screen } ) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(screen == "OrderListScreen"){
          Get.to(() => const OrderListScreen());
        }
        else{
          Get.back();
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Invoice Report"),
          leading: GestureDetector(
            onTap: () {
              if(screen == "OrderListScreen"){
                Get.to(() => const OrderListScreen());
              }
              else{
                Get.back();
              }
            },
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: PdfPreview(
          build: (context) => InvoiceReport().makePdf(invoice),
        ),
      ),
    );
  }
}