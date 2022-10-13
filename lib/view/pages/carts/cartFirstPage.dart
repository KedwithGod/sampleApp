import 'package:ecommerce/model/imports/generalImport.dart';

class CartFirstPage extends StatelessWidget {
  const CartFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartFirstPageViewModel>.reactive(
        onModelReady: (model) {
          model.guestStatus();
          // load cart item list from firebase
          model.cartListFromFirebase(context);
        },
        disposeViewModel: false,
        viewModelBuilder: () => CartFirstPageViewModel(),
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
                child: GeneralTextDisplay(
                    "My Cart", secondaryColor, 1, 20, FontWeight.w600, "title"),
                top: 20,
              ),

               Positioned(
                  child:model.cartItemList==null||model.cartItemList!.docs.isEmpty?
                  GeneralTextDisplay("You have not item in your cart", normalBlack, 2, 15,FontWeight.w400 , 'empty',textAlign: TextAlign.center,)
                      : ListView.separated(
                      itemBuilder: (context, index) {
                        return Dismissible(
                          // Each Dismissible must contain a Key. Keys allow Flutter to
                          // uniquely identify widgets.
                          key: UniqueKey(),

                          onDismissed: (direction) {
                            model.deleteItemFromCart(context,productId:model.cartItemList!.docs[index]['productId'] )
                            .then((value) => model.cartListFromFirebase(context));
                            // Remove the item from the data source.
                            // Then show a snackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                backgroundColor:desertStorm ,
                                content:
                            GeneralTextDisplay('${model.cartItemList!.docs[index]['productName'].toString()} dismissed',
                                primary, 1, 12, FontWeight.w400, 'error',textAlign: TextAlign.center,)
                            ));
                          },
                          // Show a red background as the item is swiped away.
                          background: Container(color: desertStorm),
                          child: Column(
                            children: [
                              Row(

                                children: [
                                  // check box
                                /*  Checkbox(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  sS(context).cH(height: 3)))),
                                      activeColor: primary,
                                      value: model.isChecked[index],
                                      onChanged: (value) {
                                        model.checkBox(index, value!);
                                      }),*/
                                  Container(
                                      width: sS(context).cW(width: 40),
                                      height: sS(context).cH(height: 40),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: desertStorm,

                                      ),
                                      child: Center(
                                        child: GeneralTextDisplay(index.toString(), secondaryColor, 1,
                                            15, FontWeight.w700, "index",textAlign: TextAlign.center,),
                                      )
                                  ),
                                  S(w:15),

                                  // item image
                                  Container(
                                      width: sS(context).cW(width: 80),
                                      height: sS(context).cH(height: 80),
                                      decoration: BoxDecoration(
                                        image:  DecorationImage(image:
                                        NetworkImage(model.cartItemList!.docs[index]['image']
                                            ?? "https://www.color-name.com/paper-white.color"),
                                            fit: BoxFit.fill
                                        ),
                                        color: white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              sS(context).cH(height: 15)),
                                        ),
                                      )),

                                  S(w: 15),
                                  // item details
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // name
                                      GeneralTextDisplay(
                                          model.cartItemList!.docs[index]['productName'].toString().substring(0,20),
                                          secondaryColor,
                                          1,
                                          12,
                                          FontWeight.w600,
                                          "name"),
                                      // description
                                      S(h: 5),
                                      GeneralTextDisplay(
                                      removeHtmlTag( model.cartItemList!.docs[index]
                          ['description'].toString()).length>15? removeHtmlTag( model.cartItemList!.docs[index]
                                          ['description'].toString()).substring(2,15):removeHtmlTag( model.cartItemList!.docs[index]
                                      ['description'].toString()).substring(2,10)
                                          ,
                                          regentGray,
                                          1,
                                          10,
                                          FontWeight.w600,
                                          "description"),
                                      // price
                                      S(h: 12),
                                      GeneralTextDisplay(model.cartItemList!.docs[index]['currency']=='default'?
                            'د.ك ':model.cartItemList!.docs[index]['currency']+ " "+(double.parse(model.cartItemList!.docs[index]['price'])
                                          *model.cartValue[index]).toString(), primary, 1,
                                          15, FontWeight.w700, "price"),
                                    ],
                                  ),
                                  // increment
                                  S(w: 15),
                                  Row(
                                    children: [
                                      // subtract
                                      GestureDetector(
                                          onTap: () {
                                            model.decrement(index,model.cartItemList!.docs[index]['productId']);
                                          },
                                          child: GeneralIconDisplay(
                                              LineIcons.minus,
                                              regentGray,
                                              UniqueKey(),
                                              15)),
                                      // value
                                      S(w: 15),
                                      GeneralTextDisplay(
                                          model.cartValue[index].toString(),
                                          secondaryColor,
                                          1,
                                          13,
                                          FontWeight.w600,
                                          "title"),
                                      // add
                                      S(w: 15),
                                      GestureDetector(
                                          onTap: () {
                                            model.increment(index,model.cartItemList!.docs[index]['productId']);
                                          },
                                          child: GeneralIconDisplay(
                                              LineIcons.plus,
                                              primary,
                                              UniqueKey(),
                                              16.5))
                                    ],
                                  )
                                ],
                              ),
                              if (index == 4) S(h: 40)
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return S(h: 15);
                      },
                      itemCount:  model.cartItemList==null||model.cartItemList!.docs.isEmpty?1:model.cartItemList!.docs.length),
                  top: sS(context).cH(height: 75),
                  bottom: 0,
                  left: sS(context).cW(width: 10),
                  right: 0),
              // page tab
              pageTab(context, tabEnum: TabEnum.cart)
            ], allowBackButton: false),
            controller: model.advancedDrawerController));
  }
}
