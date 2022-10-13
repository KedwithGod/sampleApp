// create a base url function
import '../../imports/generalImport.dart';

String baseUrl(String url,{String? optionalParameter,String? optionalValue}){
  return optionalParameter!=null?
  "https://www.q8-uc.com/wp-json/wc/v3/$url?$optionalParameter=$optionalValue&"
      "consumer_key=$consumerKey"
      "&consumer_secret=$consumerSecret"
      :"https://www.q8-uc.com/wp-json/wc/v3/$url?consumer_key=$consumerKey"
      "&consumer_secret=$consumerSecret";
}
String getCart="";
String addToCart="";
String removeFromCart="";
String updateCart="";
String deleteCartItem="";