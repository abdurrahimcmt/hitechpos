import 'package:flutter/material.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:hitechpos/reports/invoice_receipt.dart';
import 'package:hitechpos/reports/printingservices.dart';

class PrintReportPdf extends StatelessWidget {
  final InvoiceReportModel invoice;
  PrintReportPdf({Key? key, required this.invoice,}) : super(key: key);

  void printReport() async {
    try {
      List<int> pdfContent = await InvoiceReceipt().makeReceipt(invoice);
      //Uint8List pdfContent = await InvoiceReport().makePdf(invoice); // Your generated PDF content
      String printerIp = '192.168.2.100'; // Replace with the printer's IP address
      int printerPort = 9100; // Replace with the printer's port
      print("printer Ip" + printerIp);
      print("printer port" + printerPort.toString());
      print(pdfContent);
      printViaWiFi(printerIp, printerPort, pdfContent);
    } catch (e) {
      print('Error printing: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Report"),
      ),
      body: ElevatedButton(
        onPressed: () { 
          printReport();
         },
        child: Text('Print Invoice Report'),
      ),
    );
  }
}
