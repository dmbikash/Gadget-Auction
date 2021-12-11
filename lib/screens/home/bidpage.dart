import 'package:app_ebay/controllers/data_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';


class Bidpage extends StatefulWidget {
  //final DataController controller =Get.find() ;
  //const Bidpage({Key? key}) : super(key: key);

  @override
  _BidpageState createState() => _BidpageState();
}

class _BidpageState extends State<Bidpage> {

  dynamic userdata = {};
  DataController controller =Get.find();

  var yaho ;

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> bidData = {  //productData

    "bid_price": "",
    "product_owner_email":"",
    "bidder_name":"",
    "product_id":"",
  };

  // auction date formatting
  String dateFormatting( Timestamp receiver){
    //print("------z-z-z--z-z-z-z-z-z-z-z-");
    DateTime  date=receiver.toDate();
    String formattedDate = DateFormat.yMMMEd().format(date);

    return formattedDate;
  }

  addBid() {


    if (bidData['bid_price'] != null) {
      print("Form is valid1 ");
      print(bidData['bid_price']);
      _formKey.currentState!.save();
      print("Form is valid2 ");
      if (_formKey.currentState!.validate()) {
        print("Form is valid3 ");


        print('Data for bid data $bidData');

        controller.addBidPrice(bidData);///// ekhane khela hobee

      }else print("ekhane gorbor..bid price upload hochhena");
    }else return;
  }




  @override
  Widget build(BuildContext context) {
    userdata = ModalRoute.of(context)!.settings.arguments;
    bidData["product_owner_email"]=userdata['product_owner_email'];
    bidData["bidder_name"]=userdata['bidder_name'];
    bidData['product_id']=userdata['product_id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Bid Page'),
        backgroundColor: Colors.teal[400],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height:20,
              ),
              SizedBox(
                  child: Image.network('${userdata['img']}'),
              height:300,
                width:500,

              ),
              SizedBox(
                height:20,
              ),

              Text(
                'Product Name: ${userdata['product_name']}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                height:10,
              ),
              Text(
                'Minimum BId Price :  ${userdata['bid_price'] }',
                style: TextStyle(fontSize: 20.0,color: Colors.red[800]),
              ),
              SizedBox(
                height:10,
              ),
              Text(
                'Last date of Bidding :  ${dateFormatting(userdata['auc_date'])}',
                style: TextStyle(fontSize: 20.0,color: Colors.red[800]),
              ),
              SizedBox(
                height:10,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Description:  ${userdata['description'] }',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              SizedBox(
                height:10,
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal:5, vertical: 5),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Enter your Bid Price',
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                            width: 4.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.teal,
                          width: 4.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty ) {
                        return 'Please enter a valid Bidding Price';
                      }else{
                        int bid= int.parse(value) ;
                        print(userdata['bid_price'].runtimeType);
                        double temp=double.parse(userdata['bid_price']);
                        int min_bid=temp.round();
                        if(bid<min_bid){
                          return 'Bid Price Can not be less that minimum bid price';
                        }

                      }
                      return null;
                    },
                    onSaved: (value) {
                      bidData['bid_price'] = value!;
                      print("printing bid pprice");
                      print(value);
                    },
                  ),
                ),
              ),
              ElevatedButton(
                      onPressed:(){
                       // Validate returns true if the form is valid, or false otherwise.
                       if (_formKey.currentState!.validate()) {
                           // If the form is valid, display a snackbar. In the real world,
                           addBid();
                         //Navigator.pushNamed(context, "/display_items_and_bid");
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                           );
                       }

                } ,
              //
                child: Text('Submit'),
                style:ElevatedButton.styleFrom(
                  primary:Colors.teal[400],
                  padding: EdgeInsets.symmetric(horizontal:35, vertical: 5),
                  //onPrimary: Colors.yellow[200],
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
              SizedBox(
                height:10
              ),
              ElevatedButton(
                onPressed:(){
                  //addBid();
                  Navigator.pushNamed(context, "/bidlist", arguments:
                  {
                    "product_owner_email": userdata['product_owner_email'],
                    "product_id":userdata['product_id'],

                  });
                } ,
                //
                child: Text('Show bid list'),
                style:ElevatedButton.styleFrom(
                  primary:Colors.teal[400],
                  padding: EdgeInsets.symmetric(horizontal:20, vertical:5),
                  //onPrimary: Colors.yellow[200],
                  textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0),
                  ),
                ),
              ),
              SizedBox(
                height:40,
              ),
            ],
          ),
        ),
      ),
    ) ;
  }
}
