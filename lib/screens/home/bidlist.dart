


import 'package:app_ebay/controllers/data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Bidlist extends StatefulWidget {
  @override
  State<Bidlist> createState() => _BidlistState();

}

class _BidlistState extends State<Bidlist> {
  final DataController controller = Get.find();
  dynamic userdata = {};



  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      await controller.getBidList(userdata['product_id']);
      print("bid data pathano hochhe data controller e");

      print(userdata);
      print("userdata");


    });

    userdata = ModalRoute.of(context)!.settings.arguments;

    print('received userdata-------${userdata}');

    setState(() {});

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight:100,
        title:Column(
          children: [
            Text('THE BIDDING TABLE ' ,style:TextStyle( fontSize: 25,)),
           // Text('Top Bidder'),
            //Text('${controller.winner_name}'),
            //Text('BID PRICE: ${controller.winner_bid} BDT'),


        ],

        ) ,

        backgroundColor: Colors.teal,

      ),

      body: GetBuilder<DataController>(
        builder: (controller) => controller.allBidInfo.isEmpty
            ? Center(
          child: Text('😔 NO Bidding yet 😔'),
        )
            : ListView.builder(
          itemCount: controller.allBidInfo.length,
          itemBuilder: (context, index) {
            return Card(
                color: Colors.grey[200],
              margin:  const EdgeInsets.only(top:10.0, right:10,left:10),
              child: Column(
                children: [

                  Container(
                    height: 10,
                    width: double.infinity,
                    child: Text(""),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Bidder Name: ${controller.allBidInfo[index].bidder_name}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price: ${controller.allBidInfo[index].bid_price}',

                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //ElevatedButton(
                        //onPressed: () {
                        // editProduct(
                        //  controller.loginUserData[index].productId,
                        //  controller
                        //     .loginUserData[index].productprice,
                        // );
                        //  },
                        //    child: Text('Edit'),
                        //   ),
                        //   ElevatedButton(
                        //   onPressed: () {
                        // controller.deleteProduct(controller
                        // .loginUserData[index].productId);
                        //  },
                        //   child: Text('Delete'),
                        //  ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white,


    );
  }
}
