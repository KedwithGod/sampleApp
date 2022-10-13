import 'package:ecommerce/model/imports/generalImport.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
        onModelReady: (model) {},
        disposeViewModel: false,
        viewModelBuilder: () => SignUpViewModel(),
        builder: (context, model, child) => baseUi(children: [
              // logo
              rowPositioned(
                  child: S(
                      h: 200,
                      w: 200,
                      child: Hero(
                          tag: "appLogo",
                          child: Image.asset("assets/appLogo.jpeg"))),
                  top: 10),
              // login to
              rowPositioned(
                  child: GeneralTextDisplay("SignUp to Cardizerr",
                      secondaryColor, 1, 20, FontWeight.w700, "login"),
                  top: 200),
              // sign up
              rowPositioned(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    child: Row(
                      children: [
                        GeneralTextDisplay("Already have an account? ", black51,
                            1, 16, FontWeight.w400, "login"),
                        GeneralTextDisplay(
                            "Login", primary, 1, 16, FontWeight.w600, "login"),
                      ],
                    ),
                  ),
                  top: 240),
              // social button
              rowPositioned(
                  child: Row(
                    children: [
                      // facebook
                      Container(
                        width: sS(context).cW(width: 40),
                        height: sS(context).cH(height: 40),
                        decoration: BoxDecoration(
                            color: Color(int.parse("0xff041F60")),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 12,
                                  color: petiteOrchid.withOpacity(0.3))
                            ]),
                        alignment: Alignment.center,
                        child: GeneralIconDisplay(
                            FontAwesomeIcons.facebookF, white, UniqueKey(), 20),
                      ),
                      // google
                      S(w: 15),
                      GestureDetector(
                        onTap: () {
                          model.googleSignUp(context);
                        },
                        child: Container(
                          width: sS(context).cW(width: 40),
                          height: sS(context).cH(height: 40),
                          decoration: BoxDecoration(
                              color: error,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 12,
                                    color: petiteOrchid.withOpacity(0.3))
                              ]),
                          alignment: Alignment.center,
                          child: GeneralIconDisplay(
                              FontAwesomeIcons.googlePlusG,
                              white,
                              UniqueKey(),
                              20),
                        ),
                      ),
                      //apple
                      S(w: 15),
                      Container(
                        width: sS(context).cW(width: 40),
                        height: sS(context).cH(height: 40),
                        decoration: BoxDecoration(
                            color: black51,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 12,
                                  color: petiteOrchid.withOpacity(0.3))
                            ]),
                        alignment: Alignment.center,
                        child: GeneralIconDisplay(
                            FontAwesomeIcons.apple, white, UniqueKey(), 20),
                      ),
                    ],
                  ),
                  top: 280),
              // or
              rowPositioned(
                  child: GeneralTextDisplay(
                      "or", regentGray, 1, 15, FontWeight.w500, "or"),
                  top: 340),


              Positioned(
                  child: SingleChildScrollView(
                    child: S(
                      h: 1300,
                      w: 327,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          S(h:5),
                          // full name
                          textAndTextField(context,
                              textInputType: TextInputType.text,
                              controller: model.fullNameController,
                              hint: "Surname space first name",
                              labelText: "Full Name",
                              onChanged: () {
                                  model.onChangedFunctionFullName();
                              },
                              inputFormatter: [],
                              errorTextActive: model.fullNameError,
                              focusNode: model.fullNameFocusNode,
                              prefix: GeneralIconDisplay(
                                  Icons.person, primary, UniqueKey(), 20),
                              suffix: null),
                          S(h: 15,),

                if(model.fullNameError==true)
                  Column(
                    children: [
                      GeneralTextDisplay(
                          model.fullNameController.text.isEmpty?
                          'Empty Field, enter full name!':'Please enter surname followed by space and your first name!', Colors.red, 2,
                          12, FontWeight.w600, 'saving data',textAlign: TextAlign.center,),
                      S(h:15),
                    ],
                  ),
                          // email
                          textAndTextField(context,
                              textInputType: TextInputType.text,
                              controller: model.emailController,
                              hint: "Enter email Address",
                              labelText: "Email",
                              onChanged: () {
                                model.onChangedFunctionEmail();
                              },
                              inputFormatter: [],
                              errorTextActive: model.emailError,
                              focusNode: model.emailFocusNode,
                              prefix: GeneralIconDisplay(
                                  Icons.email, primary, UniqueKey(), 20),
                              suffix: null),
                          S(h: 15,),
                          if(model.emailError==true) Column(
                            children: [
                              GeneralTextDisplay(
                                  model.emailController.text.isEmpty?
                                  'Empty Field, enter email address!':'Please enter a valid email address!',error, 1,
                                  12, FontWeight.w400, 'email'),
                              S(h:15),
                            ],
                          ),
                          // password
                          textAndTextField(context,
                              textInputType: TextInputType.text,
                              controller: model.passwordController,
                              hint: "Enter a secured password",
                              labelText: "Password",
                              onChanged: () {
                                model.onChangedFunctionPassword();
                              },
                              inputFormatter: [],
                              obscureText: model.showText,
                              errorTextActive: model.passwordError,
                              focusNode: model.passwordFocusNode,
                              prefix: GeneralIconDisplay(
                                  Icons.lock, primary, UniqueKey(), 20),
                              suffix: GestureDetector(
                                  onTap: () {
                                    model.showTextFunction();
                                  },
                                  child: GeneralIconDisplay(
                                      model.showText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      primary,
                                      UniqueKey(),
                                      18))),
                          S(h: 20,),
                          if(model.passwordError==true)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    S(h:60,
                                      w: 325,
                                      child: GeneralTextDisplay(
                                        model.passwordController.text.isEmpty?
                                        'Empty Field, enter password!':
                                        !isValidPassword(model.passwordController.text.trim())?
                                        'Invalid password, Length must be more than 7 and contains lower case, upper case , digit and  symbol':"", Colors.red, 4,
                                        12, FontWeight.w600, 'saving data',textAlign: TextAlign.center,),
                                    ),
                                  ],
                                ),
                                S(h:15),
                              ],
                            ),
                          // sign up
                         buttonWidget(
                                  text: "SignUp",
                                  onPressed: () {
                                    model.firebaseSignUp(context);
                                  },
                                  radius: 20,
                                  textColor: white),

                          // continue as guest
                          S(h:10),
                         ButtonWidget(
                                    () {
                                  model.continueAsGuest(context);
                                },
                                white,
                                200,
                                20,
                                GeneralTextDisplay("Continue as guest", regentGray, 1, 13,
                                    FontWeight.w400, "skip for now"),
                                Alignment.center,
                                0,
                                noElevation: true,
                              ),

                        ],
                      ),
                    ),
                  ),
                  top: sS(context).cH(height: 385),
              left: sS(context).cW(width: 25),
                right: sS(context).cW(width: 25),
                  bottom: sS(context).cH(height: 20)
              ),



            ], allowBackButton: false));
  }
}
