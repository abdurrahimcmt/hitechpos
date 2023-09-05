import 'package:flutter/material.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:hitechpos/reports/invoice_report.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {

  final InvoiceReportModel invoice;

  const PdfPreviewPage({Key ? key, required this.invoice} ) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Report"),
        // actions: [
        //   TextButton.icon(
        //     onPressed: () async {
        //       await Printing.layoutPdf(
        //       onLayout: (PdfPageFormat format) async => InvoiceReport().makePdf(invoice));
        //     }, 
        //     icon: Icon(Icons.print_rounded,size: 20,color: Colors.white,), 
        //     label:Text("Print Document")),
        // ],
      ),
      body: PdfPreview(
        build: (context) => InvoiceReport().makePdf(invoice),
      ),
    );
  }
}