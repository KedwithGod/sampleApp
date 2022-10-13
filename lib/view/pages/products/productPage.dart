import 'package:ecommerce/model/imports/generalImport.dart';

class ProductPage extends StatelessWidget {
  final List data;
  const ProductPage({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductPageViewModel>.reactive(
        onModelReady: (model) {
          // to set value for cart if it in database to true
          model.setAddedToCart(data[1]);
          // to load favorite if it in the database
          model.loadFavoriteListFromDB(data[0].id.toString());
    },
    disposeViewModel: false,
    viewModelBuilder: () => ProductPageViewModel(),
    builder: (context, model, child) =>baseUi(children: [
      Container(
        width: sS(context).cW(width: 375),
        height: sS(context).cH(height: 400),
        decoration: BoxDecoration(
          image:  DecorationImage(
              image:
              NetworkImage(data[0].images![0].src!),
              fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 12,
                color: secondaryColor.withOpacity(0.25))
          ],
          color: white,
          borderRadius: BorderRadius.only(
            bottomLeft:Radius.circular(
                sS(context).cH(height: 15)),
            bottomRight:Radius.circular(
                sS(context).cH(height: 15)),
          ),
        ),
      ),
      // back button
      backButton(context,top: 17,color: fountainBlue.withOpacity(0.4),
      navigator: (){
        Navigator.pushReplacementNamed(context,  '/homePageCategory',
            arguments: {
              "categoryId":data[3]['categoryId'],
              "categoryName":data[3]['categoryName']});


      }
      ),
      // favorite button
      rowPositioned(
        child: GestureDetector(
          onTap:(){
            model.addToFavorite(context,productItem:data[0] );
          },
          child: Container(
          width: sS(context).cW(width: 40),
    height: sS(context).cH(height: 40),
    decoration:  BoxDecoration(
    color: white, shape:BoxShape.circle,
      boxShadow: [
          BoxShadow(
            offset:const Offset(0,4),
            blurRadius: 12,
            color: petiteOrchid.withOpacity(0.3)
          )
      ]
    ),
    alignment: Alignment.center,
          child: GeneralIconDisplay(FontAwesomeIcons.solidHeart,
              model.isProductSelected?primary:regentGray, UniqueKey(), 25),
          ),
        ),
        top:17,right:30
      ),
      // product

      // title
      rowPositioned(child:GeneralTextDisplay(
          data[0].name!, secondaryColor, 1, 20, FontWeight.w800, "title"),top: 420,left: 20),
      // subtitle

      // amount
      rowPositioned(child:GeneralTextDisplay(data[0].price!+ "د.ك ", primary, 1, 20,
          FontWeight.w700, "price"),right:22,top:440),
      // rating
      rowPositioned(child:
      Row(children: [
        for(int i in List.generate(data[0].ratingCount, (index) => index))...[
          GeneralIconDisplay(Icons.star,petiteOrchid, UniqueKey(), 23),
          S(w:3)
        ] ,
        for(int i in List.generate((5-data[0].ratingCount).toInt(), (index) => index))...[
          GeneralIconDisplay(Icons.star,grey, UniqueKey(), 23),
          S(w:3)
        ]

      ],), top: 470,left:22),
      // details
      rowPositioned(
          child: S(
            h: 100,
            w: 335,
            child: GeneralTextDisplay(
                removeHtmlTag(data[0].shortDescription!),
                regentGray, 5, 13, FontWeight.w500, "details"),
          ),
          top: 503,left:22),
      // add to cart
      rowPositioned(
          child: GestureDetector(
            onTap:(){
              if(model.isAddedToCart==false){
                model.updateAddedToCart(data[2]);
              model.addToCartFunction(context,productItem:data[0]);}

              else if(model.isAddedToCart==true){
                model.updateAddedToCart(data[2]);
                model.deleteItemFromCart(context,productItem:data[0]);}
            },

            child: Container(
              width: sS(context).cW(width: 65),
              height: sS(context).cH(height: 65),
              decoration:  BoxDecoration(
                  color: desertStorm.withOpacity(0.6), shape:BoxShape.circle,

              ),
              alignment: Alignment.center,
              child: GeneralIconDisplay(FontAwesomeIcons.cartShopping,
                 model.isAddedToCart==false?grey: primary, UniqueKey(), 20),
            ),
          ),
          top:610,left:30
      ),
      // buy now
      rowPositioned(
          child: ButtonWidget(
                () {
  launchInWebViewOrVC('https://www.q8-uc.com/checkout/');
            },
            primary,
            230,
            45,
            GeneralTextDisplay("Buy Now", white, 1, 13,
                FontWeight.w400, "Buy Now"),
            Alignment.center,
            20,
          ),
          top: 620,right:25),

    ], allowBackButton: false));
  }
}
