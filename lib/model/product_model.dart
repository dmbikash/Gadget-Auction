


class Product {
  final String productname;
  final double productprice;
  final String productuploaddate;
  final String productimage;
  final String userId;
  final String description;
  final String productId;
  var auc_date;
  var product_owner_email;
  String product_status;


  Product(
      {
        required this.productname,
        required this.productprice,
        required this.productuploaddate,
        required this.userId,
        required this.productimage,
        required this.description,
        required this.auc_date,
        required this.productId,
        required this.product_owner_email,
        required this.product_status,
      });


}
