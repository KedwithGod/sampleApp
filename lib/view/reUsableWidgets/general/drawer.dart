

import '../../../model/imports/generalImport.dart';

Widget drawer (context,{required Widget child,AdvancedDrawerController? controller,
  required bool? asGuest}){
print("i am guest $asGuest");
  return AdvancedDrawer(
    backdropColor: desertStorm,
    controller:controller,
    animationCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 300),
    animateChildDecoration: true,
    rtlOpening: false,
    // openScale: 1.0,
    disabledGestures: false,
    childDecoration: const BoxDecoration(
      // NOTICE: Uncomment if you want to add shadow behind the page.
      // Keep in mind that it may cause animation jerks.
      // boxShadow: <BoxShadow>[
      //   BoxShadow(
      //     color: Colors.black12,
      //     blurRadius: 0.0,
      //   ),
      // ],
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    child: child,
    drawer: SafeArea(
      child: S(
        h:768,
        w: 375,
        child:Stack(
          children: [
            // menu
            rowPositioned(
              child: GeneralTextDisplay("Menu", secondaryColor,
                  1, 19.08, FontWeight.w500, "500") ,top: 22,
              left: 24
            ),
            // account
            drawerItem(Icons.home, "Home", 78,onTap:(){
              Navigator.pushNamed(context, '/homePage',
              );
            }),

            // logout
            drawerItem(Icons.account_box_rounded,asGuest==true?"Login":"Logout", 126,onTap: ()async{
              if(asGuest==true){
                // set guest mode to false
                await LocalStorage.setBool(guestUser, false);
                Navigator.pushNamed(context, '/login',
                );
              }
              // check sign in method and logout appropriately
              String? signIn=await LocalStorage.getString(signInMethod);
              print("i am sign in $signIn");
              if(signIn==firebaseAuth){
                // set firebase id to ""
                await LocalStorage.setString('firebaseId',"");
                // set woo commerce id to ""
                await LocalStorage.setString(wooCommerceId,"");
                FireBaseAuthClass().firebaseSignOut(context);
                Navigator.pushNamed(context, '/login',
                );
              }

              else if (signIn==googleAuthMethod){
                // set firebase id to ""
                await LocalStorage.setString('firebaseId',"");
                // set woo commerce id to ""
                await LocalStorage.setString(wooCommerceId,"");
                googleSigning.googleSignOut(context);
                Navigator.pushNamed(context, '/login',
                );
              }

            }),
            // account
            drawerItem(Icons.favorite, "My Wish List", 174,onTap:(){
              Navigator.pushNamed(context, '/favoritePage',
              );
            }),
            // statement
            drawerItem(FontAwesomeIcons.list, "Categories", 222,
                onTap:(){
                  Navigator.pushNamed(context, '/categoryHomePage');

    }),
            // link account
            drawerItem(FontAwesomeIcons.globe, "Languages", 318),
            // security
            drawerItem(Icons.money, "Currencies", 270),
            //  referral
            drawerItem(FontAwesomeIcons.moon, "Dark theme", 362),
            // terms of use
            drawerItem(Icons.star, "Rate the application", 414),

            // terms of use
            drawerItem(FontAwesomeIcons.key, "Privacy and Term", 462),

            drawerItem(Icons.info, "About Us", 510),

            // sign out
           // drawerItem(Icons.logout_rounded, "Sign Out", 622,color:const Color.fromRGBO(255,41,41,1)),
            // version
            rowPositioned(child:  GeneralTextDisplay("Ver 1.0.0", secondaryColor.withOpacity(0.5),
                1, 14, FontWeight.w500, "version",letterSpacing: 0.8,), top: 657,left:24)
          ],
        ) ,
      ),
    ),

  );
}


Widget drawerItem(IconData icon,String name,double top, {Color? color,Function? onTap}){
  return  rowPositioned(
      child: GestureDetector(
        onTap: (){
          onTap!();
        },
        child: Row(
          children: [
            Center(child: GeneralIconDisplay(icon, color??primary, UniqueKey(), 16))
            ,
            S(w:14),
             GeneralTextDisplay(name, color??secondaryColor,
                1, 14, FontWeight.w500, "text",letterSpacing: 0.8,),
          ],
        ),
      ) ,top: top,
      left: 24
  );
}