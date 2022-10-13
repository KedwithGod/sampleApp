// this is a sized box class


import 'package:ecommerce/model/imports/generalImport.dart';

class S extends StatelessWidget {
  // h is height, w is width
  final double? h,w;
  final  Widget? child;

  S({Key? key, this.h=0, this.w=0, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: sS( context).cW(width: w),
      height:  sS(context).cH(height: h),
      child: child??Container(),
    );
  }
}