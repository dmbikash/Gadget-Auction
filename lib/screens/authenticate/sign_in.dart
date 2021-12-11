import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';


class GoogleSignInProvider extends ChangeNotifier{
  final googleSignIn=GoogleSignIn();
  late bool _isSigningIn;
  GoogleSignInProvider(){
    _isSigningIn=false;
  }
  bool get isSigningIn=>_isSigningIn;
  set isSigningIn(bool isSigningIn){
    _isSigningIn=isSigningIn;
    notifyListeners();
  }
   Future login() async{
     _isSigningIn=true;
     final user= await googleSignIn.signIn();
     if(user==null){
       isSigningIn=false;
       return;
     }
     else {
       final googleAuth = await user.authentication;

       final credential =GoogleAuthProvider.credential(
         accessToken: googleAuth.accessToken,
         idToken: googleAuth.idToken,
        );
       await FirebaseAuth.instance.signInWithCredential(credential);
       isSigningIn =false;
      }


   }
   void logout() async{
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
   }
}


class SignIn extends StatefulWidget {
  //const SignIn({Key? key}) : super(key: key);
  //final Function  toggleView;
  //SignIn({required this.toggleView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  // final AuthService auth = AuthService();
   String email='';
   String password="";

  @override
  Widget build(BuildContext context) {// cause eta kisu grp of widget pathabe..scaffolod e pura page er  shob thake
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: Text("Sign in to Ebay_Bikash"),

        actions:<Widget> [
          FlatButton.icon(
            icon:Icon(Icons.person),
            onPressed: (){},
            label: Text('resister'),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                onChanged: (val){
                  setState(() {
                    email=val;
                  });

                },
              ),
              TextFormField(
                obscureText: true,//password secured
                onChanged: (val){
                  setState(() {
                    password=val;
                  });

                },
              ),

              SizedBox(height: 20,),
              ElevatedButton.icon(
                  onPressed: () {

                  },
                icon:FaIcon(FontAwesomeIcons.google,color:Colors.teal[400]),
                style: ElevatedButton.styleFrom(
                  primary:Colors.white,
                  onPrimary: Colors.black,
                  minimumSize: Size(double.infinity,50),
                ),

                label: Text('  Signin with Google'),

                  ),

            ],
          ),
        ),
      ),
    );
  }
}
