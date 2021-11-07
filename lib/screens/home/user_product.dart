


import 'package:app_ebay/controllers/data_controller.dart';
import 'package:app_ebay/screens/home/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class UserProduct extends StatelessWidget {
  final DataController controller = Get.find();




  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      controller.getLoginUserProduct();
    });



    return Scaffold(
      appBar: AppBar(
        title:Text('My uploaded products'),
        backgroundColor: Colors.teal,
      ),
      body: GetBuilder<DataController>(
        builder: (controller) => controller.loginUserData.isEmpty
            ? Center(
          child: Text('😔 NO DATA FOUND PLEASE ADD DATA 😔'),
        )
            : ListView.builder(
          itemCount: controller.loginUserData.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.network(
                      controller.loginUserData[index].productimage,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Product Name: ${controller.loginUserData[index].productname}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price: ${controller.loginUserData[index].productprice.toString()}',
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
    );
  }
}
