import 'package:ecommerce/model/imports/generalImport.dart';

class CartFirstPageViewModel extends BaseModel{
  // cart value
  List<int> cartValue=[];

  // increment value
  increment(int index,productId)async{

    cartValue[index]++;
    notifyListeners();
    // get firebaseId from the local storage
    String? firebaseIdValue = await LocalStorage.getString(firebaseId);
    // update cart
    AddToCartService.updateUserData({
      'productId':productId,
      'productQuantity':cartValue[index].toString(),
      'firebaseId':firebaseIdValue!
    });
  }

  // decrement value
  decrement(int index,String productId)async{
    if(cartValue[index]==1){

    }
    else{
      cartValue[index]--;
      notifyListeners();
    }
// get firebaseId from the local storage
    String? firebaseIdValue = await LocalStorage.getString(firebaseId);
    // update cart
    AddToCartService.updateUserData({
      'productId':productId,
      'productQuantity':cartValue[index].toString(),
      'firebaseId':firebaseIdValue!
    });
  }
  // check box
  List<bool> isChecked=[];



  // check box onChanged
  checkBox(int index,bool value){
    isChecked[index]=value;
    notifyListeners();
  }

  // fetch list of cart from the database
  cartListFromFirebase(context)async{
    try{
      loadingDialog(context, text: 'Loading Cart item List');
      // get firebaseId from the local storage
      String? firebaseIdValue = await LocalStorage.getString(firebaseId);
      // fetch cart item list
      cartItemList = await AddToCartService.requestCartItemList(
          firebaseId: firebaseIdValue!);
      notifyListeners();
      if(cartItemList!=null && cartItemList!.docs.isNotEmpty){
        isChecked = List<bool>.filled(cartItemList!.docs.length, false);
        cartValue=List.generate(cartItemList!.docs.length, (index) {
          return int.parse(cartItemList!.docs[index]['productQuantity']);}
        );
        notifyListeners();
      }
      Navigator.pop(context);
    }
    catch(error){
      if(error.runtimeType is SocketException){
        Navigator.pop(context);
        loaderWithClose(context, text: 'Unable to load Cart item List,'
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



