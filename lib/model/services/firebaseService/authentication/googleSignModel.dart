

import 'package:ecommerce/model/imports/generalImport.dart';

// method to perform all google signIN
class GoogleSigning{
  // initializing the google sign in
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: DefaultFirebaseOptions.currentPlatform.iosClientId);

  // firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // current user details
  String? userEmail;
  String? userDisplayName;
  String? userPhotoUrl;
  String? userId;
  GoogleSignInAccount? _user;
  // google sign in method
  Future googleSignIn(BuildContext context) async{
    try {
      final googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth;
      googleAuth = await googleUser!.authentication;

      // creating a credential to sign up into firebase
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken
      );

      // signing into firebase using the credentials gotten form google
      await FirebaseAuth.instance.signInWithCredential(credential).then((
          firebase)async{
        // save user Id to sharedPreference
      await LocalStorage.setString(firebaseId, firebase.user!.uid);
      // save sign in method to local storage
      await LocalStorage.setString(signInMethod, googleAuthMethod);
      // get wooCommerce id and save it in localStorage
       // fetch wooCommerce id from firebase
      DocumentSnapshot<Map<String, dynamic>> value=await userService.getAppUserById(firebase.user!.uid);
      // save wooCommerceId in local Storage
      await LocalStorage.setString(wooCommerceId, value.data()!["wooCommerceId"]);
      Navigator.pop(context);
      Navigator.pushNamed(context, "/homePage");});

    }
    catch(error){
      showDialog(
          context: context,
          builder: (context)=>
              dialogBox(context,error.toString(), 'Google SignIn',DialogType.error, ));
    }
  }

  // google signUp method
   Future googleSignUp(BuildContext context) async {
 try{
   Navigator.pop(context);
   final GoogleSignInAccount? googleUser =await _googleSignIn.signIn();

   // values gotten from the user google account
   googleUser!=null?userEmail=googleUser.email:null;
   googleUser!=null?userDisplayName=googleUser.displayName:null;
   googleUser!=null?userPhotoUrl=googleUser.photoUrl:null;
   googleUser!=null?userId=googleUser.id:null;
   googleUser!=null?userPhotoUrl=googleUser.photoUrl:null;


   if (kDebugMode) {
     print("i am google user Id " + userId!);
   }

   googleUser!.authentication;



   // getting the google sign iN account user
   _user=googleUser;
   // setting up google auth
   GoogleSignInAuthentication googleAuth;
   googleAuth =await googleUser.authentication;

   // creating a credential to sign up into firebase
   final credential =GoogleAuthProvider.credential(
       accessToken: googleAuth.accessToken,
       idToken: googleAuth.idToken
   );

   // signing into firebase using the credentials gotten form google
   await FirebaseAuth.instance.signInWithCredential(credential).then((value)async{
     // save data into local Storage
     await LocalStorage.setString(firebaseAuth, value.user!.uid);
     // add creating customer with woo commerce
     // create wooCommerce sign Up
     await CreateWooCommerceUser.createCustomers( email: userEmail!, name: userDisplayName!,
         password: "password12345&&DW",userName: userDisplayName).then((wooCommerce)async{
       // store wooCommerce id in cloud fire store
       if(wooCommerce is UserResponse){
         // save user data to
         UserServices.createUser(id:value.user!.uid,email: userEmail,
         firstName:userDisplayName,photoUrl: userPhotoUrl??"", lastName: '',
         wooCommerceId: wooCommerce.id.toString(), password: '',isGoogleSignUp: true,
       );
         // save wooCommerce id to local storage
         await LocalStorage.setString(wooCommerceId, wooCommerce.id.toString());
         if (kDebugMode) {
           print("woo commerce account created");
         }
         Navigator.pop(context);
         Navigator.pushNamed(context, "/homePage");
       }
       else if(wooCommerce is WooCommerceErrorResponse){
         showDialog(
             context: context,
             builder: (context)=>
                 dialogBox(context,
                     wooCommerce.message,
                     "WooCommerce Account", DialogType.error));
       }
       else{
         showDialog(
             context: context,
             builder: (context)=>
                 dialogBox(context,
                     "Unable to Create Woo commerce account for your",
                     "WooCommerce Account", DialogType.error));
       }

     });
   });

 }

 catch(onError){
   print(onError);
     // display error in a dialog box
      showDialog(
          context: context,
          builder: (context)=>
              dialogBox(context,
                  onError.toString(), "Google Sign", DialogType.error));
    }


  }


  // google signOut method
    Future googleSignOut(BuildContext context) async {
      try{
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut().catchError((onError) {
        // display error in a dialog box
        showDialog(
            context: context,
            builder: (context) => dialogBox(
                  context,
                  onError.toString(),
                  'Google SignOut',
                  DialogType.error,
                ));
      });
      await FirebaseAuth.instance.signOut();
    }
      catch(onError){
        print(onError);
        // display error in a dialog box
        showDialog(
            context: context,
            builder: (context)=>
                dialogBox(context,
                    onError.toString(), "Google Sign", DialogType.error));
      }

    }
}
