import 'package:ecommerce/model/imports/generalImport.dart';

class LoginViewModel extends BaseModel {
  //  text field controller
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();

  // bool to check for error in text field
   bool emailError = false;
   bool passwordError = false;

  // focus node
   FocusNode emailFocusNode = FocusNode();
   FocusNode passwordFocusNode = FocusNode();

  String requestError = "";

  // ? function and parameters for obscure text
  bool showText=true;

  showTextFunction(){
    showText=!showText;
    notifyListeners();
  }
  onChangedFunctionEmail(){
    if(validateEmail.isValidEmail(emailController.text.trim())){
      emailError=false;
      notifyListeners();
    }
    else{
      emailError=true;
      notifyListeners();
    }
  }
  onChangedFunctionPassword(){
    if(isValidPassword(passwordController.text.trim())){
      passwordError=false;
      notifyListeners();
    }
    else{
      passwordError=true;
      notifyListeners();
    }
  }
  

  // login user from website

  /*woocommerceUser(context)async {
     // find user using password and email address from all customer
    await AllWooCommerceUser.fetchListOfCustomers(email: emailController.text.trim(),
        password: passwordController.text.trim()).then((value)async{
          if (value is UserResponse){
            // store id in shared preference
           await LocalStorage.setInt(wooCommerceId, value.id);
           // change as guest to false
           await LocalStorage.setBool(guestUser, false);
            Navigator.pushNamed(context, '/homePage');
          }

          else if(value is WooCommerceErrorResponse){
            requestError=value.message;
            notifyListeners();
          }
    });


  }*/

  // login user through firebase
  firebaseLogin(BuildContext context) async {
    try {
      if (!validateEmail.isValidEmail(emailController.text.trim())) {
        emailError = true;
        emailFocusNode.requestFocus();
        notifyListeners();
      }
      else if (!isValidPassword(passwordController.text.trim())) {
        passwordError = true;
        passwordFocusNode.requestFocus();
        notifyListeners();
      }
      else{
        // show dialog processing request
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return dialogBox(context,
                "Please wait, we are checking for your account",
                'Login',
                DialogType.processing,
                function: () {},
                dismissText: "",
              );
            });

        FireBaseAuthClass().firebaseSignIn(emailController.text.trim(),
            passwordController.text.trim(), context);
      }
    } on SocketException catch (error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(
               context, "Looks like you have a bad internet connection, kindly check and try again",
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
    } on FirebaseAuthException catch (loginError) {
      Navigator.pop(context);
      // show dialog for login Error
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return dialogBox(context,getMessageFromErrorCode(loginError), 'Login Error',
                DialogType.error,  function: () {
                // if the error message contains email, it is likely the email
                // is incorrect

                // if the error message contains login, it is likely to go to login pag
                Navigator.pop(context);
              },);
          });
    }
  }

  // login user through google
  googleLogin(BuildContext context) async {
    try {
      googleSigning.googleSignIn(context);
    } on SocketException catch (error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => dialogBox(
                context,"Looks like you have a bad internet connection, kindly check and try again",
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
    } catch (loginError) {
      Navigator.pop(context);
      // show dialog for login Error
      showDialog(
          context: context,
          builder: (context) {
            return dialogBox(context,getMessageFromErrorCode(loginError), 'Login Error',
                DialogType.error);
          });
    }
  }

  // login user through apple id
  appleLogin(BuildContext context) async {
    try {} on SocketException catch (error) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(
                context,"Looks like you have a bad internet connection, kindly check and try again",
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
    } catch (loginError) {
      // show dialog for login Error
      showDialog(
          context: context,
          builder: (context) {
            return dialogBox(context,getMessageFromErrorCode(loginError), 'Login Error',
                DialogType.error);
          });
    }
  }

  // login user through phone number
  phoneLogin(BuildContext context) async {
    try {} on SocketException catch (error) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(
                context,"Looks like you have a bad internet connection, kindly check and try again",
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
    } catch (loginError) {
      // show dialog for login Error
      showDialog(
          context: context,
          builder: (context) {
            return dialogBox(context,getMessageFromErrorCode(loginError), 'Login Error',
                DialogType.error);
          });
    }
  }

  // login user through facebook
  facebookLogin(BuildContext context) async {
    try {} on SocketException catch (error) {
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(
               context, "Looks like you have a bad internet connection, kindly check and try again",
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
    } catch (loginError) {
      // show dialog for login Error
      showDialog(
          context: context,
          builder: (context) {
            return dialogBox(context,getMessageFromErrorCode(loginError), 'Login Error',
                DialogType.error);
          });
    }
  }

  // continue as a guest
  continueAsGuest(context) async {
    await LocalStorage.setBool(guestUser, true).then((value) {
      saveDeviceId();
      print(Nonce.secure(12));
      Navigator.pushNamed(context, '/homePage');
    });
  }
}
