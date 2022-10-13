import 'package:ecommerce/model/imports/generalImport.dart';


class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoriteViewModel>.reactive(
        onModelReady: (model) {
          model.guestStatus();
          // fetch favorite from db
          model.favoriteListFromFirebase(context);
    },
    disposeViewModel: false,
    viewModelBuilder: () => FavoriteViewModel(),
    builder: (context, model, child) =>drawer(context,
        asGuest: model.asGuest,
      child: baseUi(children: [
        rowPositioned(
         child: GestureDetector(
          onTap: () {
        model.advancedDrawerController.showDrawer();
        },
        child: GeneralIconDisplay(Icons.menu, secondaryColor, UniqueKey(), 20)),
            top: 25,
            left: 20),
        // title
        rowPositioned(
          child: GeneralTextDisplay(
              "My WishList", secondaryColor, 1, 20, FontWeight.w600, "title"),
          top: 20,
        ),

        // list of items in cart
        Positioned(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return model.favoriteItemList==null||model.favoriteItemList!.docs.isEmpty?
                  GeneralTextDisplay("You have no item in your wish list", normalBlack, 2, 15,FontWeight.w400 , 'empty',textAlign: TextAlign.center,) :Dismissible(
                    // Each Dismissible must contain a Key. Keys allow Flutter to
                    // uniquely identify widgets.
                    key: UniqueKey(),

                    onDismissed: (direction) {
                      model.deleteToFavoriteFirebase(context,productId:model.favoriteItemList!.docs[index]['productId'] ).then((value)
                      => model.favoriteListFromFirebase(context));
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
                        GestureDetector(
                            onTap:(){
                              Navigator.pushNamed(context, '/productPage');
                            },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // s/n
                             Container(
                                 width: sS(context).cW(width: 40),
                                 height: sS(context).cH(height: 40),
                                 decoration:const  BoxDecoration(
                                     color: desertStorm, shape:BoxShape.circle,

                                 ),
                                 alignment: Alignment.center,

                                 child: GeneralTextDisplay(
                                     "${index+1}", secondaryColor, 1, 15, FontWeight.w400, "index")),
                              S(w: 15),
                              // item image
                              Container(
                                  width: sS(context).cW(width: 80),
                                  height: sS(context).cH(height: 80),
                                  decoration: BoxDecoration(
                                    image:  DecorationImage(
                                        image: NetworkImage(model.favoriteItemList!.docs[index]['image']
                                            ?? "https://www.color-name.com/paper-white.color"),
                                        fit: BoxFit.fill),
                                    color: white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(sS(context).cH(height: 15)),
                                    ),
                                  )),

                              S(w: 15),
                              // item details
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // name
                                  GeneralTextDisplay(model.favoriteItemList!.docs[index]['productName'], secondaryColor, 1,
                                      12, FontWeight.w600, "name"),
                                  // description
                                  S(h: 5),
                                  GeneralTextDisplay(
                                      removeHtmlTag( model.favoriteItemList!.docs[index]
                  ['description'].toString()).length>15? removeHtmlTag( model.favoriteItemList!.docs[index]
                  ['description'].toString()).substring(2,15):removeHtmlTag( model.favoriteItemList!.docs[index]
                  ['description'].toString()).substring(2,10),
                                      regentGray,
                                      1,
                                      10,
                                      FontWeight.w600,
                                      "description"),
                                  // price
                                  S(h: 12),
                                  GeneralTextDisplay(
                                  'د.ك ' + model.favoriteItemList!.docs[index]['price'], primary, 1, 15,
                                      FontWeight.w700, "price"),
                                ],
                              ),
                              // increment
                            ],
                          ),
                        ),
                        if(index==4)S(h:40)
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return S(h: 15);
                },
                itemCount:  model.favoriteItemList==null||model.favoriteItemList!.docs.isEmpty?1:model.favoriteItemList!.docs.length),
            top: sS(context).cH(height: 75),
            bottom: 0,
            left: 10,
            right: 0),
        // page tab
        pageTab(context, tabEnum: TabEnum.favorite)
      ], allowBackButton: false)
        ,controller: model.advancedDrawerController
    ));
  }
}
