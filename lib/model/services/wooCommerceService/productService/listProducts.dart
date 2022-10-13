

import 'package:ecommerce/model/imports/generalImport.dart';

class WooCommerceProducts{
  // function to create account
  static Future fetchAllProducts(
      {required int categoryId}
      )async{
    Map<String, String> header = {
      "content-type": "application/json"
    };

    String url = baseUrl("products",optionalValue: categoryId.toString(),optionalParameter: "category")+"&per_page=100";
    var respond =
    get(Uri.parse(url), headers: header,).then((response) {
      var parsed = response.body;
      List decoded = json.decode(parsed);
      print(decoded.length);
      if (response.statusCode == 200) {
        return decoded;
      }

      else {
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;


  }}