import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.OutputStream
import java.net.Socket

class PrinterPlugin : MethodChannel.MethodCallHandler {

    companion object {
        fun registerWith(channel: MethodChannel) {
            val instance = PrinterPlugin()
            channel.setMethodCallHandler(instance)
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "printViaWiFi") {
            val printerIp = call.argument<String>("printerIp")
            val printerPort = call.argument<Int>("printerPort")
            val pdfData = call.argument<List<Int>>("pdfData")
            
            if (printerIp != null && printerPort != null && pdfData != null) {
                GlobalScope.launch(Dispatchers.IO) {
                    val printingResult = printViaWiFi(printerIp, printerPort, pdfData)
                    if (printingResult) {
                        GlobalScope.launch(Dispatchers.Main) {
                            result.success("Print job sent successfully")
                        }
                    } else {
                        GlobalScope.launch(Dispatchers.Main) {
                            result.error("PRINT_ERROR", "Failed to send print job", null)
                        }
                    }
                }
            } else {
                result.error("INVALID_PARAMETERS", "Invalid parameters", null)
            }
        } else {
            result.notImplemented()
        }
    }


    private fun printViaWiFi(printerIp: String, printerPort: Int, pdfData: List<Int>): Boolean {
        return try {
            // Use a third-party library or Android's built-in socket communication to send the PDF data to the printer via Wi-Fi.
            val socket = java.net.Socket(printerIp, printerPort)
            val outputStream = socket.getOutputStream()
            val byteArray = pdfData.map { it.toByte() }.toByteArray()
            outputStream.write(byteArray)
            outputStream.close()
            socket.close()
            true
        } catch (e: Exception) {
            e.printStackTrace()
            false
        }
    }
}
