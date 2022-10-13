// material page function

import 'package:ecommerce/model/imports/generalImport.dart';

materialPage(settings,page){
  return MaterialPageRoute(
    settings: settings,
    builder: (_) =>page,
  );
}