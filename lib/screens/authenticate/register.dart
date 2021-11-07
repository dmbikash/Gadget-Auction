import 'package:flutter/material.dart';
import 'package:app_ebay/services/auth.dart';
//import 'package:ebay_bikash/screens/authenticate/authenticate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';


class Register extends StatefulWidget {
  //const Register({Key? key}) : super(key: key);
  //final Function  toggleView;
  //Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey=GlobalKey<FormState>();
  String email='';
  String password="";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        elevation: 0,
        title: Text("Register to Ebay_Bikash"),
        actions:<Widget> [

        ],

      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          key: _formKey,

          child: Column(
            children: <Widget>[
              SizedBox(height: 210,),



              SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: () {
                  final provider=
                  Provider.of<GoogleSignInProvider>(context,listen:false);
                  provider.googleLogin();


                },
                icon:FaIcon(FontAwesomeIcons.google,color:Colors.white),
                style: ElevatedButton.styleFrom(
                  primary:Colors.teal[600],
                  onPrimary: Colors.black,
                  minimumSize: Size(double.infinity,50),
                ),

                label: Text('  Continue with Google',
                  style:TextStyle(
                    fontWeight: FontWeight.bold,fontSize:20,
                    color:Colors.white,
                  ),),

              ),

            ],
          ),
        ),
      ),
    );
  }
}
