

import 'package:ecommerce/model/imports/generalImport.dart';


class CreateWooCommerceUser{
  // function to create account
  static Future createCustomers({
     String? userName="", required String email,required String name,
    required String password
  })async{
    Map<String, String> header = {
      "Content-type": "application/json"
    };
    List splitName=name.split(" ");
    Map<String,String> data={
      "email": email,
      "first_name": name.isEmpty?"":splitName[0],
      "last_name":name.isEmpty && splitName.length<2?"": splitName[1],
      "username": userName??"",
      "password":password
    };

    String url = baseUrl("customers");
    var respond =
    post(Uri.parse(url),body: data).then((response) {
      var parsed = response.body;
      Map<String,dynamic> decoded = json.decode(parsed);
      if (kDebugMode) {
      }
      if (response.statusCode == 200||response.statusCode == 201) {
        return UserResponse.fromJson(decoded);
      }

      else {
        if (kDebugMode) {
          print("i am response code "+ response.statusCode.toString());
        }
        return WooCommerceErrorResponse.fromMap(json.decode(parsed));
      }
    });
    return respond;


  }}