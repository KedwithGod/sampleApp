import 'package:dio/dio.dart';
import 'package:ecommerce/model/imports/generalImport.dart';




class HomePageViewModel extends BaseModel {




  products(context) async {
    // var products = await wooCommerceAPI.getAsync("products");
    try{
      var product = await Dio().get(
          "https://www.q8-uc.com/wp-json/wc/v3/products?consumer_key=ck_39971a6abfbae154c5baf5d9f98e7b1155226b07&consumer_secret=cs_3d9d18991d087a8dfe7cca01e8b5d8f825b488fb",
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      print("products $product");
    }
    on SocketException catch (error){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(context,
            "Looks like you have a bad internet connection, kindly check and try again",
            'Network Error',
            DialogType.error,
            dismissText: 'close',
            function: () {
              // if the error message contains email, it is likely the email
              // is incorrect

              // if the error message contains login, it is likely to go to login pag
              Navigator.pop(context);
            },
            dismissTextColor: primary,
          ));
      return error;
    }
  }
  // fetch all product review
  fetchAllProductReview(BuildContext context){
    AllProductPreview.fetchAllProductPreview();
  }
}