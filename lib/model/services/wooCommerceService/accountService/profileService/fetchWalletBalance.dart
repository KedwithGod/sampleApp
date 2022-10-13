import 'package:ecommerce/model/imports/generalImport.dart';


class WooCommerceCustomerBalance{
  // function to customer wallet balance
  static Future fetchCustomerWalletBalance({required String email}
      )async{
    Map<String, String> header = {
      "content-type": "application/json"
    };

    String url = baseUrl("wallet/balance")+"&email=$email";
    var respond =
    get(Uri.parse(url), headers: header,).then((response) {
      var parsed = response.body;
      Map<String,dynamic> decoded = json.decode(parsed);
      print("i am wallet data $decoded");
      if (response.statusCode == 200) {
        return WalletBalanceResponse.fromJson(decoded);
      }
      else {
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;
  }}