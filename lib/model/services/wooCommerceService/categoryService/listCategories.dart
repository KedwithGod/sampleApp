import 'package:ecommerce/model/imports/generalImport.dart';


class WooCommerceCategories{
  // function to create account
  static Future fetchAllCategories(
  )async{
    Map<String, String> header = {
      "content-type": "application/json"
    };

    String url = baseUrl("products/categories")+"&per_page=100";
    var respond =
    get(Uri.parse(url), headers: header,).then((response) {
      var parsed = response.body;
      var decoded = json.decode(parsed);
      print(decoded);
      if (response.statusCode == 200) {
        return decoded;
      }
      else {
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;
  }}