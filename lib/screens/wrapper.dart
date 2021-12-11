import 'package:flutter/material.dart';
import 'package:app_ebay/screens/authenticate/register.dart';
import 'package:app_ebay/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'authenticate/sign_in.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(

    body: ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final provider = Provider.of<GoogleSignInProvider>(context);

          if (provider.isSigningIn) {
            return buildLoading();
          } else if (snapshot.hasData) {

            return Home();
          } else {
            return Register();
          }
        },
      ),
    ),

  );

  Widget buildLoading() => Center(child: CircularProgressIndicator(color: Colors.teal,));
}
