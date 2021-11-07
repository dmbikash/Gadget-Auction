/*
import 'package:app_ebay/controllers/comman_dailog.dart';
import 'package:app_ebay/models/product_model.dart';
import 'package:app_ebay/services/services.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  List<Product> productData = [];
  Map productDetails = {}.obs;

  @override
  void onReady() {
    super.onReady();
    fatchProductData();
  }

  Future<void> fatchProductData() async {
    final List<Product> loadedProduct = [];
    CommanDialog.showLoading();
    try {
      final response = await APICall().getRequest('/getproductslist');
      CommanDialog.hideLoading();
      if (response['code'] == 200) {
        response['message']['products'].forEach(
          (productData) {
            loadedProduct.add(
              Product(
                  id: int.parse(productData['id']),
                  price: int.parse(productData['price']),
                  productImage: productData['productImage'],
                  productDescription: productData['productDescription'],
                  productName: productData['productName'],
                  favourite: productData['favourite']),
            );
          },
        );
        productData.assignAll(loadedProduct);
        update();
      } else if (response['code'] == 400) {
      } else {}
    } catch (error) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog();
      print("ERROR11 $error");
    }
  }
  
  Future<void> getDetails(id) async {
    print("fatchProduct $id");
    var postData = {"productid": id};
    productDetails = {};

    try {
      CommanDialog.showLoading();
      final response =
          await APICall().postRequest('/getproductdetails', postData);
      CommanDialog.hideLoading();
      if (response['code'] == 200) {
        print("Got product");
        Map dta = response['message']['productdet'];

        productDetails.addAll(dta);
        update();
      } else if (response['code'] == 400) {
        
        print("${response['code']}");
      } else {}
    } catch (error) {
      CommanDialog.hideLoading();
      print("ERROR11 $error");
    }
  }

  Future<void> addTowishList(id) async {
    print("fatchProduct $id");
    var postData = {"productid": 1};
    var index = productData.indexWhere((element) => element.id == id);
    productData[index].favourite = !productData[index].favourite;
    update();

    try {
      //getproductdetails
      final response =
          await APICall().postRequest('/wishlistproduct', postData);

      if (response['code'] == 200) {
        print("Added");
      } else if (response['code'] == 400) {
        productData[index].favourite = !productData[index].favourite;
      } else {}
    } catch (error) {
      CommanDialog.showErrorDialog();
      print("ERROR11 $error");
    }
  }


}
*/