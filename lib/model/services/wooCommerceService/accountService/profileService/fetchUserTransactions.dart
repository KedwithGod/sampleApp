import 'package:ecommerce/model/imports/generalImport.dart';


class WooCommerceCustomerTransaction{
  // function to create account
  static Future fetchCustomerTransaction({required String email}
      )async{
    Map<String, String> header = {
      "content-type": "application/json"
    };

    String url = baseUrl("wallet")+"&email=$email";
    var respond =
    get(Uri.parse(url), headers: header,).then((response) {
      var parsed = response.body;
      List decoded = json.decode(parsed);
      print("print transaction list"+decoded.toString());
      if (response.statusCode == 200) {
        return decoded;
      }
      else {
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;
  }}