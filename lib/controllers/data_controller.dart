import 'package:app_ebay/model/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

class DataController extends GetxController
{
  dynamic user ='';

  DataController(){
    final user = FirebaseAuth.instance.currentUser;
    this.user=user;

    signUp(user);

  }



 // Data Controller

  List<Product> loginUserData = [];

  List<Product> allProduct = [];


  final firebaseInstance = FirebaseFirestore.instance;
  Map userProfileData = {'userName': '', 'joinDate': ''};
  //AuthController authController=AuthController();

  void onReady() {
    super.onReady();
    getAllProduct();
    getUserProfileData();
  }




 // Method for get User profile

  Future<void> getUserProfileData() async {
    // print("user id ${authController.userId}");
    try {
      var response = await firebaseInstance
          .collection('userList')
          .where('email', isEqualTo: user!.email)////////
          .get();
       response.docs.forEach((result) {
         print(result.data());
       });
      if (response.docs.length > 0) {
        userProfileData['userName'] = response.docs[0]['user_name'];
        userProfileData['joinDate'] = response.docs[0]['joinDate'];
      }
      //print('user ------------------prole-----------data ');
      //print(userProfileData);
    } on FirebaseException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }


  Future<void> addNewProduct(Map productdata, File image) async {
    var pathimage = image.toString();
    var temp = pathimage.lastIndexOf('/');
    var result = pathimage.substring(temp + 1);
    print(result);
    final ref =
    FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    print("Updated $response");
    var imageUrl = await ref.getDownloadURL();

    try {
      //CommanDialog.showLoading();
      var response = await firebaseInstance.collection('productList').add({
        'product_name': productdata['p_name'],
        'auction_price': productdata['auc_price'],
        "product_upload_date": productdata['p_upload_date'],
        'product_image': imageUrl,
        'user_Id': user.uid,
        'email':user.email,
        "description": productdata['description'],
        "auction_date":productdata['auc_date'],
      });
      print("Firebase response1111 $response");
     // CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
     // CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }











  Future<void> signUp(user) async{

    //print("ei j bug mama dhora khaba ekhon");
    //print(user);
    try {
      var response = await firebaseInstance
          .collection('userList')
          .where(
          'email', isEqualTo: user!.email) ////////dhora khaise bug mama xD
          .get();
      print("aaaaaaasjaaaaaaaaaaaaaaaaa------------------------");
      print(response.docs[0]['email']);
      if (response.docs.length > 0) {
        print("trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      }
    }catch(e) {
      //print(user.email);
      //if(user.email!=response.docs[0]['email']){
      // print("trueeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee2222");
      try {
        // CommanDialog.showLoading();
        var response =
        await FirebaseFirestore.instance.collection("userList").add({
          'User_ID': user!.uid,
          'user_name': user!.displayName,
          //'password':user!.password,
          'email': user!.email,
          'userPhoto': user!.photoURL,

        });
      } catch (exception) {
        //CommanDialog.hideLoading();
        print("Error Saving Data at firestore $exception");
      }
    }

    }



/*
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

 */

/*

  //Show RealData in AppDrawer

  final DataController controller = Get.find();


  'User : ',

  'Join Date :${DateFormat.yMMMMd().format(DateTime.fromMillisecondsSinceEpoch(controller.userProfileData['joinDate']))} ',
*/


  Future<void> getLoginUserProduct() async {
    print("loginUserData YEs $loginUserData");
    loginUserData = [];
    try {
      //CommanDialog.showLoading();
      final List<Product> lodadedProduct = [];
      var response = await firebaseInstance
          .collection('productList')
          .where('email', isEqualTo:user.email)
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach(
              (result) {
            print(result.data());
            print('----zxxxx-----------xxxxx----------------xxxx');
            print("Product ID  ${result.id}");
            lodadedProduct.add(
              Product(
                  productId: result.id,
                  userId: result['user_Id'],
                  productname: result['product_name'],
                  productprice: double.parse(result['auction_price']),
                  productimage: result['product_image'],
                  description: result['description'],
                  productuploaddate: result['product_upload_date'].toString(),
                  //auc_date:result['auction_date']
              ),

            );
            //print(Product);
          },
        );
      }
      loginUserData.addAll(lodadedProduct);
      update();
      //CommanDialog.hideLoading();

    } on FirebaseException catch (e) {
     // CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      //CommanDialog.hideLoading();
      print("error $error");
    }
  }

  Future<void> getAllProduct() async {
    allProduct = [];
    try {
     // CommanDialog.showLoading();
      final List<Product> lodadedProduct1 = [];
      var response = await firebaseInstance
          .collection('productList')
          .where('email', isNotEqualTo: user.email)
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
              (result) {
            print(result.data());
            print(result.id);
            lodadedProduct1.add(
              Product(
                  productId: result.id,
                  userId: result['user_Id'],
                  productname: result['product_name'],
                  productprice: double.parse(result['auction_price']),
                  productimage: result['product_image'],
                  description: result['description'],
                  productuploaddate: result['product_upload_date'].toString()
                  //auc_date: result['auction_date']
              ),

            );
          },
        );
        allProduct.addAll(lodadedProduct1);
        update();
      }

      //CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      //CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
     // CommanDialog.hideLoading();
      print("error $error");
    }
  }









}