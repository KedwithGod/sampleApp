



import '../../model/imports/generalImport.dart';

class DropDown extends StatelessWidget {
  final List<String> itemList;
  final String? validatorText;
  final String? dropDownValue;
  final FocusNode? focusNode;
  final DropDownEnum updateValue;
  final Color? textColor,iconColor,borderColor;
  final Map<String,Color>? containerColor;


   DropDown(Key key,this.itemList,
      {this.validatorText,  this.dropDownValue,this.borderColor,
        this.focusNode,required this.updateValue,
        this.textColor, this.iconColor,
        this.containerColor});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuickOrderViewModel>.reactive(
        onModelReady: (model){
          if(updateValue==DropDownEnum.lang)model.updateDropDown();
          if(updateValue==DropDownEnum.category)model.updateCategoryDropDown();
          if(updateValue==DropDownEnum.product)model.updateProductDropDown();
        },
        disposeViewModel: false,
        viewModelBuilder:()=>QuickOrderViewModel(),
        builder: (context, model, child)=>

            FormField(
                key:UniqueKey(),
                builder: (FormFieldState<dynamic> field) {
                  return Container(
                    padding: const EdgeInsets.only(left: 16, right: 16.0),
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.all(
                            Radius.circular(sS(context).cH(height: 10),)
                        ),color: white,
                        border: Border.all(
                            color:borderColor?? primary
                        )
                    ),

                    child:  DropdownButtonHideUnderline(
                      child: DropdownButton(
                        icon:Padding(
                          padding:  EdgeInsets.only(right: sS(context).cW(width: 16.08)),
                          child: GeneralIconDisplay(LineIcons.angleDown,iconColor??secondaryColor,UniqueKey(),15),
                        ),
                        focusNode: focusNode,
                        dropdownColor: white,
                        focusColor:primary,
                        isExpanded: true,
                        style:  TextStyle(color:secondaryColor, fontSize: sS(context).cH(height: 12),fontWeight: FontWeight.w400),
                        value: updateValue==DropDownEnum.category?model.categoryString:
                        updateValue==DropDownEnum.product?model.productString:model.currencyString,
                        items: itemList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                  width: sS(context).cW(width:343),
                                  height:sS(context).cH(height: 40),
                                  alignment: Alignment.centerLeft,
                                  color: containerColor==null?white:containerColor![value],
                                  child: GeneralTextDisplay(value, textColor??secondaryColor, 1, 12, FontWeight.w500, ''))
                          );
                        })
                            .toList(),
                        onChanged: (value) {

                          if(updateValue==DropDownEnum.category) {
                            model.updateCategoryDropDownValue(value as String,context);
                          }
                          else if(updateValue==DropDownEnum.lang) {
                            model.updateLangDropDownValue(value as String);
                          }
                          else if(updateValue==DropDownEnum.product) {
                            model.updateQOProductDropDown(value as String);
                          }
                        },

                      ),
                    ),
                  );
                },
                validator: (val) {
                  return val != '' ? null : validatorText;
                }  )
    );
  }
}

