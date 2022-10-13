import '../../../model/imports/generalImport.dart';

Widget menuButton(context,{required String image, required String text,
required double top, double? left, double? right
}){
  return rowPositioned(
    child: Container(
      width: sS(context).cW(width: 100),
      height: sS(context).cH(height: 100),
      decoration: BoxDecoration(
          color: primary.withOpacity(0.5),
          borderRadius: BorderRadius.all(
              Radius.circular(
                  sS(context).cH(height: 16)))),
      child: Stack(
        children: [
          // icon
          AdaptivePositioned(
            Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                Container(
                  width: sS(context).cW(width: 32),
                  height:
                  sS(context).cH(height: 32),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        sS(context).cH(height: 10),
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Image.asset(
                      "assets/$image.png"),
                ),
              ],
            ),
            left: 16,
            top: 16,
          ),
          // text
          AdaptivePositioned(
            Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children:  [
                GeneralTextDisplay(
                  text,
                  white,
                  2,
                  11,
                  FontWeight.w400,
                  "text",
                  letterSpacing: 0.8,
                ),
              ],
            ),
            left: 16,
            top: 69,
          ),
        ],
      ),
    ),
    top: top,
    left: left,
    right: right
  );
}