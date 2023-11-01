import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('com.example.hitechpos/printerPlugin');

Future<void> printViaWiFi(String printerIp, int printerPort, List pdfData) async {
  await Future(() async {
    try {
      await _channel.invokeMethod('printViaWiFi', {
        'printerIp': printerIp,
        'printerPort': printerPort,
        'pdfData': pdfData,
      });
    } catch (e) {
      print('Error printing via Wi-Fi: $e');
    }
  });
}

