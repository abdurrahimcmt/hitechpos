import 'dart:async';

import 'package:get/get.dart';
import 'package:hitechpos/controllers/orderlist_controller.dart';
import 'package:hitechpos/views/dashboard/dashboard_screen.dart';
import 'package:hitechpos/views/order/orderfilter.dart';
import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  
  final orderListController = Get.find<OrderListController>();
  TextStyle textStyle = const TextStyle(fontFamily: Palette.layoutFont,fontSize: 12,fontWeight: FontWeight.w600,);
  TextStyle rowTextStyle = const TextStyle(fontFamily: Palette.layoutFont,fontSize: 10,fontWeight: FontWeight.w500,);
  // bool _isFirstLoadRunning = false;
  // bool _hasNextPage = true;
  // bool _isloadMoreRunning = false;
  // List<InvoiceStatusList> orderList = [];
  // late ScrollController _scrollController;
  // late Future<OrderListModel> orderListModel;
  @override
  void initState(){
    Timer(const Duration(seconds: 1), () {
      orderListController. firstLoad();
     });
    super.initState();
  }
  //final DataTableSource _data = OrderDataTable();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Order List"),
          centerTitle: true,
          backgroundColor: Palette.bgColorPerple,
          leading: GestureDetector(
            onTap: () {
              Get.to(() => const DashboardScreen());
            },
            child: const Icon(Icons.arrow_back),
          ),
          actions: [
            TextButton(
              onPressed: (){
                //_buildModelBottomSheet();
                Get.to(() => const OrderFilterScreen());
              }, 
              child: const Image(image: AssetImage("assets/images/filterIcon.png"),height: 25,)
              ),
          ],
        ),
        body:  orderListController.getIsFirstLoadRunning.value ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
        //body: SingleChildScrollView(
          child: Container(
            height: size.height-80,
            decoration: const BoxDecoration(
              gradient: Palette.bgGradient,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  //search bar
                  TextField(
                    controller: orderListController.searchTextEditingController,
                    onEditingComplete: () {
                      if(orderListController.searchTextEditingController.text.isNotEmpty){
                          orderListController.setSearchText = orderListController.searchTextEditingController.text;
                          orderListController.firstLoad();
                        }
                      else{
                          orderListController.setSearchText = "all";
                          orderListController.firstLoad();
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical:1.0, horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(width: 0.5),
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            orderListController.setSearchText = "all";
                            orderListController.firstLoad();
                            orderListController. searchTextEditingController.text = "";
                          },
                          icon: const Icon(
                          Icons.clear,
                          size: 20,
                        ),
                      ),
                      hintText: "Search here",
                      filled: true,
                      fillColor: const Color.fromARGB(255, 237, 227, 238),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 0.5,
                          color: Palette.iconBackgroundColorPurple,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: ListView(
                      controller: orderListController.getScrollController,
                      children: [
                        DataTable(
                          headingRowHeight: 50,
                          //border: TableBorder.all(width: 1,color: Palette.fontBgGray),
                          columnSpacing: 10,
                          dataTextStyle: const TextStyle(
                                fontFamily: Palette.layoutFont,
                                fontSize: Palette.contentTitleFontSize,
                                color: Colors.black
                              ),
                          dividerThickness: 0,
                          headingTextStyle: const TextStyle(
                                fontFamily: Palette.layoutFont,
                                fontSize: Palette.contentTitleFontSize,
                                color: Colors.black
                              ),
                            
                          columns: <DataColumn>[
                            DataColumn(
                              label: SizedBox(
                                width: 60,
                                child: Text("Invoice No",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: textStyle,
                                ),
                              )
                            ),
                            DataColumn(
                              label: SizedBox(
                                  width: 70,
                                  child: Text("Order Type",
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: textStyle,
                                ),
                              )
                            ),
                            DataColumn(label: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 60),
                              child: Text("Customer",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: textStyle,
                                ),
                              )              
                            ),
                            DataColumn(label: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 50),
                              child: Text("Amount",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: textStyle,
                              ),
                            )),
                            DataColumn(label: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 80),
                              child: Text("Invoice Time",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: textStyle,
                              ),
                            )),
                            DataColumn(label: ConstrainedBox(
                              constraints: const BoxConstraints(minWidth: 50),
                              child: Text("Status",
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: textStyle,
                              ),
                            ))
                          ],
                          rows: List<DataRow>.generate(
                            orderListController.orderList.length,
                            (index) => DataRow(
                              onLongPress: () {
                                debugPrint(orderListController. orderList[index].vInvoiceNo);
                                orderListController.loadInvoiceDatafromDatabase(orderListController.orderList[index].vInvoiceId,orderListController.orderList[index].vInvoiceNo);
                              },
                              mouseCursor: MaterialStateMouseCursor.clickable,
    
                              cells: <DataCell>[
                                DataCell(
                                  ConstrainedBox(
                                  constraints: const BoxConstraints(minWidth: 60),
                                  child: Text(orderListController. orderList[index].vInvoiceNo,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: rowTextStyle,
                                  )),
                                ),
                                DataCell(
                                  ConstrainedBox(
                                  constraints: const BoxConstraints(minWidth: 70),
                                  child: Text(orderListController. orderList[index].vSalesType,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: rowTextStyle,
                                  )),
                                ),                  
                                DataCell(
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: 60),
                                    child: Text(orderListController. orderList[index].vCustomerName,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: rowTextStyle,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: 50),
                                    child: Text(orderListController. orderList[index].mTotalAmount.toStringAsFixed(3),
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: rowTextStyle,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: 80),
                                    child: Text(orderListController. orderList[index].vInvoiceDate,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: rowTextStyle,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  ConstrainedBox(
                                    constraints: const BoxConstraints(minWidth: 50),
                                    child: Text(orderListController. orderList[index].vStatus,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontFamily: Palette.layoutFont,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        //1 pending //2 Settle //3 Cancel
                                        color:orderListController. orderList[index].vStatusId == "1" ? Colors.orangeAccent
                                        : orderListController. orderList[index].vStatusId == "2"? Colors.greenAccent
                                        : orderListController. orderList[index].vStatusId == "3"?Colors.redAccent : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if(orderListController.getIsloadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  if(orderListController.getHasNextPage == false)
                  const Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    child: Center(
                      child: Text("That's All"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  _buildModelBottomSheet(){
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40),
        )
      ), 
      builder: (BuildContext context) { 
          return const OrderFilterScreen();
      },
    );
  }
  // Future<OrderListModel> fatchOrderList(String orderType, String status, String fromDate, String toDate,) async {
  //   await loginController.setBaseUrl();
  //   String baseurl = loginController.baseurlFromLocalStorage;
  //   String branchId = loginController.branchIdFromLocalStorage;
  //   String userId = loginController.userIdFromLocalStorage;
  //   DateTime todate = DateTime.parse(toDate) ;
  //   String formattedToDate = DateFormat('yyyy-MM-dd').format(todate);
  //   DateTime fromdate = DateTime.parse(fromDate) ;
  //   String formattedFromDate = DateFormat('yyyy-MM-dd').format(fromdate);
  //   final url = Uri.parse("${baseurl}api/waiterapp/invoicelist?ordertype=$orderType&fromdate=$formattedFromDate&todate=$formattedToDate&status=$status&branchid=$branchId&userid=$userId&offset=$_page&limit=$_limit");
  //   debugPrint(url.toString());
  //   final headers = {
  //     'Key': loginController.registrationKeyFromLocalStorage.toString(),
  //     'Content-Type': 'application/json',
  //   };
  //   final response = await http.get(url,headers: headers);
  //   if(response.statusCode == 200){
  //       return OrderListModel.fromJson(jsonDecode(response.body));
  //   }
  //   else{
  //     throw Exception('Faild to load Order List');
  //   }
  // }

  // void _loadMore() async{
  //   if(_hasNextPage == true && 
  //      _isFirstLoadRunning == false && 
  //      _isloadMoreRunning == false &&
  //      _scrollController.position.extentAfter < 300
  //       ){
  //     setState(() {
  //       _isloadMoreRunning = true; // Display a progress indicator at the bottom
  //     });
  //     orderListController.setPage(orderListController.getPage() + orderListController.getLimit()) ;
  //     try {
        
  //       orderListModel = orderListController.fatchOrderList("%", "%", '2000-01-01', DateTime.now().toString());
  //       orderListModel.then((value) {
  //         if(value.invoiceStatusList.isNotEmpty){
  //           setState(() {
  //             orderList.addAll(value.invoiceStatusList);
  //           });
  //         }
  //         else{
  //           setState(() {
  //             _hasNextPage = false;
  //           });
  //         }
  //       });
  //     } catch (e) {
  //       if(kDebugMode){
  //         print("Something went wrong");
  //       }
  //     }
  //     setState(() {
  //       _isloadMoreRunning = false;
  //     });
  //   }
  // }

  // void _firstLoad() async{
  //   setState(() {
  //     _isFirstLoadRunning = true;
  //   });
  //   try {
  //     orderListModel = orderListController.fatchOrderList("%", "%", '2000-01-01', DateTime.now().toString());
  //     orderListModel.then((value) {
  //       setState(() {
  //         orderList = value.invoiceStatusList;
  //       });
  //     });
  //   } catch (e) {
  //     if(kDebugMode){
  //       print("Something went wrong");
  //     }
  //   }
  //   setState(() {
  //     _isFirstLoadRunning = false;
  //   });
  // }
}
