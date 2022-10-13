

import 'package:ecommerce/model/imports/generalImport.dart';


class WooCommerceUser{
  // function to create account
 static Future fetchNewWooCommerceUser({
    required id,
  })async{
    Map<String, String> header = {
      "content-type": "application/json"
    };

    String url = baseUrl("customers/$id");
    var respond =
    get(Uri.parse(url), headers: header,).then((response) {

      var parsed = response.body;
      Map<String,dynamic> decoded = json.decode(parsed);
      if (kDebugMode) {
        print('i am decoded $decoded');
      }
      if(response.statusCode==200){
        return UserResponse.fromJson(decoded);
      }
      else{
        return WooCommerceErrorResponse.fromMap(decoded);
      }
    });
    return respond;
  }

}