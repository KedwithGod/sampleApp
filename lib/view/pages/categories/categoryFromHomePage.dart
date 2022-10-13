import 'package:ecommerce/model/imports/generalImport.dart';


class HomePageCategory extends StatelessWidget {
  final Map data;
   const HomePageCategory({Key? key,required  this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
        onModelReady: (model) {
          model.homePageCategory(context,id: data['categoryId'],
              categoryName: data['categoryName']);

        },
    disposeViewModel: false,
    viewModelBuilder: () => BaseModel(),
    builder: (context, model, child) =>baseUi(children: [
      // backButton
      backButton(context,top: 17),
      //1. if there is list selected, display selected category

      //2. hence all category will be displayed
      rowPositioned(
        child: GeneralTextDisplay(
           model.homePageCategoryName, secondaryColor, 1, 20, FontWeight.w600, "title"),
        top: 20,
      ),
      // product grid
      Positioned(
        child: model.homePageCategoryList.isEmpty?
        FutureBuilder(
          future: Future.delayed(const Duration(seconds: 5)),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.active){
              return Center(
                child: loading(
                    height: 100,width:100
                ),
              );
            }
            else if(snapshot.connectionState==ConnectionState.done){
              return Center(
                child: GeneralTextDisplay("There is no product in the category", secondaryColor, 1, 13,
                    FontWeight.w400, "product name"),
              );
            }
            return Center(
              child: loading(
                  height: 100,width:100
              ),
            );
          }
        )
            :GridView.builder(
          itemCount: model.homePageCategoryList.length,
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 280,
              mainAxisSpacing: 15,
              crossAxisSpacing: 12
          ), itemBuilder:
            (context,index){
          return Padding(
              padding:  EdgeInsets.symmetric(
                  horizontal: sS(context).cW(width: 3),
                  vertical: sS(context).cH(height: 3)
              ),child: S(
            h: 300,
            w: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap:(){
                    print(model.homePageCategoryList[index].ratingCount);
                    // navigate to product page
                  Navigator.pushReplacementNamed(context, '/productPage',
                    arguments: [model.homePageCategoryList[index],model.isProductChecked[index],index,data]
                  );
                  },
                  child: Container(
                    width: sS(context).cW(width: 150),
                    height: sS(context).cH(height: 150),
                    decoration: BoxDecoration(
                      image: DecorationImage(image:
                      NetworkImage(model.homePageCategoryList[index].images==null?
                      "https://www.color-name.com/paper-white.color"
                          :model.homePageCategoryList[index].images![0].src!),
                          fit: BoxFit.fill
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0,4),
                            blurRadius: 12,
                            color: secondaryColor.withOpacity(0.25)
                        )
                      ],
                      color: white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(sS(context).cH(height: 15)),

                      ),
                    ),
                  ),
                ),
                // category name
                S(h:10),
                GeneralTextDisplay(model.homePageCategoryList[index].name!, secondaryColor, 1, 13,
                    FontWeight.w400, "product name"),
                S(h:10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // price
                    GeneralTextDisplay("Price "+model.homePageCategoryList[index].price!+ " د.ك ", secondaryColor, 1, 13,
                        FontWeight.w400, "product name"),
                    S(w:20),
                    GestureDetector(
                      onTap:(){
                        // add all items to cart
                        model.productAddToCart(context,index);


                      },
                      child: GeneralIconDisplay(FontAwesomeIcons.cartShopping,
                          model.isProductChecked[index]==true?primary:grey, UniqueKey(), 20),
                    ),

                  ],
                )
              ],
            ),
          ));
        }, ),
        top: sS(context).cH(height: 70),
        left: sS(context).cW(width: 10),
        right:sS(context).cW(width: 10),
        bottom:sS(context).cH(height: 0),
      ),

    ], allowBackButton: false));
  }
}
