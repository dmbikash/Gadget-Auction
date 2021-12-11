import 'package:app_ebay/controllers/data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class Winner extends StatefulWidget {
  const Winner({Key? key}) : super(key: key);

  @override
  _WinnerState createState() => _WinnerState();
}

class _WinnerState extends State<Winner> {
  dynamic userdata = {};
  DataController controller =Get.find();


  var yaho ;

 //function
  //var
  //map






  @override
  Widget build(BuildContext context) {
    userdata = ModalRoute.of(context)!.settings.arguments;
    controller.getBidList(userdata['product_id']);
    //var
    return Scaffold(
      appBar: AppBar(
        title: Text('Winner Winner Chicken Dinner'),
        backgroundColor: Colors.teal[400],
        /*actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh_outlined))
        ],

         */
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
                height:40,
              ),
              Text(
                'Product Name: ${userdata['product_name']}',
                style: TextStyle(fontSize: 22.0),
              ),

              SizedBox(
                height:40,
              ),
              ElevatedButton.icon(
                onPressed:()
                {
                  setState(() {});
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.white,
                        height: 250,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height:40,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '  Sold To:  ${controller.winner_name }',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),



                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '  Sold at:  ${controller.winner_bid }',
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              ElevatedButton.icon(
                                onPressed:
                                    () => Navigator.pop(context)
                                ,
                                icon: Icon(Icons.check_circle_rounded ),
                                label: Text("Go Back"),
                                style: ElevatedButton.styleFrom(
                                  primary:Colors.teal[400],

                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },





                icon: Icon(Icons.celebration_outlined),
                label: Text('See Winner'),
                style: ElevatedButton.styleFrom(
                  primary:Colors.teal[400],
                  padding: EdgeInsets.symmetric(horizontal:30, vertical: 15),
                  //onPrimary: Colors.yellow[200],
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),


                ),
              ),


              SizedBox(
                height:10,
              ),



            ],
          ),
        ),
      ),
    ) ;
  }
}
