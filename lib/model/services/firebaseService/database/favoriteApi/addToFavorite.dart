// add to favorite using firebase
import 'package:ecommerce/model/imports/generalImport.dart';

class AddToFavoriteService{

  // add to cart, then add the cart document to the same file
  static String collection = "favorite";

  static Future<bool> addToFavorite(
      {required String? productId,
        required String? productName,
        required String? description,
        String? productQuantity,
        required String? price,
        required String image,
        required String? firebaseId

      }) async {
    return await firebaseFireStore.collection(collection).doc(firebaseId).collection('favoriteList').doc(productId).set({
      "productId": productId,
      'productName': productName,
      "description": description,
      "productQuantity": productQuantity,
      'price':price,
      'image':image,
      'currency':"د.ك",
      'time of registration':currentTime(),
      'date of registration':currentDate('full date'),
      'time of request':DateTime.now()
    },SetOptions(merge: true)).then((value)  {
      return true;});
  }



  // update cart item
 static updateUserData(Map<String, dynamic> values) {
    return firebaseFireStore.collection(collection).doc(values['firebaseId']).collection('favoriteList').doc(values['productId']).update(values);
  }

// list cart item
 static Future<QuerySnapshot<Map<String, dynamic>>> requestFavoriteItems(String firebaseId) {
    var reference =FirebaseFirestore.instance.collection(collection).doc(firebaseId).collection('favoriteList');
    return reference.get();
  }

// remove from cart item
  // a function to delete rider request in case the user cancels request

 static deleteRequest(String firebaseId,String productId){
    firebaseFireStore.collection(collection).doc(firebaseId).collection('favoriteList').doc(productId).delete();
  }
}