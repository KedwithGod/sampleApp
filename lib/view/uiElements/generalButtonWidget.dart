

import '../../model/imports/generalImport.dart';

class ButtonWidget extends StatelessWidget {
  final dynamic onPressed;
  final dynamic color;
  final double width;
  final double height;
  final Widget child;
  final Alignment align;
  final double radius;
  final FocusNode? focusNode;
  final bool? noElevation;
  final bool? addBorder;

  ButtonWidget(this.onPressed, this.color, this.width, this.height, this.child,
      this.align, this.radius,{this.focusNode, this.noElevation, this.addBorder});

  @override
  Widget build(BuildContext context) {
    Size dynamicSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return ElevatedButton(
      focusNode: focusNode ?? FocusNode(),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            primary: color,
            elevation: noElevation==true?0.0:4.0,
            alignment: align,
            side:addBorder==true? BorderSide(
              color: primary
            ):BorderSide.none,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular( dynamicSize.height * (radius / 768)),
            ),
            fixedSize: Size(
                orientation == Orientation.portrait
                    ? dynamicSize.width * (width / 375)
                    : dynamicSize.height * (width / 375),
                orientation == Orientation.landscape
                    ? dynamicSize.width * (height / 768)
                    : dynamicSize.height * (height / 768))),
        child: child);
  }
}
