import 'package:ecommerce/model/imports/generalImport.dart';


class SignUpViewModel extends BaseModel{
  //  text field controller
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController(); 
   TextEditingController fullNameController = TextEditingController();
  // bool to check for error in text field
   bool emailError = false;
   bool passwordError = false; 
   bool fullNameError = false;
  // focus node
   FocusNode emailFocusNode = FocusNode();
   FocusNode passwordFocusNode = FocusNode();
   FocusNode fullNameFocusNode = FocusNode();
   // ? function and parameters for obscure text
   bool showText=true;

   showTextFunction(){
     showText=!showText;
     notifyListeners();
   }

   // valid email as user types in, using the unchanged value from the
   // generalTextField
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
// onChanged function for first name
  bool validateFullName(){
     List list=fullNameController.text.trim().split(" ");
     if(list.length==2){
       return true;
     }
     else {
       return false;
     }
  }
  // function to check if full name contains first and last name

  onChangedFunctionFullName(){
    if(
    fullNameController.text.length>=4
        && validateFullName()==true){
      fullNameError=false;
      notifyListeners();
    }
    else{

      fullNameError=true;
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
// Sign Up user through firebase
firebaseSignUp(BuildContext context)async{
    try{
      if (fullNameController.text.length <= 2) {
        print('there is error');
        fullNameError = true;
        fullNameFocusNode.requestFocus();
        notifyListeners();
      }
      else if (!validateEmail.isValidEmail(emailController.text.trim())) {
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
                "Please wait, we are setting Up your account",
                'SignUp',
                DialogType.processing,
                function: () {},
                dismissText: "",
              );
            });

        // sign user in and save user data
        await FireBaseAuthClass.fireBaseCreateUser(
            fullName: fullNameController.text.trim(),
            email: emailController.text.trim(),
            userPassword: passwordController.text.trim(),
            context: context);
      }
    }
     on FirebaseAuthException catch(signUpError){
      Navigator.pop(context);
      // show dialog for SignUp Error
      showDialog(context: context,
          barrierDismissible: false,builder: (context){
        return dialogBox(context,getMessageFromErrorCode(signUpError),
            'SignUp Error',DialogType.error );
      });
    }
    on SocketException catch (error){
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => dialogBox(context,
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
// Sign Up user through google
googleSignUp(BuildContext context)async{
    try{
      // show dialog processing request
      showDialog(context: context, builder: (context){
        return dialogBox(context,"Please wait, we are setting Up your account",
          'SignUp',DialogType.processing,function: (){},dismissText: "", );
      });
      googleSigning.googleSignUp(context);
    }
    on SocketException catch (error){
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
    }
     catch(signUpError){
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return dialogBox(context,getMessageFromErrorCode(signUpError), 'SignUp Error',DialogType.error );
      });
    }

  }
// Sign Up user through apple id
appleSignUp(BuildContext context)async{
    try{

    }
    on SocketException catch (error){

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
    }
     catch(signUpError){
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return dialogBox(context,getMessageFromErrorCode(signUpError), 'SignUp Error',DialogType.error );
      });
    }
  }
// Sign Up user through phone number
phoneAuthentication(BuildContext context)async{
    try{

    }
    on SocketException catch (error){
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
    }
     catch(signUpError){
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return dialogBox(context,getMessageFromErrorCode(signUpError), 'SignUp Error',DialogType.error );
      });
    }
  }
// Sign Up user through facebook 
facebookSignUp(BuildContext context)async{
    try{

    }
    on SocketException catch (error){
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
    }
     catch(signUpError){
      // show dialog for SignUp Error
      showDialog(context: context, builder: (context){
        return dialogBox(context,getMessageFromErrorCode(signUpError), 'SignUp Error',DialogType.error );
      });
    }
  }

  // continue as a guest
  continueAsGuest(BuildContext context) async {
    await LocalStorage.setBool(guestUser, true).then((value) {
      saveDeviceId();
      Navigator.pushNamed(context, '/homePage');
    });
  }
}

// Dare@gmail.com Darey0009&&&