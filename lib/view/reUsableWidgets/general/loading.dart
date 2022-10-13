import 'package:ecommerce/model/imports/generalImport.dart';

Widget loading({double? height,double? width,Color? color}){
  return S(
    h: height??50,
    w: width??50,
    child:  CircularProgressIndicator(
      valueColor:   AlwaysStoppedAnimation<Color>(
          color??primary),
      backgroundColor:white),
  );
}