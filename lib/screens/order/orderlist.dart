import 'dart:convert';
import 'dart:math';
import 'package:hitechpos/screens/menu/component/dine_in.dart';
import 'package:hitechpos/screens/order/orderfilter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hitechpos/common/palette.dart';
import 'package:hitechpos/models/postdemo.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  // late Future<Postdemo> postDemoList;
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  // int _page = 0;
  // final int _limit = 20;
  // bool _isFirstLoadRunning = false;
  // bool _hasNextPage = true;
  // bool _isloadMoreRunning = false;
  // List _posts = []; 
  //  late ScrollController _controller;
  // void _loadMore() async{
  //   if(_hasNextPage == true && 
  //      _isFirstLoadRunning == false && 
  //      _isloadMoreRunning == false &&
  //      _controller.position.extentAfter < 300
  //       ){
  //     setState(() {
  //       _isloadMoreRunning = true; // Display a progress indicator at the bottom
  //     });

  //     _page += 1;
      
  //     try {
  //       final res = 
  //       await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
  //       final List fetchedPosts = json.decode(res.body);
  //       if(fetchedPosts.isNotEmpty){
  //         setState(() {
  //           _posts.addAll(fetchedPosts);
  //         });
  //       }
  //       else{
  //         setState(() {
  //           _hasNextPage = false;
  //         });
  //       }
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
  //     final res = await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
  //     setState(() {
  //       _posts = json.decode(res.body);
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

  void initState(){
    super.initState();
    // _firstLoad();
    // _controller = ScrollController()..addListener(_loadMore);
  }
  final DataTableSource _data = OrderDataTable();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order List"),
        centerTitle: true,
        backgroundColor: Palette.bgColorPerple,
        actions: [
          TextButton(
            onPressed: (){
              _buildModelBottomSheet();
            }, 
            child: const Image(image: AssetImage("assets/images/filterIcon.png"),height: 25,)
            ),
        ],
      ),
      //body: _isFirstLoadRunning? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
      body: SingleChildScrollView(
        child: Container(
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
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical:1.0, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(width: 0.5),
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 20,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                        Icons.clear,
                        size: 20,
                      ),
                    ),
                    hintText: "Search here",
                    filled: true,
                    fillColor: Color.fromARGB(255, 237, 227, 238),
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
                PaginatedDataTable(
                  columns: const [
                    DataColumn(label: Text("Invoice No")),
                    DataColumn(label: Text("Customer")),
                    DataColumn(label: Text("Amount")),
                    DataColumn(label: Text("Invoice Time")),
                    DataColumn(label: Text("Status"))
                  ], 
                  source: _data,
                ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: _posts.length,
                //     controller: _controller,
                //     itemBuilder: (_,index) =>Card(
                //       margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                //       child: ListTile(
                //         title: Text(_posts[index]['title']),
                //         subtitle: Text(_posts[index]['body']),
                //       ),
                //     ),
                //   ),
                // ),
                // if(_isloadMoreRunning == true)
                // const Padding(
                //   padding: EdgeInsets.only(top: 10,bottom: 40),
                //   child: Center(
                //     child: CircularProgressIndicator(),
                //   ),
                // ),
                // if(_hasNextPage == false)
                // const Padding(
                //   padding: EdgeInsets.only(top: 10,bottom: 40),
                //   child: Center(
                //     child: Text("That's All"),
                //   ),
                // ),
              ],
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
}



class OrderDataTable extends DataTableSource {
  
  final List<Map<String,dynamic>> _data = List.generate(
    200, 
    (index) => {
      "invoiceno": index,
      "customer": "Item $index",
      "amount": Random().nextInt(10000),
      "Invoicedate": "2023-03-23",
      "status": "Pending"
    });
  @override
  DataRow? getRow(int index) {
    return DataRow(cells:[
       DataCell(Text(_data[index]['invoiceno'].toString())),
       DataCell(Text(_data[index]['customer'])),
       DataCell(Text(_data[index]['amount'].toString())),
       DataCell(Text(_data[index]['Invoicedate'].toString())),
       DataCell(Text(_data[index]['status'].toString()))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}

// Future<Postdemo> fatchPostDemoList() async {
//   final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
//   if(response.statusCode == 200){
//       return Postdemo.fromJson(jsonDecode(response.body));
//   }  
//   else{
//     throw Exception('Failed to load Category');
//   }
// }