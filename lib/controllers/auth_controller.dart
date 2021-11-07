/*
import 'package:app_ebay/controllers/comman_dailog.dart/';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
class AuthController extends GetxController{

  var userId;

  Future<void> signUp(user) async{
    try{
     // CommanDialog.showLoading();
        var response=
            await FirebaseFirestore.instance.collection("userList").add({
              'User_ID':user!.uid,
              'user_name':user!.displayName,
              //'password':user!.password,
              'email':user!.email,
              'userPhoto':user!.photoURL,

        });
    }catch (exception){
      //CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }


dosti

 */