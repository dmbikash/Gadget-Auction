/*

import 'package:flutter/material.dart';
import 'package:app_ebay/screens/authenticate/sign_in.dart';
import 'package:app_ebay/screens/authenticate/register.dart';


class Authenticate extends StatefulWidget {
  //const Authenticate({Key? key}) : super(key: key);
  //Authenticate instance= Authenticate();

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn =true;
 void toggleView(){
  setState(()=>showSignIn=!showSignIn);
 }
  @override
  Widget build(BuildContext context) {

    if(showSignIn){

      return SignIn(toggleView:toggleView);
    }else{
      //print("hehe");
      return Register(toggleView:toggleView);
    }
  }
}

*/