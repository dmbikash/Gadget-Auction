

import 'package:app_ebay/screens/home/drawer.dart';
import 'package:app_ebay/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:app_ebay/services/storage_service.dart';
import 'package:app_ebay/controllers/data_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class BidItems extends StatefulWidget {
  //const BidItems({Key? key}) : super(key: key);
  final DataController controller =Get.put(DataController()) ;

  @override
  _BidItemsState createState() => _BidItemsState();
}

class _BidItemsState extends State<BidItems> {

   bool loading =false;

  dynamic userdata = {};




  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    userdata = ModalRoute.of(context)!.settings.arguments;
    print('--------------------------');
    print(userdata);

    return loading? Loading() :Scaffold(
      drawer:AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[500],
        title: Text('Auction Gallery'),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {

                });
                setState(() {
                  loading=true;
                });
                await Future.delayed(const Duration(seconds: 2), (){});
                setState(() {
                  loading=false;
                });


                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Page refreshed')),
                );

              },
              icon: Icon(Icons.refresh_outlined))
        ],
      ),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.allProduct.isEmpty
            ? Center(
          child: Text('😔 NO DATA FOUND (: 😔'),
        )
            : ListView.builder(
          itemCount: controller.allProduct.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      controller.allProduct[index].productimage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            "Product Name: ${controller.allProduct[index].productname}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Align(
                          alignment:Alignment.centerLeft,
                          child: Text(
                            'Minimum bid Price: ${controller.allProduct[index].productprice.toString()}',
                            style: TextStyle(fontWeight: FontWeight.bold,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style:  ElevatedButton.styleFrom(primary:Colors.teal[300] ),
                            onPressed: () {
                              if(controller.allProduct[index].product_status == 'pending'){
                                print("xxxxxxxx----------@@@@@@@@@@@@");
                                print(controller.allProduct[index]);
                                print(controller.userProfileData['userName']);
                                Navigator.pushNamed(context, '/bidpage',arguments:
                                {
                                  "product_name":controller.allProduct[index].productname,
                                  "bid_price":controller.allProduct[index].productprice.toString(),
                                  'img':controller.allProduct[index].productimage,
                                  'description':controller.allProduct[index].description,
                                  'auc_date':controller.allProduct[index].auc_date,
                                  'product_owner_email':controller.allProduct[index].product_owner_email,
                                  'bidder_name':controller.userProfileData['userName'],
                                  'product_id':controller.allProduct[index].productId,


                                });

                              }else{
                                Navigator.pushNamed(context, '/winner',arguments:
                                {
                                  "product_name":controller.allProduct[index].productname,
                                  //"bid_price":controller.allProduct[index].productprice.toString(),
                                  'img':controller.allProduct[index].productimage,
                                  //'description':controller.allProduct[index].description,
                                  //'auc_date':controller.allProduct[index].auc_date,
                                  //'product_owner_email':controller.allProduct[index].product_owner_email,
                                  //'bidder_name':controller.userProfileData['userName'],
                                  'product_id':controller.allProduct[index].productId,


                                });

                              }
                            },
                            //=> launch(
                            //    "tel:${controller.allProduct[index].phonenumber.toString()}"),
                            child: Text('Bid this product',
                            style:TextStyle(
                              fontSize: 17,
                            ),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
     floatingActionButton: FloatingActionButton(

       onPressed: ()
       {
         Navigator.pushNamed(context, "/add_product");
       },
       backgroundColor: Colors.teal[500],
       child: const Icon(Icons.add),

     ),


    );

  }
}