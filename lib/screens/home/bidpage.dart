import 'package:flutter/material.dart';

class Bidpage extends StatefulWidget {
  //const Bidpage({Key? key}) : super(key: key);

  @override
  _BidpageState createState() => _BidpageState();
}

class _BidpageState extends State<Bidpage> {
  dynamic userdata = {};




  @override
  Widget build(BuildContext context) {
    userdata = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Image Demo'),
        backgroundColor: Colors.teal[400],
      ),
      body: Center(
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
              'BId Price :  ${userdata['auc_price'] }',
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
          ],
        ),
      ),
    ) ;
  }
}
