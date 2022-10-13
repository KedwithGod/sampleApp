
import '../../../model/imports/generalImport.dart';

Widget customDialog( child, { Alignment? align,double? x, double? y,}) {
  return Align(
    alignment: align??Alignment(x!, y!),
    // for y -1 to 1 (from top to bottom)
    // for x -1 to 1 (from left to right)
    child: Material(
      color: white,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: child
      ),

    ),
  );
}
loadingNoScheduleDialog(BuildContext context,{
  required String text, Color? color
})async{
  return   showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: S(
        h:200,w:250,
        child: customDialog(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading(
                    color: color
                ),
                S(h:20),
                GeneralTextDisplay(
                  text,
                  normalBlack, 3, 14, FontWeight.w500, "",
                  textAlign: TextAlign.center,)
              ],
            ),
            align: Alignment.center),
      ),
    ),);
}

// loading dialog
loadingDialog(BuildContext context,{
  required String text, Color? color
})async{
  return  SchedulerBinding.instance?.addPostFrameCallback((_) =>  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: S(
        h:200,w:300,
        child: customDialog(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                loading(
                    color: color
                ),
                S(h:20),
                GeneralTextDisplay(
                  text,
                  normalBlack, 3, 14, FontWeight.w500, "",
                  textAlign: TextAlign.center,)
              ],
            ),
            align: Alignment.center),
      ),
    ),),);
}

// dialog with close
loaderWithClose(BuildContext context,{
  required String text,  String? buttonText,IconData? icon,Function? onTap,Color? iconColor}){
  return  SchedulerBinding.instance?.addPostFrameCallback((_) =>  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: S(
        h:220,w:300,
        child: customDialog(
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GeneralIconDisplay(icon??Icons.error, iconColor??Colors.red, UniqueKey(), 50),
                S(h:20),
                GeneralTextDisplay(
                  text,
                  normalBlack, 6, 14, FontWeight.w500, "",
                  textAlign: TextAlign.center,),
                S(h:15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    GestureDetector(
                      onTap:(){
                        onTap==null? Navigator.pop(context):
                        onTap()
                        ;

                      },
                      child: GeneralTextDisplay(
                        buttonText??"close",
                        petiteOrchid, 3, 14, FontWeight.w400, "",
                      ),
                    ),
                  ],
                )
              ],
            ),
            align: Alignment.center),
      ),
    ),),);
}