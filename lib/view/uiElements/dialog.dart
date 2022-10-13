
import '../../../model/imports/generalImport.dart';

Widget customDialog( child, { Alignment? align,double? x, double? y,}) {
  return Align(
    alignment: align??Alignment(x!, y!),
    // for y -1 to 1 (from top to bottom)
    // for x -1 to 1 (from left to right)
    child: Material(
      color: black51,
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: child
      ),

    ),
  );
}
