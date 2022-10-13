
import 'package:ecommerce/model/imports/generalImport.dart';

Widget baseUi(
    {required List<Widget> children, required bool allowBackButton,Color? color}
    ){
  return WillPopScope(
      onWillPop: () async {
        return allowBackButton;
      },child:SafeArea(
      top: true,
        bottom: false,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            color:color?? white,
            child: Stack(
              children: children,
            ),
          ),
        ),
      ));
}