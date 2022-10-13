import 'package:ecommerce/model/imports/generalImport.dart';

class QuickOrderPage extends StatelessWidget {
  const QuickOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuickOrderViewModel>.reactive(
        viewModelBuilder: () => QuickOrderViewModel(),
        onModelReady: (model) async {
          model.guestStatus();
          // fetch category list
          model.fetchCategoryList(context, isQuickOrder: true);
          // update currency drop down
          model.updateDropDown();
          // fetch category of currency
          model.fetchCurrencyFunction(context);

        },
        disposeViewModel: false,
        builder: (context, model, child) => drawer(context,
            asGuest: model.asGuest,
            child: baseUi(children: [
              // menu
              rowPositioned(
                  child: GestureDetector(
                      onTap: () {
                        model.advancedDrawerController.showDrawer();
                      },
                      child: GeneralIconDisplay(
                          Icons.menu, secondaryColor, UniqueKey(), 20)),
                  top: 25,
                  left: 20),
              // title
              rowPositioned(
                child: GeneralTextDisplay("Quick Order", secondaryColor, 1, 20,
                    FontWeight.w600, "title"),
                top: 20,
              ),

              Stack(children: [
                // currency dropdown
                rowPositioned(
                    child: model.loadedCurrencyList!=null?
                    S(
                      w: 343,
                      h: 54,
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                              sS(context).cH(height: 10),
                            )),
                            color: white,
                            border: Border.all(color: primary)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: Padding(
                              padding: EdgeInsets.only(
                                  right: sS(context).cW(width: 16.08)),
                              child: GeneralIconDisplay(LineIcons.angleDown,
                                  secondaryColor, UniqueKey(), 15),
                            ),
                            dropdownColor: white,
                            focusColor: primary,
                            isExpanded: true,
                            style: TextStyle(
                                color: secondaryColor,
                                fontSize: sS(context).cH(height: 12),
                                fontWeight: FontWeight.w400),
                            value: model.loadedCurrencyString,
                            items: model.loadedCurrencyList!
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      width: sS(context).cW(width: 343),
                                      height: sS(context).cH(height: 40),
                                      alignment: Alignment.centerLeft,
                                      child: GeneralTextDisplay(
                                          value,
                                          secondaryColor,
                                          1,
                                          12,
                                          FontWeight.w500,
                                          '')));
                            }).toList(),
                            onChanged: (value) {
                              if(value=='Select Currency'){

                              }
                             else {
                                      model.updateCurrencyDropdown(
                                          value as String, context);
                                    }
                                  },
                          ),
                        ),
                      ),
                    ):S(
                      w: 343,
                      h: 54,
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                              sS(context).cH(height: 10),
                            )),
                            color: white,
                            border: Border.all(color: primary)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            icon: Padding(
                              padding: EdgeInsets.only(
                                  right: sS(context).cW(width: 16.08)),
                              child: GeneralIconDisplay(LineIcons.angleDown,
                                  secondaryColor, UniqueKey(), 15),
                            ),
                            dropdownColor: white,
                            focusColor: primary,
                            isExpanded: true,
                            style: TextStyle(
                                color: secondaryColor,
                                fontSize: sS(context).cH(height: 12),
                                fontWeight: FontWeight.w400),
                            value: model.currencyString,
                            items: model.currencyList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                      width: sS(context).cW(width: 343),
                                      height: sS(context).cH(height: 40),
                                      alignment: Alignment.centerLeft,
                                      child: GeneralTextDisplay(
                                          value,
                                          secondaryColor,
                                          1,
                                          12,
                                          FontWeight.w500,
                                          '')));
                            }).toList(),
                            onChanged: (value) {
                              model.updateCategoryDropDownValue(
                                  value as String, context);
                            },
                          ),
                        ),
                      ),
                    ),
                    top: 100),
                // category dropdown
                rowPositioned(
                    child: S(
                        w: 343,
                        h: 54,
                        child: Container(
                          padding: const EdgeInsets.only(left: 16, right: 16.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(
                                sS(context).cH(height: 10),
                              )),
                              color: white,
                              border: Border.all(color: primary)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: Padding(
                                padding: EdgeInsets.only(
                                    right: sS(context).cW(width: 16.08)),
                                child: GeneralIconDisplay(LineIcons.angleDown,
                                    secondaryColor, UniqueKey(), 15),
                              ),
                              dropdownColor: white,
                              focusColor: primary,
                              isExpanded: true,
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: sS(context).cH(height: 12),
                                  fontWeight: FontWeight.w400),
                              value: model.categoryString,
                              items: model.categoryDropDown
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                        width: sS(context).cW(width: 343),
                                        height: sS(context).cH(height: 40),
                                        alignment: Alignment.centerLeft,
                                        child: GeneralTextDisplay(
                                            value,
                                            secondaryColor,
                                            1,
                                            12,
                                            FontWeight.w500,
                                            '')));
                              }).toList(),
                              onChanged: (value) {
                                if(value=="Select Category"){

                                }
                                else{
                                  model.updateCategoryDropDownValue(
                                      value as String, context);
                                }
                              },
                            ),
                          ),
                        )),
                    top: 169),
              ]),

              // product drop down- shows only when category is selected
              rowPositioned(
                  child: S(
                    w: 343,
                    h: 54,
                    child: Container(
                      padding: const EdgeInsets.only(left: 16, right: 16.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(
                            sS(context).cH(height: 10),
                          )),
                          color: white,
                          border: Border.all(color: primary)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          icon: Padding(
                            padding: EdgeInsets.only(
                                right: sS(context).cW(width: 16.08)),
                            child: GeneralIconDisplay(LineIcons.angleDown,
                                secondaryColor, UniqueKey(), 15),
                          ),
                          dropdownColor: white,
                          focusColor: primary,
                          isExpanded: true,
                          style: TextStyle(
                              color: secondaryColor,
                              fontSize: sS(context).cH(height: 12),
                              fontWeight: FontWeight.w400),
                          value: model.productString,
                          items: model.productDropDown
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                    width: sS(context).cW(width: 343),
                                    height: sS(context).cH(height: 40),
                                    alignment: Alignment.centerLeft,
                                    child: GeneralTextDisplay(
                                        value,
                                        secondaryColor,
                                        1,
                                        12,
                                        FontWeight.w500,
                                        '')));
                          }).toList(),
                          onChanged: (value) {
                            model.updateQOProductDropDown(value as String);
                          },
                        ),
                      ),
                    ),
                  ),
                  top: 238),

              // price text field field up, once product is selected
              rowPositioned(
                  top: 307,
                  child: Row(
                    children: [
                      // price text
                      S(w: 15),
                      GeneralTextDisplay("Price", normalBlack, 1, 20,
                          FontWeight.w600, "title"),
                      S(w: 25),
                      // price text field
                      S(
                        w: 250,
                        h: 54,
                        child: Container(
                          padding: const EdgeInsets.only(left: 16, right: 16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                              sS(context).cH(height: 10),
                            )),
                            color: desertStorm,
                          ),
                          alignment: Alignment.centerLeft,
                          child: GeneralTextDisplay(
                              "${model.productPrice * model.priceValue}",
                              normalBlack,
                              1,
                              25,
                              FontWeight.w600,
                              "title"),
                        ),
                      )
                    ],
                  )),
              // quantity
              rowPositioned(
                  top: 381,
                  left: 15,
                  child: Row(
                    children: [
                      // price text
                      S(w: 15),
                      GeneralTextDisplay("Quantity", normalBlack, 1, 15,
                          FontWeight.w400, "title"),
                      S(w: 25),
                      // quantity text field
                      Row(
                        children: [
                          // subtract
                          GestureDetector(
                              onTap: () {
                                model.decrement();
                              },
                              child: GeneralIconDisplay(LineIcons.minus,
                                  regentGray, UniqueKey(), 15)),
                          // value
                          S(w: 15),
                          GeneralTextDisplay(model.priceValue.toString(),
                              secondaryColor, 1, 13, FontWeight.w600, "title"),
                          // add
                          S(w: 15),
                          GestureDetector(
                              onTap: () {
                                model.increment();
                              },
                              child: GeneralIconDisplay(
                                  LineIcons.plus, primary, UniqueKey(), 16.5))
                        ],
                      )
                    ],
                  )),
              // add to cart button
              rowPositioned(
                  child: buttonWidget(
                      text: "Add to Cart",
                      onPressed: () {
                        if(model.loadedCurrencyString=='Select Currency'){
                          final snackBar = SnackBar(
                            backgroundColor: desertStorm,
                            content: GeneralTextDisplay(
                              'You have not selected a currency',
                              primary,
                              1,
                              12,
                              FontWeight.w400,
                              'error',
                              textAlign: TextAlign.center,
                            ),
                          );
                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                       else if(model.categoryString=="Select Category"){
                          final snackBar = SnackBar(
                            backgroundColor: desertStorm,
                            content: GeneralTextDisplay(
                              'You have not selected a Category',
                              primary,
                              1,
                              12,
                              FontWeight.w400,
                              'error',
                              textAlign: TextAlign.center,
                            ),
                          );
                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        // add to cart
                        else if (model.productPrice > 0 ||
                            model.productPrice > 0.0) {
                          model.addToCartFunction(context,
                              productItem: model.homePageCategoryList
                                  .firstWhere((element) =>
                                      element.name == model.productString),
                              productQuantity: model.priceValue.toString(),
                          currency: model.loadedCurrencyString
                          );
                        }
                        else if (model.productString == "Select Product") {
                          final snackBar = SnackBar(
                            backgroundColor: desertStorm,
                            content: GeneralTextDisplay(
                              'Product is empty, choice a product',
                              primary,
                              1,
                              12,
                              FontWeight.w400,
                              'error',
                              textAlign: TextAlign.center,
                            ),
                          );
                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        else if (model.productPrice == 0 ||
                            model.productPrice == 0.0) {
                          final snackBar = SnackBar(
                            backgroundColor: desertStorm,
                            content: GeneralTextDisplay(
                              'Product is loaded, but no product is selected',
                              primary,
                              1,
                              12,
                              FontWeight.w400,
                              'error',
                              textAlign: TextAlign.center,
                            ),
                          );
                          // Find the ScaffoldMessenger in the widget tree
                          // and use it to show a SnackBar.
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      textColor: white),
                  top: 455),
              // page tab
              pageTab(context, tabEnum: TabEnum.quickOrder)
            ], allowBackButton: false),
            controller: model.advancedDrawerController));
  }
}
