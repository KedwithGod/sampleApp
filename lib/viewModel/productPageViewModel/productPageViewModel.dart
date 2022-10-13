import 'package:ecommerce/model/imports/generalImport.dart';


class ProductPageViewModel extends BaseModel{
  // is selected
  bool isProductSelected=false;

  addToFavorite(context,{required ProductResponse productItem}){
    isProductSelected=!isProductSelected;
    notifyListeners();
    if(isProductSelected==true){
      addToFavoriteFirebase(context,productItem: productItem);
    }
    if(isProductSelected==false){
      deleteToFavoriteFirebase(context, productId: productItem.id.toString());
    }

  }

  // add product to firebase favorite
  addToFavoriteFirebase(context,{required ProductResponse productItem})async{
    // get firebaseId from the local storage
    String? firebaseIdValue=  await LocalStorage.getString(firebaseId);
    AddToFavoriteService.addToFavorite(
      productId: productItem.id.toString(),
      productName: productItem.name,
      description: productItem.description,
      price: productItem.price,
      firebaseId: firebaseIdValue,
      image: productItem.images![0].src!,
    );
  }



  // load list of favorite to see if the product is in favorite list
  loadFavoriteListFromDB(String productId)async{
    // get firebaseId from the local storage
    String? firebaseIdValue=  await LocalStorage.getString(firebaseId);
    AddToFavoriteService.requestFavoriteItems(firebaseIdValue!).then((value){
      if(value.docs.isNotEmpty){
        for (var element in value.docs) {
          if(element.id==productId){
            isProductSelected=true;
            notifyListeners();
          }
        }}
    });
  }
}