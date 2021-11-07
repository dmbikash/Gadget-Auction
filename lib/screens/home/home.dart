import 'package:app_ebay/controllers/data_controller.dart';
import 'package:app_ebay/screens/authenticate/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:app_ebay/services/storage_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';




class Home extends StatefulWidget {

  //const Home({Key? key}) : super(key: key);
  //DataController dc=DataController();


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser;

  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    Home();
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Logged In',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 25,
            backgroundImage: NetworkImage('${user!.photoURL}'),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + '${user!.displayName}',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + '${user!.email}',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
            //final provider =
             //Provider.of<GoogleSignInProvider>(context, listen: false);
             //provider.logout();
              Navigator.pushNamed(context, "/display_items_and_bid",arguments: {
               'userdata': user,
              });
            },
            child: Text('Click to Continue'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();

            },
            child: Text('Logout'),
          )
        ],
      ),
    );
  }
}

