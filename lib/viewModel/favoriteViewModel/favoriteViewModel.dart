import 'package:ecommerce/model/imports/generalImport.dart';

class FavoriteViewModel extends BaseModel{
  // cart value
  List<int> cartValue=[];
  // fetch list of favorite from the database
  favoriteListFromFirebase(context)async{
    try{
      loadingDialog(context, text: 'Loading Favorite item List');
      // get firebaseId from the local storage
      String? firebaseIdValue = await LocalStorage.getString(firebaseId);
      // fetch cart item list
      favoriteItemList = await AddToFavoriteService.requestFavoriteItems(
          firebaseIdValue!);
      notifyListeners();

      Navigator.pop(context);
    }
    catch(error){
      if(error.runtimeType is SocketException){
        Navigator.pop(context);
        loaderWithClose(context, text: 'Unable to load favorite item List,'
            ' kindly check your internet connection');
      }
      else{
        Navigator.pop(context);
        loaderWithClose(context, text:
          'An error occurred, try again later'
        );
      }
    }
  }
}