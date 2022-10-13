import 'package:ecommerce/model/imports/generalImport.dart';
class SplashScreenViewModel extends BaseModel{
  future(context)async{
    /*String? userToken=await localStorage.getAuthToken(token);
    print("i am token $userToken");*/

    await Future.delayed(const Duration(seconds: 4),()async{
      String? signIn=await LocalStorage.getString('firebaseId');
     if(signIn==""||signIn==null){
       Navigator.popAndPushNamed(context, '/login');
     }
     else{
       Navigator.popAndPushNamed(context, '/homePage');
     }
    });
  }
}