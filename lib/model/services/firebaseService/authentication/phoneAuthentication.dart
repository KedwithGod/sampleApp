


import 'package:ecommerce/model/imports/generalImport.dart';

class PhoneAuthenticationService{
   final FirebaseAuth _auth = FirebaseAuth.instance;
   bool? onVerify;
   bool? timeOut;
   var user;
   String? smsCode;
  // phone number verification
  Future fireBasePhoneVerification(context,{required String phoneNumber,otpCode}) async {

  // phone number onVerification completed method

   onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    if (authCredential.smsCode != null) {
      try{
        otpCode==authCredential.smsCode!?onVerify=true:false;
        onVerify==true?true:null;

        /*UserCredential credential =
        await user!.linkWithCredential(authCredential);*/
      }on FirebaseAuthException catch(e){
        if(e.code == 'provider-already-linked'){
       /*   await _auth.signInWithCredential(authCredential);*/
          print('verification error ${e.code}');
        }
      }

  }}


  final PhoneVerificationCompleted verificationCompleted = (AuthCredential credential) {
    print("verified");
  };

// and if your number doesn't exist or doesn't match with your country code,Then this will show you an error message

    final PhoneVerificationFailed verfifailed=(FirebaseAuthException exception){
      print("${exception.message}");
      //Fluttertoast.showToast(msg: "${exception.message}"); //
    };

  // onVerification failed method
  onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
     // change the text in the phone Otp page
      onVerify=false;
      // navigate to enter phone number
    }


}
// onDode sent
  onCodeSent(String verificationId, int? forceResendingToken) async{
    smsCode=PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpCode).smsCode;
    print('i am onVerify from code sent$smsCode');
    print(forceResendingToken);
    print("code sent");
     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpCode!=null?otpCode:'');

    // Sign the user in (or link) with the credential
    user=await _auth.signInWithCredential(credential);
  }

  // oc Code timeout
  onCodeTimeout(String timeout) {
    print('code timeOut $timeout');
    timeOut=true;
    // display resend otp
    return null;
  }
   await _auth.verifyPhoneNumber(
   phoneNumber:phoneNumber,
   verificationCompleted: onVerificationCompleted,
   verificationFailed: onVerificationFailed,
   codeSent: onCodeSent,
   codeAutoRetrievalTimeout: onCodeTimeout);
  return onVerify;

  // testing how to verify no

}}
