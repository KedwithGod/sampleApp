


import 'package:ecommerce/model/imports/generalImport.dart';


class UserServices {
 static String collection = "users";

  static Future<bool> createUser(
      {required String? id,
      required String? firstName,
      required String? email,
      String? phone,
        required String? lastName,
        String? photoUrl,
        required String? password,
      required String? wooCommerceId,
        bool? isGoogleSignUp=false,
        bool? isPhoneAuth=false,
        bool? isFacebookAuth=false,
        bool? isAppleAuth=false,
      }) async {
   return await firebaseFireStore.collection(collection).doc(id).set({
      "firstName": firstName,
      'lastName': lastName,
      "id": id,
      "phone": phone??"",
      'password':password,
      "email": email,
      'photoUrl':photoUrl??"",
      'time of registration':currentTime(),
     'date of registration':currentDate('full date'),
     "wooCommerceId":wooCommerceId,
     if(isGoogleSignUp==true) "isGoogleSignUp":true,
     if(isPhoneAuth==true) "isPhoneAuth":true,
     if(isFacebookAuth==true) "isFacebookAuth":true,
     if(isAppleAuth==true) "isAppleAuth":true,


    },SetOptions(merge: true)).then((value) => true);
  }

  Future<bool> saveGuarantorDetails(String? id,
      String? guarantorFirstName,
      String? guarantorLastName,
      String? guarantorEmail,
      String? guarantorPhoneNumber
      ) async{
    return await firebaseFireStore.collection(collection).doc(id).collection('guarantorDetails').doc().set({
      'firstName': guarantorFirstName,
      'lastName':guarantorLastName,
      'phone':guarantorPhoneNumber,
      'email':guarantorEmail
    },SetOptions(merge: true)).then((value) => true);
  }

   updateUserData(Map<String, dynamic>? values) {
   return firebaseFireStore.collection(collection).doc(values!['id']).update(values);
  }

  void addDeviceToken({String? token, String? userId}) {
    firebaseFireStore
        .collection(collection)
        .doc(userId)
        .update({"token": token});
  }

 /* Future<UserModel>? getUserById(String id) =>
      firebaseFireStore.collection(collection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });*/



   Future<DocumentSnapshot<Map<String, dynamic>>> getAppUserById(String id) =>
      firebaseFireStore.collection(collection).doc(id).get().then((doc){
    return doc;
  });

   // stream to monitor change in user data
  Stream<QuerySnapshot> userStream({String? id}) {
    CollectionReference reference = firebaseFireStore.collection(collection);
    return reference.snapshots();
  }

  // fetch list of phone number from database
  Future<QuerySnapshot> fetchListOfStoredPhoneNumbers()async{
    CollectionReference reference = firebaseFireStore.collection('userPhoneNumber');
    return reference.get();
  }

  // save user phone number to list of phone number from database
  Future<bool> savePhoneNumbersToDatabase({required String? phoneNumber})async{
 firebaseFireStore.collection('userPhoneNumber').add({
   'phoneNumber':phoneNumber
 }).then((value) => true);
 return false;
  }

}
