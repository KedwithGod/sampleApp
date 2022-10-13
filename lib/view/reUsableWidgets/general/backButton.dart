// this is a general back button for the pages


import 'package:ecommerce/model/imports/generalImport.dart';

Widget backButton(context, { double top= 28,  double left= 17,Color? color,Color? arrowColor,double? size,
String? navigateTo,Function? navigator
}) {
  return Stack(
    children: [
      AdaptivePositioned(
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                if(navigator!=null){
                  navigator();
                }
               else {
                  navigateTo != null
                      ? Navigator.pushNamed(context, navigateTo)
                      : Navigator.pop(context);
                }
              },
              child: Container(
                height: sS(context).cH(height:size?? 40),
                width: sS(context).cW(width:size?? 40),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color:color?? primary.withOpacity(0.1)),
                child: GeneralIconDisplay(
                    LineIcons.arrowLeft, arrowColor??primary, UniqueKey(), 20),
              ),
            ),
          ],
        ),
        top: top,
        left: left,
      ),
    ],
  );
}
