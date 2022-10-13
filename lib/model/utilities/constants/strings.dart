// constants of string
// screen sizing

import 'package:ecommerce/model/imports/generalImport.dart';







ScreenSize sS(BuildContext context, )=>ScreenSize(context: context);

// class instances
ValidateEmailAddress validateEmail=ValidateEmailAddress();
ValidatePhoneNumber validatePhone=ValidatePhoneNumber();
UserServices userService=UserServices();
Faker fakeData=Faker();
PhoneAuthenticationService phoneAuthenticationService=PhoneAuthenticationService();
GoogleSigning googleSigning=GoogleSigning();
RandomString randomString=RandomString();

// plugin instances
FirebaseFirestore firebaseFireStore=FirebaseFirestore.instance;

// plugin instance
var unescape = HtmlUnescape();

// keys
String consumerKey="ck_39971a6abfbae154c5baf5d9f98e7b1155226b07";
String consumerSecret="cs_3d9d18991d087a8dfe7cca01e8b5d8f825b488fb";



// string names
// store registered user id
String wooCommerceId="wooCommerceId";
// store user as guest
String guestUser="guestUser";
String guestUserId='guestUserId';
String firebaseId='firebaseId';

// sign up method string
const String signInMethod="signInMethod";
const String firebaseAuth="firebaseAuth";
const String googleAuthMethod="googleAuth";
const String phoneAuth="phoneAuth";
const String appleAuth="appleAuth";
const String facebookAuth="facebookAuth";
