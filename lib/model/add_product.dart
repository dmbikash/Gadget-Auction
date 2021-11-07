

import 'dart:async';
import 'dart:io';


import 'package:app_ebay/controllers/data_controller.dart';
import 'package:app_ebay/model/product_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';

class AddProdusctScreen extends StatefulWidget {
  const AddProdusctScreen({Key? key}) : super(key: key);

  @override
  _AddProdusctScreenState createState() => _AddProdusctScreenState();
}

class _AddProdusctScreenState extends State<AddProdusctScreen> {

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        productData['auc_date']=selectedDate;
      });
  }





  DataController controller =Get.find();

  var userImageFile ;

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> productData = {
    "p_name": "",
    "auc_price": "",
    "p_upload_date": DateTime.now().millisecondsSinceEpoch,
    "description": "",
    "auc_date":'',
  };
  void _pickedImage(File image) {
    userImageFile = image;
    print("image paisi yyyyeeeeee------------------------------");
    print('image paisi $userImageFile');


  }


  addProduct() {


    if (userImageFile != null) {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        print("Form is vaid ");


        print('Data for product $productData');
        controller.addNewProduct(productData, userImageFile);
      }
    }else return;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[800],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add New Product'),
        backgroundColor: Colors.teal[800],
      ),
      body: Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_name'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Minimum Bid Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Price Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['auc_price'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'descriptionn  Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['description'] = value!;
                  },
                ),


                RaisedButton(
                  onPressed: ()=> _selectDate(context),
                  child: Text('Select Auction End date'),
                ),



                 SizedBox(
                  width: 200.0,
                  height: 30.0,
                  child: Card(child: Text('Date picked :  ${(selectedDate)} ')),
                ),

                SizedBox(
                  height: 30,
                ),

                Product_image_picker(_pickedImage),

                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: addProduct,
                  child: Text('Submit'),
                  style:ElevatedButton.styleFrom(
                    primary:Colors.teal[400],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    ;
  }


}
