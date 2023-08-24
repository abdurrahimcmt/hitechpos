import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hitechpos/controllers/cart_controller.dart';
import 'package:hitechpos/controllers/customer_and_address_controller.dart';
import 'package:hitechpos/controllers/dini_in_controller.dart';
import 'package:hitechpos/controllers/login_controller.dart';
import 'package:hitechpos/controllers/menu_controller.dart';
import 'package:hitechpos/controllers/proceed_controller.dart';
import 'package:hitechpos/models/customeraddress.dart';
import 'package:hitechpos/models/invoiceinfodetails.dart';
import 'package:hitechpos/models/itemdetails.dart';
import 'package:hitechpos/models/orderlistmodel.dart';
import 'package:hitechpos/views/cart/cart_screen.dart';
import 'package:hitechpos/widgets/loading_prograss_screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class OrderListController extends GetxController{

  final loginController = Get.find<LoginController>();
  final cartController = Get.find<CartController>();
  final proceedController = Get.find<ProceedController>();
  final menuController = Get.find<MenuScreenController>();
  final dineInController = Get.find<DiniInController>();
  final customerAndAddressController = Get.find<CustomerAndAddressController>();

  TextEditingController searchTextEditingController = TextEditingController();
  int scroolNumber = 0;
  int _page = 0;
  int _limit = 15;
  String orderTypes = "all";
  String status = "all";
  String fromDate = "2000-01-01";
  String toDate = DateTime.now().toString();
  String invoiceId = "";
  String invoiceNo = "";
  String searchText = "all";
  final RxBool _isFirstLoadRunning = false.obs;
  final RxBool _hasNextPage = true.obs;
  final RxBool _isloadMoreRunning = false.obs;
  RxList orderList = [].obs;
  late Future<OrderListModel> orderListModel;
  late Future<InvoiceInfoDetails> invoiceInfoDetailsFuture;

  //filter fields
  List<int> listOfStatusId = [];
  List<String> isSelectedDate = [];
  List<int> selectedOrderType = [];
  List<String> selectedStatus = [];
  TextEditingController dateFieldFromDate = TextEditingController();
  TextEditingController dateFieldtoDate = TextEditingController();



  get getIsFirstLoadRunning => _isFirstLoadRunning;
  get getHasNextPage => _hasNextPage;
  get getIsloadMoreRunning => _isloadMoreRunning;
  get getPage => _page;
  get getLimit => _limit;
  get getOrderType => orderTypes;
  get getStatus => status;
  get getfromDate => fromDate;
  get getToDate => toDate;
  get getInvoiceId => invoiceId;
  get getInvoiceNo => invoiceNo;
  get getSearchText => searchText;

  set setSearchText(String searchText){
    this.searchText = searchText;
  }

  set setInvoiceId(String invoiceId){
    this.invoiceId = invoiceId;
  }
  set setInvoiceNo(String invoiceNo){
    this.invoiceNo = invoiceNo;
  }

  set setPage(int pageNumber){
    _page = pageNumber;
  }
  set setLimit(int limitNumber){
    _limit = limitNumber;
  }
  set setOrderTypes(String orderType){
    orderTypes = orderType;
  }
  set setStatus(String orderStatus){
    status = orderStatus;
  }
  set setFromDate(String fdate){
    fromDate = fdate;
  }
  set toToDate(String tdate){
    toDate = tdate;
  }
  
  @override
  void onInit(){
    if(scroolNumber == 0){
      scroolNumber++;
    }
    super.onInit();
    fatchOrderList();
  }

  Future<OrderListModel> fatchOrderList() async {
    _isFirstLoadRunning.value = true;
    await loginController.setBaseUrl();

    String baseurl = loginController.baseurlFromLocalStorage;
    String branchId = loginController.branchIdFromLocalStorage;
    String userId = loginController.userIdFromLocalStorage;

    DateTime todate = DateTime.parse(toDate) ;
    String formattedToDate = DateFormat('yyyy-MM-dd').format(todate);

    DateTime fromdate = DateTime.parse(fromDate) ;
    String formattedFromDate = DateFormat('yyyy-MM-dd').format(fromdate);
    String urlforWhileCard = "${baseurl}api/waiterapp/invoicelist?ordertype=$orderTypes&fromdate=$formattedFromDate&todate=$formattedToDate&status=$status&branchid=$branchId&userid=$userId&offset=$_page&limit=$_limit&search=$searchText";

    final url = Uri.parse(urlforWhileCard);
    debugPrint(url.toString());
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
      debugPrint(response.body);
      _isFirstLoadRunning.value = false;
        return OrderListModel.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Faild to load Order List');
    }
  }

  void loadMore(){
    //debugPrint("Scroll Controller" + _scrollController.position.extentAfter.toString());
      if(_hasNextPage.value == true && 
        _isFirstLoadRunning.value == false && 
        _isloadMoreRunning.value == false
          ){
          _isloadMoreRunning.value = true;
          _page = _page + _limit ;
        
        try {
          orderListModel = fatchOrderList();
          orderListModel.then((value) {
            if(value.invoiceStatusList.isNotEmpty){
              orderList.addAll(value.invoiceStatusList);
            }
            else{
              _hasNextPage.value = false;
            }
          });
        } catch (e) {
          debugPrint("Something went wrong");
        }
        _isloadMoreRunning.value = false;
      }
    
  }

  void firstLoad() async{
    
    try {
      _page =0;
      _limit = 15;
      orderListModel = fatchOrderList();
      orderListModel.then((value) {
        orderList.value = value.invoiceStatusList;
      });
    } catch (e) {
      debugPrint("Something went wrong");
    }
    _isFirstLoadRunning.value = false;
  }

  void loadInvoiceDatafromDatabase(String invoiceId, String invoiceNo) async {
    Get.to(() => const LoadingPrograssScreen());
      try {
        proceedController.refreshProceedController();
        cartController.isDataUpdate = true;
        loginController.setInvoiceId = invoiceId;
        loginController.setInvoiceNo = invoiceNo;
        cartController.cartDetailsModelList.value.clear();
        List< InvoiceDetail> mainItemList = [];
        List< InvoiceDetail> modifierList = [];
        late String tableId;
        late String? floorId = "";
        late String customerId;
        late String fullAddress;
        
        invoiceInfoDetailsFuture = fatchInvoiceInfo(invoiceId);
        invoiceInfoDetailsFuture.then((value) {

          if(value.invoiceInfo.isNotEmpty){

            tableId = value.invoiceInfo.first.vTableId;
            if(floorId != null){
              floorId = value.invoiceInfo.first.vFloorId;
            }
            
            customerId = value.invoiceInfo.first.vCustomerId;
            fullAddress = value.invoiceInfo.first.vCustomerAddress;
            debugPrint("addressId: $fullAddress");
            menuController.selectedOrderType.value = value.invoiceInfo.first.iSalesTypeId - 1;

            if(value.invoiceInfo.first.iSalesTypeId == 1){
              dineInController.setSelectedTableAndFloorfromDatabase(floorId, tableId);
            }

            if(value.invoiceInfo.first.iSalesTypeId == 2 || value.invoiceInfo.first.iSalesTypeId == 3 || value.invoiceInfo.first.iSalesTypeId == 4){
              customerAndAddressController.setCustomerList();
              
              customerAndAddressController.selectedCustomer.value = customerAndAddressController.customerList.singleWhere((element) {
                 return element.vCustomerId == customerId;
              });
              if(value.invoiceInfo.first.iSalesTypeId == 3 || value.invoiceInfo.first.iSalesTypeId == 4){
                  customerAndAddressController.setCustomerAddressList(customerAndAddressController.selectedCustomer.value.vCustomerId);
                  Timer(const Duration(seconds: 2), () { 

                    customerAndAddressController.selectedCustomerAddress = customerAndAddressController.customerAddressList.firstWhere(
                      (element) => customerAndAddressController.combinedCustomerAddressFields(element) == fullAddress,
                      orElse: () => CustomerAddressList(vCustomerId: "", vAddId: "", vArea: "", vBuildingNo: "", vFlatNo: "", vBlockNo: "", vRoadNo: ""),
                    );
                    // customerAndAddressController.selectedCustomerAddress = customerAndAddressController.customerAddressList.singleWhere((element) {
                    //   return customerAndAddressController.combinedCustomerAddressFields(element)  == fullAddress;
                    // });
                });
              }
              if(value.invoiceInfo.first.iSalesTypeId == 4){
                customerAndAddressController.carNumberController.text = value.invoiceInfo.first.vCarNumber;
              }
            }

            proceedController.selectedTableForParam = value.invoiceInfo.first.vTableId;
            proceedController.customerId = value.invoiceInfo.first.vCustomerId;
            proceedController.customerAddress = value.invoiceInfo.first.vCustomerAddress;
            proceedController.carNumber = value.invoiceInfo.first.vCarNumber;

            for(int i = 0;i < value.invoiceInfo.first.invoiceDetails.length; i ++){

              InvoiceDetail invoicedetail = value.invoiceInfo.first.invoiceDetails[i];
              List<String> listOfString = [];
              String modifierId = '';
              String itemExtraPrefex = '';
              if(invoicedetail.vItemExtra.contains("#")){
                listOfString = invoicedetail.vItemExtra.split('#');
              }
              if(listOfString.isNotEmpty){
                debugPrint("String List $listOfString");
                itemExtraPrefex = listOfString[0];
                modifierId = listOfString[1];
              }
              if(modifierId == invoicedetail.vItemId){
                debugPrint("Main Item ${invoicedetail.vItemId}");
                mainItemList.add(invoicedetail);
              }
              else{
                modifierList.add(invoicedetail);
              }

            }
            for(InvoiceDetail invoicedetail in mainItemList){
              List<OnlineModifierList> onlineModifierList = []; 

              List<InvoiceDetail> modifierListOfThisItem = modifierList.where((element) {
                  String modifierId = '';
                  String itemExtraPrefex = '';
                  List<String> listOfString = [];
                  if(element.vItemExtra.contains("#")){
                    listOfString = element.vItemExtra.split('#');
                  }
                  if(listOfString.isNotEmpty){
                    debugPrint("String List $listOfString");
                    itemExtraPrefex = listOfString[0];
                    modifierId = listOfString[1];
                  }
                return modifierId == invoicedetail.vItemId;
              }).toList();

              for(InvoiceDetail item in modifierListOfThisItem){
                onlineModifierList.add(
                  OnlineModifierList(
                    vItemIdModifier: item.vItemId, 
                    vItemName: item.vItemName, 
                    iUnitId: item.vUnitId, 
                    vUnitName: item.vUnitName, 
                    vQuantity: item.mQuantity.toString(), 
                    vMainPrice: item.mMainPrice.toString(), 
                    mQuantity: item.mQuantity.toDouble(), 
                    mMainPrice: item.mMainPrice,
                    mVatAmount: item.mTotalVatAmount/item.mQuantity.toDouble(), 
                    mWoVatAmount: item.mAmountWithoutVat/item.mQuantity.toDouble(), 
                    mFinalPrice: item.mFinalPrice, 
                    vVatCatId: item.vVatCatId, 
                    vVatOption: item.vVatOption, 
                    mPercentage: item.mDisPercent)
                );
              }
              cartController.addToCart(
                invoicedetail.vItemId, 
                invoicedetail.vItemName, 
                invoicedetail.mQuantity, 
                invoicedetail.mFinalPrice, 
                invoicedetail.mMainPrice, 
                invoicedetail.mDisAmount, 
                invoicedetail.vVatCatId, 
                invoicedetail.vVatOption, 
                invoicedetail.mVatPercent, 
                invoicedetail.vUnitId,
                invoicedetail.vUnitName,
                invoicedetail.mMainPrice,
                invoicedetail.mTotalVatAmount/invoicedetail.mQuantity.toDouble(), 
                invoicedetail.mAmountWithoutVat/invoicedetail.mQuantity.toDouble(),
                onlineModifierList, 
                invoicedetail.vKitchenNote, 
                invoicedetail.vInvoiceNote
              );
            }
          }
          else{
            _hasNextPage.value = false;
          }
        });

        Timer(const Duration(seconds: 2), () {
          debugPrint(cartController.cartDetailsModelList.value.length.toString());
          Get.to(() => const CartScreen());
         });
      }
      catch (e) {
        debugPrint("Something went wrong");
      }
  }

  Future<InvoiceInfoDetails> fatchInvoiceInfo(String invoiceId) async {
    String baseurl = loginController.baseurlFromLocalStorage;
    final url = Uri.parse("${baseurl}api/waiterapp/invoicedetails?invoiceid=$invoiceId");
    debugPrint(url.toString());
    final headers = {
      'Key': loginController.registrationKeyFromLocalStorage.toString(),
      'Content-Type': 'application/json',
    };
    final response = await http.get(url,headers: headers);
    if(response.statusCode == 200){
        debugPrint(response.body);
        return InvoiceInfoDetails.fromJson(jsonDecode(response.body));
    }
    else{
      throw Exception('Failed to load Category');
    }
  }

}