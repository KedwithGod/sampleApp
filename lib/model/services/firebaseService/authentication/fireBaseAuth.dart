import 'package:ecommerce/model/imports/generalImport.dart';



class FireBaseAuthClass {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // firebase auth signIn
  static Future fireBaseCreateUser({required String fullName,required String email,
  required String userPassword, required BuildContext context}) async {
    //sign in with email and password
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: userPassword).then((value)async{
            // firebase auth instance
        var user = FirebaseAuth.instance.currentUser!;
        // save user Id to sharedPreference
        await LocalStorage.setString(firebaseId, user.uid);
        // save sign in method to local storage
        await LocalStorage.setString(signInMethod, firebaseAuth);
      // create woo commerce user
        await CreateWooCommerceUser.createCustomers( email: email, name: fullName,password:userPassword,userName: fullName).
        then((wooCommerce)async{
          // store wooCommerce id in cloud fire store
          if(wooCommerce is UserResponse){
            if (kDebugMode) {
              print("woo commerce started");
            }
            // save user data to
          await UserServices.createUser(id: user.uid, firstName: fullName.isEmpty?"":fullName.split(" ")[0], email: email,
                lastName: fullName.isEmpty?"":fullName.split(" ")[1], password: userPassword, wooCommerceId: wooCommerce.id.toString());
            // save wooCommerce id to local storage
            await LocalStorage.setString(wooCommerceId, wooCommerce.id.toString());

            // save a cart and add favorite document for user, so these document can be updated using
            // arrayUnion and array remove


            if (kDebugMode) {
              print("woo commerce done");
            }
            Navigator.pop(context);
            Navigator.pushNamed(context, "/homePage");
            return true;
          }
          else if (wooCommerce is WooCommerceErrorResponse){
            showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => dialogBox(
                  context,
                  wooCommerce.message,
                  'Account Creation',
                  DialogType.error,
                  dismissText: 'close',
                  function: () {

                    Navigator.pop(context);
                  },
                  dismissTextColor: primary,
                ));
          }

        });

        return true;
      });


    } on FirebaseAuthException catch (error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(
            context,
                getMessageFromErrorCode(error),
                'Account Creation Error',
                DialogType.error,
                dismissText: 'close',
                function: () {
                  // if the error message contains email, it is likely the email
                  // is incorrect

                  // if the error message contains login, it is likely to go to login pag
                  Navigator.pop(context);
                },
                dismissTextColor: primary,
              ));
      return error;
    }
    on SocketException catch (error){
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(
            context,
            "Looks like you have a bad internet connection, kindly check and try again",
            'Network Error',
            DialogType.error,
            dismissText: 'close',
            function: () {

              Navigator.pop(context);
            },
            dismissTextColor: primary,
          ));
      return error;
    }
  }

  Future firebaseSignIn(userEmail, userPassword, context) async {
    //sign in with email and password
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: userEmail, password: userPassword).then((firebase) async{
        // save user Id to sharedPreference
        await LocalStorage.setString(firebaseId, firebase.user!.uid);
        // save sign in method to local storage
        await LocalStorage.setString(signInMethod, firebaseAuth);
        // fetch wooCommerce id from firebase
        DocumentSnapshot<Map<String, dynamic>> value=await userService.getAppUserById( firebase.user!.uid);
        // save wooCommerceId in local Storage
        await LocalStorage.setString(wooCommerceId, value.data()!["wooCommerceId"]);
        Navigator.pop(context);
        Navigator.pushNamed(context, "/homePage");
        return firebase.user!.uid;
      });

    } on FirebaseAuthException catch (loginError) {
      // update viewState
      // show dialog for login Error
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (context) {
            return dialogBox(context,
              getMessageFromErrorCode(loginError),
              'Login Error',
              DialogType.error,
            );
          });
    }

    on SocketException catch (error){
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(
            context,
            "Looks like you have a bad internet connection, kindly check and try again",
            'Network Error',
            DialogType.error,
            dismissText: 'close',
            function: () {
              // if the error message contains email, it is likely the email
              // is incorrect

              // if the error message contains login, it is likely to go to login pag
              Navigator.pop(context);
            },
            dismissTextColor: primary,
          ));
      return error;
    }
  }

  // firebaseAuth SignOut
   Future firebaseSignOut(context) async {
    //sign out from firebase
    _auth.signOut().catchError((onError) {
      // display error in a dialog box
      showDialog(
          context: context,
          builder: (context) => dialogBox(
            context,
                onError.toString(),
                'FireBase SignOut',
                DialogType.error,
              ));
    });
  }
}
