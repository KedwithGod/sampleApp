

import 'package:ecommerce/model/imports/generalImport.dart';



class AllCurrency{
  // function to create account
  static Future fetchCurrencyService()async{
    Map<String, String> header = {
      "content-type": "application/json"
    };

    String url = baseUrl("data/currencies",);
    var respond =
    get(Uri.parse(url), headers: header,).then((response) {
      var parsed = response.body;

      if (response.statusCode == 200) {
        List decoded = json.decode(parsed);
        print(decoded);
        return decoded;
      }


      else {
        Map<String,dynamic> decoded = json.decode(parsed);
        print(decoded);
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;


  }}