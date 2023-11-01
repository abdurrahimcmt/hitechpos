import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/controllers/ordersuccessfull_controller.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/models/invoice_report.dart';
import 'package:hitechpos/reports/pdf_preview-page.dart';
import 'package:hitechpos/views/menu/menu_screen.dart';

class OrderSuccessfulScreen extends GetView<OrderSuccessfullController> {
  OrderSuccessfulScreen({Key ? key}) : super(key : key);
  final proceedController = Get.find<ProceedController>();
  final Future<InvoiceReportModel> invoice = Get.arguments;
  
  @override
  Widget build(BuildContext context) {
    commonTextStyle(double fSize){
      return TextStyle(
        fontFamily: Palette.layoutFont,
        fontWeight: FontWeight.w600,
        fontSize: fSize,
        color: Colors.white,
      );
    }
    Size size = MediaQuery.of(context).size;
    bool ispotrait= MediaQuery.of(context).orientation == Orientation.portrait;
    double sizeboxheight = ispotrait? 10.0 : 5.0;

    return GetBuilder<OrderSuccessfullController>(
      builder: (controller) {
        if (controller.isScreenOpen && proceedController.isReportPrint) {
          controller.printReceipt(proceedController.invoiceReportData);
        }
        return WillPopScope(
          onWillPop: () async{
            controller.clearCartData();
            Get.to(() => MenuScreen());
            return true;
          },
          child: Scaffold(
            body: FutureBuilder<InvoiceReportModel>(
              future: invoice, 
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return Container(
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                      gradient: Palette.bgGradient,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.height*0.1,
                          ),
                          Image(image: const AssetImage('assets/images/img-01.png'),
                            height: ispotrait ? 100 : 80,
                          ),
                          Container(
                            height: size.height*0.5,
                            width: size.width*0.9,
                            decoration: const BoxDecoration(
                              gradient: Palette.btnGradientColor,
                              borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle,color: Colors.white,size: ispotrait ? 80: 50,),
                                SizedBox(
                                  height: sizeboxheight,
                                ),
                                Text("Order Successfully Processed",
                                  style: commonTextStyle(20),
                                ),
                                SizedBox(
                                  height: sizeboxheight,
                                ),
                                Text("Total Amount: BHD ${snapshot.data!.billAmount.toStringAsFixed(3)} ",
                                  style: commonTextStyle(15),
                                ),
                                SizedBox(
                                  height: sizeboxheight+20,
                                ),
                                Text("Order Number",
                                  style: commonTextStyle(18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(snapshot.data!.invoiceNo.toString().substring(8,snapshot.data!.invoiceNo.toString().length),
                                  style: commonTextStyle(60),
                                ),
                
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ispotrait ? size.height * 0.1 : 5,
                          ),
                          TextButton(onPressed: (){
                              controller.clearCartData();
                              Get.to(() => MenuScreen());
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              height: 50,
                              decoration:  const BoxDecoration(
                                gradient: Palette.btnGradientColor,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Palette.btnBoxShadowColor,
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: const Center(
                                child: Text("CONTINUE",
                                      style: TextStyle(
                                      fontFamily: Palette.layoutFont,
                                      fontWeight: Palette.btnFontWeight,
                                      fontSize: Palette.btnFontsize,
                                      color: Palette.btnTextColor,
                                    ),
                                  ),
                                ),
                              ),
                          ),
                          // TextButton(onPressed: (){
                          //     Get.to(() => PrintReportPdf(invoice: snapshot.data!));
                          //     //Get.to(() => PdfPreviewPage(invoice: snapshot.data!));
                          //   },
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width*0.4,
                          //     height: 50,
                          //     decoration:  const BoxDecoration(
                          //       gradient: Palette.btnGradientColor,
                          //       borderRadius: BorderRadius.all(Radius.circular(10)),
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: Palette.btnBoxShadowColor,
                          //           spreadRadius: 5,
                          //           blurRadius: 7,
                          //           offset: Offset(0, 2),
                          //         )
                          //       ],
                          //     ),
                          //     child: const Center(
                          //       child: Text("Report print",
                          //             style: TextStyle(
                          //             fontFamily: Palette.layoutFont,
                          //             fontWeight: Palette.btnFontWeight,
                          //             fontSize: Palette.btnFontsize,
                          //             color: Palette.btnTextColor,
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          // ),

                          TextButton(onPressed: (){
                              Get.to(() => PdfPreviewPage(invoice: snapshot.data!, screen: 'OrderSuccessScreen'));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              height: 50,
                              decoration:  const BoxDecoration(
                                gradient: Palette.btnGradientColor,
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Palette.btnBoxShadowColor,
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 2),
                                  )
                                ],
                              ),
                              child: const Center(
                                child: Text("Report view",
                                      style: TextStyle(
                                      fontFamily: Palette.layoutFont,
                                      fontWeight: Palette.btnFontWeight,
                                      fontSize: Palette.btnFontsize,
                                      color: Palette.btnTextColor,
                                    ),
                                  ),
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else if(snapshot.hasError){
                  return SnackBar( content: Text("${snapshot.error}"),);
                }
                else{
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        );
        
      },
    );

  }
}
