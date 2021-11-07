
import 'package:app_ebay/model/add_product.dart';
import 'package:app_ebay/screens/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:app_ebay/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:app_ebay/controllers/data_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class BidItems extends StatefulWidget {
  //const BidItems({Key? key}) : super(key: key);
  final DataController controller =Get.put(DataController()) ;

  @override
  _BidItemsState createState() => _BidItemsState();
}

class _BidItemsState extends State<BidItems> {


  dynamic userdata = {};




  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    userdata = ModalRoute.of(context)!.settings.arguments;
    print('--------------------------');
    print(userdata);

    return Scaffold(
      drawer:AppDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal[500],
        title: Text('Auction Page'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add_product");
              },
              icon: Icon(Icons.add))
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Product Name: ${controller.allProduct[index].productname}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Minimum bid Price: ${controller.allProduct[index].productprice.toString()}',
                          style: TextStyle(fontWeight: FontWeight.bold,),
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
                            style:  ElevatedButton.styleFrom(primary:Colors.teal[400] ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/bidpage',arguments:
                              {
                                "product_name":controller.allProduct[index].productname,
                                "auc_price":controller.allProduct[index].productprice.toString(),
                                'img':controller.allProduct[index].productimage,
                                'description':controller.allProduct[index].description,

                              });
                            },
                            //=> launch(
                            //    "tel:${controller.allProduct[index].phonenumber.toString()}"),
                            child: Text('Bid this product'),
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



    );
  }
}