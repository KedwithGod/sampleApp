import '../../../model/imports/generalImport.dart';
// * this function creates a combination of the text and
// * text field used in the project
Widget textAndTextField(context,{
  required TextInputType textInputType,
  required TextEditingController controller,
  required String hint,required String labelText,
  required Function onChanged,
  required List<TextInputFormatter> inputFormatter,
  required bool errorTextActive,
  required FocusNode focusNode,
  required Widget? prefix,
  required Widget? suffix,
  bool? obscureText,
  Color? borderColor,
  double? width,

}){
  return
            FormattedTextFields(
              labelText: labelText,
              keyInputType: textInputType,
              textFieldController: controller,
              textFieldHint: hint,
              textFieldLineSpan: 1,
              height: 52, width:width?? 327,
              containerColor: white,
              noBorder: false, autoFocus: false,
              inputFormatters: inputFormatter,
              onChangedFunction: onChanged,
              errorTextActive: errorTextActive,
              focusNode: focusNode,
              prefixIcon: prefix,
              prefix: null,
              suffixIcon: null,
              suffix: suffix,
              textFont: 15,
              hintFont: 14,
              borderRadius: 10,
              cursorColor: normalBlack,
              obscureText: obscureText??false,
              hintColor: grey,
              outLineBorderColor: secondaryColor,
              focusBorderColor:errorTextActive?transparent: white,
              textFontWeight: FontWeight.w500,
              hintFontWeight: FontWeight.w400,

              contentPadding: EdgeInsets.only(
                  left:sS(context).cW(width: 16), right:sS(context).cW(width: 16),
                  top: sS(context).cH(height: 16),bottom: sS(context).cH(height: 15)
              ),);
}