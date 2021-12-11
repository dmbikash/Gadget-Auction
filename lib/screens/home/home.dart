
import 'package:app_ebay/screens/authenticate/sign_in.dart';
import 'package:app_ebay/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_ebay/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




class Home extends StatefulWidget {



  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;
  bool loading = false;
  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    Home();
    return loading? Loading() :Container(
      alignment: Alignment.center,
      //color: Colors.blueGrey.shade900,
      color:Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height:50
          ),
          Text(
              "Welcome to app_Ebay ",
              style: TextStyle(
                  color: Colors.teal[800],
                  fontSize: 20
              ),


          ),
          SizedBox(
            height:10
          ),
          Text(
            'Logg In Successful',
            style: TextStyle(color: Colors.teal[800]),
          ),
          SizedBox(height: 10),
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage('${user!.photoURL}'),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + '${user!.displayName}',
            style: TextStyle(color: Colors.teal[800], fontSize: 20),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + '${user!.email}',
            style: TextStyle(color: Colors.teal[800]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
            //final provider =
             //Provider.of<GoogleSignInProvider>(context, listen: false);
             //provider.logout();
              setState(() {
                loading=true;
              });
              await Future.delayed(const Duration(seconds: 3), (){});
              setState(() {
                loading=false;
              });
              Navigator.pushNamed(context, "/display_items_and_bid",arguments: {
               'userdata': user,

              });

            },
            child: Text('Click to Continue',style: TextStyle(fontSize: 20),),
            style:ElevatedButton.styleFrom(
              primary:Colors.teal[200],
            ),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();

            },
            child: Text('Logout',style: TextStyle(fontSize: 20),),
            style:ElevatedButton.styleFrom(
                primary:Colors.green[200],
            ),
          ),
          SizedBox(
            height:120,
          ),
          Text(
            'Developped By D M BIKASH',
            style: TextStyle(color: Colors.teal[800]),
          ),
        ],
      ),
    );
  }
}

