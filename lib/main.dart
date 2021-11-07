import 'package:app_ebay/screens/home/bidpage.dart';
import 'package:app_ebay/screens/home/user_product.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_ebay/services/auth.dart';
import 'package:app_ebay/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:app_ebay/screens/home/display_items.dart';
import 'package:app_ebay/screens/home/home.dart';

import 'model/add_product.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>ChangeNotifierProvider(
      create: (context) =>GoogleSignInProvider(),
      child:MaterialApp(
        routes:{
          '/bidpage': (context )=>Bidpage(),
          "/wrapper":(context)=>Wrapper(),
          "/home":(cotext)=>Home(),
          "/display_items_and_bid":(context)=>BidItems(),
          "/add_product":(context)=>AddProdusctScreen(),
          '/myProduct':(context) =>UserProduct(),
        },
      debugShowCheckedModeBanner:false,
    //title:title,
      home: Wrapper(),
    ),
  );
}

