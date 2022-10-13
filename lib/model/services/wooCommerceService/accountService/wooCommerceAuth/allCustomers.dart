

import 'package:ecommerce/model/imports/generalImport.dart';


class AllWooCommerceUser{
  // function to create account
  static Future fetchListOfCustomers({
    required String userName, required String email
  })async{
    Map<String, String> header = {
      "content-type": "application/json"
    };

    String url = baseUrl("customers",optionalParameter: "email",optionalValue: email);
    var respond =
    get(Uri.parse(url), headers: header,).then((response) {
      var parsed = response.body;
      Map<String,dynamic> decoded = json.decode(parsed)[0];
      print(decoded);
      if (response.statusCode == 200) {
            return UserResponse.fromJson(decoded);
          }

      else {
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;


}}