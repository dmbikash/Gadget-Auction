import 'package:app_ebay/controllers/data_controller.dart';
import 'package:app_ebay/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final DataController controller =Get.find() ;
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    //final user = FirebaseAuth.instance.currentUser;

    return loading? Loading() :SafeArea(
      child: Container(
        color:Colors.teal,
        width: 220,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                decoration:
                BoxDecoration(color:Colors.teal[800]),// Theme.of(context).primaryColor),
                height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Hi.. ${controller.userProfileData['userName']} !',//${controller.userProfileData['userName']}
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
                    ),

                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: const Text('Your Product'),
                onTap: ()  {

                  Navigator.pushNamed(context, '/myProduct');


                },
              ),
              //ListTile(
            //    leading: Icon(Icons.logout),
            //    title: const Text('LogOut'),
            //    onTap: () {
            //      Navigator.pushReplacementNamed(context, '/wrapper');
              //  },
             // ),
            ],
          ),
        ),
      ),
    );
  }
}
