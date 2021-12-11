import 'package:app_ebay/model/bid_model.dart';
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
  int winner_bid=0;
  String winner_name="";

  List<Product> loginUserData = [];

  List<Product> allProduct = [];
  List<BID_classs> allBidInfo = [];


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
        // print(result.data());
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
    //print(result);
    final ref =
    FirebaseStorage.instance.ref().child('product_images').child(result);
    var response = await ref.putFile(image);
    //print("Updated $response");
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
     // print("Firebase response1111 $response");
     // CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
     // CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }
  Future<void> addBidPrice(Map bidData) async {
    //print("printing the bid price in data controller");
    //print(bidData['bid_price']);

    try {
      //CommanDialog.showLoading();
      var response = await firebaseInstance.collection('aucList').add({
         'bid_price': bidData['bid_price'],
         "product_owner_email":bidData['product_owner_email'],
         "biddier_name":bidData['bidder_name'],
          'product_id':bidData['product_id'],

       // 'auction_price': productdata['auc_price'],
        //"product_upload_date": productdata['p_upload_date'],

      });
      //print("Firebase response1111 $response");
      // CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
      // CommanDialog.hideLoading();
      print("Error Bid price  Saving Data at firestore $exception");
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
     // print("aaaaaaasjaaaaaaaaaaaaaaaaa------------------------signup hoise");
     // print(response.docs[0]['email']);
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




  Future<void> getLoginUserProduct() async {
    print("loginUserData YEs $loginUserData");
    loginUserData = [];
    try {
      //CommanDialog.showLoading();
      final List<Product> lodadedProduct = [];
      var response = await firebaseInstance
          .collection('productList')
          .orderBy('product_upload_date', descending: true)
          //.where('email', isEqualTo:user.email)
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach(
              (result) {
            //print(result.data());
            //print('----zxxxx-----------xxxxx----------------xxxx');
           // print("Product ID  ${result.id}");
            if(result.data()["email"] == user.email){
              lodadedProduct.add(
                Product(
                  productId: result.id,
                  userId: result['user_Id'],
                  productname: result['product_name'],
                  productprice: double.parse(result['auction_price']),
                  productimage: result['product_image'],
                  description: result['description'],
                  productuploaddate: result['product_upload_date'].toString(),
                  auc_date:result['auction_date'],
                  product_owner_email:result['email'],
                  product_status: "",
                ),

              );
            }

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
   // print("error 1111");
    try {
     // CommanDialog.showLoading();
      final List<Product> lodadedProduct1 = [];
     // print("error 222");
      var response = await firebaseInstance
          .collection('productList')

          //.orderBy('product_upload_date')
         // .where('email', isNotEqualTo: user.email)
          .orderBy('product_upload_date', descending: true)

          .get();
      //print("error 333");
      if (response.docs.length > 0) {
        response.docs.forEach(
              (result) {
                //print("xx---------printing result data from firebase-------------------xxx");
               // print(DateTime.now());
               // print(result.data()["auction_date"]);//yahoooooooooo * wow
                try{

                  int daysBetween(DateTime from, DateTime to) {
                    from = DateTime(from.year, from.month, from.day);
                    to = DateTime(to.year, to.month, to.day);
                    return (to.difference(from).inHours / 24).round();
                  }
                  DateTime from=result.data()["auction_date"].toDate();
                  DateTime to=DateTime.now();
                  final difference = daysBetween(to, from);
                 // print("difference");
                 // print(difference);
                  if(difference >0){
                    print("first iff crossed");
                    if(result.data()["email"] != user.email){ //upore where() check kroa jachhe na tai ekhane check kortesi
                    //  print("yes---------- done----------yes");
                      lodadedProduct1.add(
                        Product(
                          productId: result.id,
                          userId: result['user_Id'],
                          productname: result['product_name'],
                          productprice: double.parse(result['auction_price']),
                          productimage: result['product_image'],
                          description: result['description'],
                          productuploaddate: result['product_upload_date'].toString(),
                          auc_date: result['auction_date'],
                          product_owner_email:result['email'],
                          product_status: 'pending',
                        ),

                      );

                    }

                  }
                  else {
                    if(result.data()["email"] != user.email){
                     // print(difference);
                    //  print("no---------- done----------no");
                      lodadedProduct1.add(
                        Product(
                          productId: result.id,
                          userId: result['user_Id'],
                          productname: result['product_name'],
                          productprice: double.parse(result['auction_price']),
                          productimage: result['product_image'],
                          description: result['description'],
                          productuploaddate: result['product_upload_date'].toString(),
                          auc_date: result['auction_date'],
                          product_owner_email:result['email'],
                          product_status: 'end',
                        ),

                      );

                    }


                  }
                }
                catch(e)
                {
                  print('jhamela ase time stampe ${e}');
                }
           // print(result.data());
          //  print(result.id);
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

  Future<void> getBidList( var product_id ) async {
    allBidInfo = [];
   // print("runningggg  getBIDList | received param ${product_id}");
    try {
      // CommanDialog.showLoading();
      final List<BID_classs> allBidInfo1 = [];
      var response = await firebaseInstance
          .collection('aucList')
          .where('product_id', isEqualTo: product_id)/////
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
              (result) {
            //    print("eije bidder info--------------------------------------------result");
         //   print(result.data());
           // print(result.id);
            allBidInfo.add(
              BID_classs(
                product_owner_email:result['product_owner_email'],
                bidder_name: result['biddier_name'],
                bid_price: result['bid_price'],
                product_id:result.id,


              ),

            );
          },
        );
        allBidInfo.addAll(allBidInfo1);
        update();
      //  print("eije bidder info--------------------------------------------");
       // print(allBidInfo);
      }else{// mane kono bid kora hoy nai..so do.length=0...
        winner_bid=0;
        winner_name="None";
      }

      //CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      //CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      /// product paowa jaynai exception
      // CommanDialog.hideLoading();
      print("/// product paowa jaynai exception");/// product paowa jaynai exception
      print("error $error");
    }
    try{
      int min_bid=0;
    var a= allBidInfo.length;
    //print(a);
    for (int i=0; i<a;i++){
      //print(allBidInfo[i]);
      var instance=allBidInfo[i];
      var c=int.parse(instance.bid_price);// instace is a variable which contains intaces of BID_classs
      //print(c+min_bid);
      if(c>min_bid){
        min_bid=c;
        winner_name=instance.bidder_name;
      }
      //print(min_bid);


    }
      winner_bid=min_bid;
      print(winner_name);
}
catch(e){
      print(' bidding calculation esxceptpn-------------------------');
print("bidding winner calculation e problem hoise");
    }

  }





//class shesh
}