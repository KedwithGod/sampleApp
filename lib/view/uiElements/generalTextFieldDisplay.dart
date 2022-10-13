

import 'package:ecommerce/model/imports/generalImport.dart';


// this textField is for otp textField
class PinTextField extends StatelessWidget {
  final TextInputType keyInputType;
  final TextEditingController textFieldController;
  final int textFieldLineSpan;
  final String textFieldLabel;
  final String textFieldHint;
  final dynamic functionValue;
  final double height;
  final double width;
  final Color containerColor;
  final bool greyBackground;
  final FocusNode focus;
  final Function onFieldSubmitted;
  final int maxIndex;
  final bool errorTextActive;

  const PinTextField(
    this.keyInputType,
    this.textFieldController,
    this.textFieldLabel,
    this.textFieldHint,
    this.functionValue,
    this.textFieldLineSpan,
      this.height, this.width,
      this.containerColor, this.greyBackground,
      this.focus, this.onFieldSubmitted, this.maxIndex,{
      this.errorTextActive=false
  }
  );



  @override
  Widget build(BuildContext context) {
    Size dynamicSize = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      height:sS(context).cH(height: height),
      width:sS(context).cW(width: width),
      decoration: BoxDecoration(
        color:secondaryColor,
        borderRadius: BorderRadius.circular( MediaQuery.of(context).size.height * (4/ 768)),
          border: Border.all(
              color: errorTextActive==true?error:transparent,
              width: errorTextActive==true?2.0:0.0,
              style: BorderStyle.solid
          ),

      ),
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
          inputFormatters: [
             LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          cursorColor: secondaryColor,
          keyboardType: keyInputType,
          controller: textFieldController,
          maxLines: textFieldLineSpan,
          focusNode: focus,
          textInputAction:maxIndex==4?TextInputAction.done: TextInputAction.next,

          onChanged: (change){
           onFieldSubmitted();
          },
          style:  GoogleFonts.poppins(
            textStyle:TextStyle(
              color: normalBlack,
              fontSize: orientation == Orientation.portrait?
              sS(context).cH(height: 30):
              dynamicSize.width*(16/768),
              fontWeight: FontWeight.w500)),
          autocorrect: true,

          decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: textFieldLabel,
              hintStyle:  GoogleFonts.poppins(
             textStyle:TextStyle(
                  fontSize: orientation ==Orientation.portrait?
                  MediaQuery.of(context).size.height * (30 / 768):
                  dynamicSize.width*(16/768),
                  color: Colors.grey,
                  fontWeight: FontWeight.w500)),
              hintText: textFieldHint,
              labelStyle:  GoogleFonts.montserrat(
                 textStyle:TextStyle(
                  fontSize:  orientation ==Orientation.portrait?
                  MediaQuery.of(context).size.height * (15 / 768):
                  dynamicSize.width*(16/812),
                  color:  const Color.fromRGBO(186, 186, 186, 1.0),
                  fontWeight: FontWeight.w500)),
              contentPadding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * (19 /375 ),
                  MediaQuery.of(context).size.height * (2/ 768),
                  MediaQuery.of(context).size.width * (2 /375 ),
                  MediaQuery.of(context).size.height * (2 / 768)),
    border: OutlineInputBorder(
    borderSide:  BorderSide(
    color: primary,
    width: 1.0,
    style: greyBackground==true?BorderStyle.none:BorderStyle.solid),
    borderRadius:
    BorderRadius.circular( orientation ==Orientation.portrait?
    MediaQuery.of(context).size.height * (4 / 768):
    dynamicSize.width*(4/768),)),
    focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
    color: secondaryColor,
    width: 1.0,
    style: BorderStyle.solid),
    borderRadius:
    BorderRadius.circular( orientation ==Orientation.portrait?
    MediaQuery.of(context).size.height * (4 / 768):
    dynamicSize.width*(4/768),))
         ),
        ),
      ),
    );
  }
}
class FormattedTextFields extends StatelessWidget {
  final TextInputType keyInputType;
  final TextEditingController textFieldController;
  final int textFieldLineSpan;
  final String textFieldHint,labelText;
  final double height,width,textFont,
      hintFont,borderRadius;
  final Color containerColor,cursorColor,
      hintColor,outLineBorderColor,focusBorderColor;
  final bool? noBorder,autoFocus,obscureText;
  final Function? onChangedFunction;
  final List<TextInputFormatter> inputFormatters;
  final bool errorTextActive;
  final FocusNode? focusNode;
  final Widget? prefixIcon, suffixIcon,suffix;
  final Widget? prefix;
  final FontWeight textFontWeight,hintFontWeight;
  final EdgeInsets contentPadding;
  final FloatingLabelBehavior? floatingBehaviour;

  const FormattedTextFields(
      {required this.keyInputType,
        required this.textFieldController,
        required this.textFieldHint,
        required this.textFieldLineSpan,
        required this.height,required this.width,
        required this.containerColor,required this.noBorder,
        required this.autoFocus,
        required this.inputFormatters,
        required this.onChangedFunction,
        required this.errorTextActive,
        required this.focusNode,
        required this.prefixIcon,
        required this.prefix,
        required this.suffixIcon,required this.textFont,
        required this.hintFont,

        required this.borderRadius,
        required this.cursorColor,
        required this.hintColor,

        required this.outLineBorderColor,
        required this.focusBorderColor,
        required this.textFontWeight,
        required this.hintFontWeight,
        required this.labelText,
        required this.contentPadding,
        this.obscureText,this.suffix,this.floatingBehaviour}
      );




  @override
  Widget build(BuildContext context) {
    return Container(
      height:sS(context).cH(height: height),
      width:sS(context).cW(width: width),
      decoration: BoxDecoration(
          color:white,
          borderRadius: BorderRadius.circular( MediaQuery.of(context).size.height * (borderRadius/ 768)),
    ),
      alignment: Alignment.center,

      child: TextFormField(
        focusNode: focusNode??FocusNode(),
        onChanged:
            (changed){onChangedFunction!();},// this function to validate the
        // text field as the user types in it
        autofocus: autoFocus!,
        cursorColor: cursorColor,
        keyboardType: keyInputType,
        obscureText: obscureText??false,
        controller: textFieldController,
        maxLines: textFieldLineSpan,
        inputFormatters: inputFormatters,
        style:  GoogleFonts.montserrat(
            textStyle:TextStyle(
                color: textFieldText,
                fontSize: textFont,
                fontWeight: textFontWeight)),
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffix:suffix,
            prefix: prefix,
            labelText: labelText,
            labelStyle: GoogleFonts.montserrat(
                textStyle:TextStyle(
                    fontSize: sS(context).cH(height: hintFont),
                    color: secondaryColor,
                    fontWeight: hintFontWeight)),
            alignLabelWithHint: false,
            hintStyle:  GoogleFonts.montserrat(
                textStyle:TextStyle(
                    fontSize: sS(context).cH(height: hintFont),
                    color: hintColor,
                    fontWeight: hintFontWeight)),
            hintText: textFieldHint,

            contentPadding: contentPadding,
            floatingLabelBehavior: floatingBehaviour??FloatingLabelBehavior.auto,
            enabledBorder: OutlineInputBorder(
                borderSide:  noBorder==true?BorderSide.none:BorderSide(
                    color: textFieldText,
                    width: 1.0,
                    style: noBorder==true?BorderStyle.none:BorderStyle.solid),
                borderRadius:
                BorderRadius.circular(
                    sS(context).cW(width: borderRadius))),
            focusedBorder: OutlineInputBorder(
                borderSide: noBorder==true?BorderSide.none:  BorderSide(
                    color:errorTextActive?error:primary,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius:
                BorderRadius.circular( sS(context).cW(width: borderRadius)))
        ),
      ),
    );
  }
}
