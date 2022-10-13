import 'package:ecommerce/model/imports/generalImport.dart';



  dialogBox(BuildContext context, String message,String title,DialogType dialogType,{ int? messageLineNo,
    String? dismissText,Function? function,
    Color? dismissTextColor,String? optionalButtonText,Function? optionButtonFunction,bool? optionButtonToggle=false
  }) {
return AlertDialog(
          title: Center(
            child: GeneralTextDisplay(title, Colors.black,
                1, 24, FontWeight.w400,title),
          ),
          content:  GeneralTextDisplay(message, secondaryColor,
              messageLineNo??5, 15, FontWeight.w300,message),
          actions: [
            dialogType==DialogType.notification?Center(
              child: Image.asset('assets/notification.png',height: sS(context).cH(height: 80),
                width: sS(context).cW(width: 80),),
            ):
            dialogType==DialogType.error?Center(
              child: Image.asset('assets/error.png',height: sS(context).cH(height: 80),
                width:  sS(context).cW(width: 80),),
            ):Center(child: loading(width: 80,height: 80))
            ,
            GestureDetector(
              onTap:function==null?(){Navigator.pop(context);}:function(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GeneralTextDisplay(dismissText??'close',
                    dismissTextColor??Colors.red,
                    1, 15, FontWeight.w400,''),
              ),
            ),
            if(optionButtonToggle==true)GestureDetector(
              onTap:optionButtonFunction!(),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GeneralTextDisplay(optionalButtonText!, Colors.green,
                    1, 15, FontWeight.w400,''),
              ),
            ),
          ],
        );}
