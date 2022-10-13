import '../../../model/imports/generalImport.dart';

Widget buttonWidget({required String text,required Function onPressed,double? width,
Color? textColor, Color? buttonColor,bool? noElevation,double? radius,
}){
  return
    ButtonWidget((){onPressed();}, buttonColor??primary, width??327, 52,
        GeneralTextDisplay(text, textColor??secondaryColor, 1, 16, FontWeight.w600, "button")
        , Alignment.center,radius?? 8,noElevation:noElevation??false,);

}