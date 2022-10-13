// add to cart using firebase
import 'package:ecommerce/model/imports/generalImport.dart';

class AddToCartService{

  // add to cart, then add the cart document to the same file
static String collection = "cart";

// this is to initialize cart document so it can be updated with array functions


// add a new item to cart
  static Future<bool> addToCart(
      {required String? productId,
      required String? productName,
      required String? description,
        required String image,
      String? productQuantity,
        String? currency,
        required String? price,
        required String? firebaseId// for non registered user, use phone identifier
      }) async {
   return await firebaseFireStore.collection(collection).doc(firebaseId).collection('cartItemList').doc(productId).set({

       "productId": productId,
       'productName': productName,
       "description": description,
       "productQuantity": productQuantity ?? "1",
       'price': price,
        'currency':currency??"default",
       'image':image,
     'time of registration':currentTime(),
     'date of registration':currentDate('full date'),
     'time of request':DateTime.now()
     }).then((value)  {
     return true;});
  }



  // update cart item
  static updateUserData(Map<String, dynamic> values) {
   return firebaseFireStore.collection(collection).doc(values["firebaseId"]).
   collection('cartItemList').doc(values['productId']).update(values);
  }

// list cart item
 static Future<QuerySnapshot<Map<String, dynamic>>> requestCartItemList({required String firebaseId}) {
    var reference = FirebaseFirestore.instance.collection(collection).doc(firebaseId).collection('cartItemList');
    return reference.get();
  }

// remove from cart item
 // a function to delete rider request in case the user cancels request

 static deleteRequest(String firebaseId, String productId){
   firebaseFireStore.collection(collection).doc(firebaseId).collection('cartItemList').doc(productId).delete();
  }
}