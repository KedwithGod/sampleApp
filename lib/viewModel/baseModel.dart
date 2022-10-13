import 'dart:async';


import '../model/imports/generalImport.dart';

class BaseModel extends ChangeNotifier {
  // for advanced drawer
  final advancedDrawerController = AdvancedDrawerController();

  // drop down value
  String currencyString = "Select";
  List<String> dropDownList = [
    "Select",
  ];

  // carousel image from database
  List carousels=[];
  // view state
  ViewState state = ViewState.idle;

  // state error
  String? stateError;

  updateState(ViewState viewState) {
    state = viewState;
    notifyListeners();
  }

  // streams
  StreamController<ViewState> stateController =
      StreamController<ViewState>.broadcast();

  @override
  void dispose() {
    stateController.close();
    super.dispose();
  }

// instead of passing date from homePage to homePageCategory
// set homePageCategory id
  int? homePageCategoryId;
  String homePageCategoryName = "";

  homePageCategory(context, {required int id, required String categoryName}) {
    homePageCategoryId = id;
    homePageCategoryName = categoryName;
    notifyListeners();
    fetchProductDetails(context);
  }

  List<ProductResponse> homePageCategoryList = [];
  // document snapshot for cart item list
  QuerySnapshot<Map<String, dynamic>>? cartItemList;
  QuerySnapshot<Map<String, dynamic>>? favoriteItemList;

  // fetch product using homePageCategoryId
  Future fetchProductDetails(context,{int? categoryId}) async {
    // loading page
    loadingDialog(context, text: "Setting up products");
    await WooCommerceProducts.fetchAllProducts(
            categoryId: categoryId ?? homePageCategoryId!)
        .then((value)async {
      if (value is List) {
        homePageCategoryList = value.map((e) {
          return ProductResponse.fromJson(e);
        }).toList();
        notifyListeners();

        // initialize cart
        initializeProductAddToCart(homePageCategoryList.length);
        // save product list to local storage
       await LocalStorage.setString('productList', json.encode(value));
        // get firebaseId from the local storage
        String? firebaseIdValue=  await LocalStorage.getString(firebaseId);
       // fetch cart item list
      await AddToCartService.requestCartItemList(firebaseId: firebaseIdValue!).then((cartItemList){
        // populate the isProductCheck list
        if(cartItemList.docs.isNotEmpty){
          for(var categoryIndex in List.generate(homePageCategoryList.length, (index) => index)){
            for(var cartItemIndex in List.generate(cartItemList.docs.length, (index) => index)){
              if(cartItemList.docs[cartItemIndex].id==homePageCategoryList[categoryIndex].id.toString()){
                populateIsProductChecked(categoryIndex);
                //print(categoryIndex.toString()+"is in firebase with ${homePageCategoryList[categoryIndex].id} ==${cartItemList.data()!['cartItemList'][cartItemIndex]['productId']}");
              }
            }
          }
        }
        Navigator.pop(context);
      });



      }
      else if (value is WooCommerceErrorResponse) {
        Navigator.pop(context);
        loaderWithClose(context,text: value.message);
      }
    });
  }

  bool? asGuest;

  // check if user is guest
  guestStatus() async {
    asGuest = await LocalStorage.getBool(guestUser);
    notifyListeners();
  }

  // category
  // list of chips
  // name
  List<String> name = [
    "Jacket",
    "HandBag",
    "Spectacle",
    "Gloves",
    "Lab Coat",
    "Dress",
    "Flat Shoes",
    "Jeans",
    "Necklace",
    "Earrings"
  ];

  // isSelected
  List<bool> isSelected = [];
  List<int> selectedIndex = [];

// isSelected text color
  List<Color> itemColor = [];

  // change item color to white, once it is selected
  onSelected(int index) {
    isSelected[index] = !isSelected[index];
    itemColor[index] == secondaryColor
        ? itemColor[index] = white
        : itemColor[index] = secondaryColor;
    if (selectedIndex.contains(index)) {
      selectedIndex.remove(index);
    } else {
      selectedIndex.add(index);
    }
    notifyListeners();
    selectedIndex.sort();
    notifyListeners();
  }

  List<List<ProductResponse>> productList = [];

  // fetch product using categoryId
  productDetails() async {
    for (var index in itemCount) {
      await WooCommerceProducts.fetchAllProducts(
              categoryId: categoriesId[index])
          .then((value) {
        if (value is List) {
          productList.add(value.map((e) {
            return ProductResponse.fromJson(e);
          }).toList());
          notifyListeners();
        } else if (value is WooCommerceErrorResponse) {}
      });
    }
  }

  // initialize lists
  initializeCheck(length) {
    isSelected = List<bool>.filled(length, false);
    itemColor = List<Color>.filled(length, secondaryColor);
    notifyListeners();
  }

  //category list
  List<CategoryResponse> categoryList = [];
  List<int> itemCount = [];
  List<int> categoriesId = [];

  fetchCategoryList(context, {bool isQuickOrder = false}) async {
    try {
      SchedulerBinding.instance?.addPostFrameCallback((_) => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return dialogBox(
              context,
              "Fetching Category List",
              'Category',
              DialogType.processing,
              function: () {},
              dismissText: "",
            );
          }));
      await WooCommerceCategories.fetchAllCategories().then((value) async {
        if (value is List) {
          // turn dynamic list to CategoryResponse type
          categoryList = value.map((e) {
            return CategoryResponse.fromJson(e);
          }).toList();
          notifyListeners();
          // remove the unCategorized item in the list
          categoryList.removeAt(0);
          // initialize the item count
          itemCount = List.generate(categoryList.length, (index) => index);
          notifyListeners();
          // initialize category list
          initializeCheck(categoryList.length);
          // add category index for use
          for (var index in itemCount) {
            categoriesId.add(categoryList[index].id!);
            notifyListeners();
          }

          categoryList
              .map((e) => e.name.toString())
              .toList()
              .forEach((element) {
            categoryDropDown.add(element);
          });
          notifyListeners();
          // store category list of strings
          LocalStorage.setString('cat', json.encode(categoryDropDown));
          // store the fetch categories
          LocalStorage.setString('catList', json.encode(value));
          await updateCategoryDropDown();
          // fetch product details
          if (isQuickOrder == false) productDetails();
          Navigator.pop(context);
          await firebaseFireStore.collection('admin').doc('carousels').get().then((value){
            carousels=value.data()!['carousel'];
            notifyListeners();
          });

        } else if (value is WooCommerceErrorResponse) {
          Navigator.pop(context);
          showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) => dialogBox(
                    context,
                    value.message,
                    'Category',
                    DialogType.error,
                    dismissText: 'close',
                    function: () {
                      // if the error message contains email, it is likely the email
                      // is incorrect

                      // if the error message contains login, it is likely to go to login pag
                      Navigator.pop(context);
                    },
                    dismissTextColor: primary,
                  ));
        }
      });
    } on SocketException catch (error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => dialogBox(
                context,
                "Looks like you have a bad internet connection, kindly check and try again",
                'Network Error',
                DialogType.error,
                dismissText: 'close',
                function: () {
                  // if the error message contains email, it is likely the email
                  // is incorrect

                  // if the error message contains login, it is likely to go to login pag
                  Navigator.pop(context);
                },
                dismissTextColor: primary,
              ));
      return error;
    }
  }

  fetchSelectedCategoryList(List selectedIndex) async {
    await WooCommerceCategories.fetchAllCategories().then((value) {
      if (value is List) {
        // turn dynamic list to CategoryResponse type
        categoryList = value.map((e) {
          return CategoryResponse.fromJson(e);
        }).toList();
        notifyListeners();
        // remove the unCategorized item in the list
        categoryList.removeAt(0);
        notifyListeners();
        // initialize the item count
        itemCount = List.generate(selectedIndex.length, (index) => index);
        notifyListeners();
        // add category index for use
        for (var index in selectedIndex) {
          categoriesId.add(categoryList[index].id!);
          notifyListeners();
        }
        // fetch product details
        productDetails();
      } else if (value is WooCommerceErrorResponse) {}
    });
  }

  // lang drop down
  List<String> currencyList = ["Kuwaiti dinar", "Uruguyan peso"];
   Set<String>? loadedCurrencyList={'Select Currency'};
  String? loadedCurrencyString;

  // fetch currency list
  fetchCurrencyFunction(BuildContext context)async{
   await AllCurrency.fetchCurrencyService().then((value){
      if(value is List){
        loadedCurrencyList!.addAll(value.map((e) =>unescape.convert(CurrencyModel.fromJson(e).symbol)).toSet());
        notifyListeners();
        loadedCurrencyString=loadedCurrencyList!.first;
        notifyListeners();
      }
      else if (value is Map){
        final snackBar = SnackBar(
          content: GeneralTextDisplay('Unable to fetch currency List', primary, 1, 12, FontWeight.w400, 'error'),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }
    });

  }

  updateDropDown() {
    currencyString = currencyList[0];
    notifyListeners();
  }

  updateLangDropDownValue(String value) {
    currencyString = value;
    notifyListeners();
    if (kDebugMode) {
      print("updateValue $currencyString");
    }
  }

  // fetch currency list and populate currencyDropDown

// category
  String categoryString = "Select Category";
  List<String> categoryDropDown = ["Select Category"];

  updateCategoryDropDown() async {
    String? fetch = await LocalStorage.getString("cat");
    List value = json.decode(fetch!);
    categoryDropDown = value.map((e) => e.toString()).toList();
    notifyListeners();
    categoryString = categoryDropDown[0];
    notifyListeners();
    //await LocalStorage.setString('cat', "");
    print("i am dropDown $currencyString");
  }

  updateCategoryDropDownValue(
      String categoryValue, BuildContext context) async {
    try {
      // update value

      categoryString = categoryValue;
      notifyListeners();
      // show dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: S(
            h: 200,
            w: 200,
            child: customDialog(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GeneralTextDisplay(
                      "Loading products",
                      black51,
                      3,
                      14,
                      FontWeight.w500,
                      "",
                      textAlign: TextAlign.center,
                    ),
                    S(h: 20),
                    loading(),
                  ],
                ),
                align: Alignment.center),
          ),
        ),
      );
      // fetch stored data

      String? fetch = await LocalStorage.getString("catList");
      List value = json.decode(fetch!);
      // decode data to CategoryResponse

      categoryList = value.map((e) => CategoryResponse.fromJson(e)).toList();
      notifyListeners();
      // get the id from the data

      var id = categoryList
          .firstWhere((element) => element.name == categoryString)
          .id;
      // fetch the list of products

      await fetchProductDetails(context,categoryId: id).then((value) {
        Navigator.pop(context);
        if (homePageCategoryList.isNotEmpty) {
          productDropDown =
              homePageCategoryList.map((e) => e.name.toString()).toList();
          notifyListeners();
        } else if (homePageCategoryList.isEmpty) {
          productDropDown = ["No product available"];
          notifyListeners();
        }
        updateProductDropDown();
        updateDropDown();
       // updateCategoryDropDown();
      });
    } catch (e) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: S(
            h: 200,
            w: 200,
            child: customDialog(
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GeneralTextDisplay(
                    "Sorry,Unable to fetch products",
                    normalBlack,
                    3,
                    14,
                    FontWeight.w500,
                    "",
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: GeneralTextDisplay(
                          "close",
                          primary,
                          3,
                          14,
                          FontWeight.w400,
                          "",
                        ),
                      ),
                    ],
                  )
                ]),
                align: Alignment.center),
          ),
        ),
      );
    }
  }

// update product list on QO(quick order)page
  List<String> productDropDown = ["Select Product"];
  String productString = "Select Product";
  double productPrice = 0;

// products
  StreamController<String> productStream = StreamController<String>.broadcast();

  updateProductDropDown() {
    productString = productDropDown[0];
    notifyListeners();
    print("i am product $productString");
  }

  updateQOProductDropDown(String value) async {
    // update product String
    productString = value;
    notifyListeners();

    // set product price
    String? productListString = await LocalStorage.getString('productList');
    List decodedList = jsonDecode(productListString!);
    homePageCategoryList =
        decodedList.map((e) => ProductResponse.fromJson(e)).toList();
    notifyListeners();
    String unFormattedProductPrice = homePageCategoryList
        .firstWhere((element) => element.name == productString)
        .regularPrice!;
    // format string to bring out price
    productPrice = double.parse(unFormattedProductPrice.toString());
    notifyListeners();
  }

// product price
// add to cart color
  // cart value
  List<int> productCartList = [];

  // check box
  List<bool> isProductChecked = [];

  initializeProductAddToCart(int value) {
    isProductChecked = List<bool>.filled(value, false);
    notifyListeners();
  }
  // populate isProductChecked on init
  populateIsProductChecked(int index){
    isProductChecked[index]=true;
    notifyListeners();
  }

  int currentIndex = 0;
  Color cartColor = grey;

  productAddToCart(context,int index) {
    isProductChecked[index] = !isProductChecked[index];
    notifyListeners();
    if(isProductChecked[index]==true){
      // add to online cart
      addToCartFunction(context,productItem:homePageCategoryList[index]);
      print('added $index');
    } else if(isProductChecked[index]==false){
      deleteItemFromCart(context,productItem:homePageCategoryList[index]);
      print('deleted $index');
    }
  }

  // save device id to localStorage
  saveDeviceId() async {
    // String? deviceId = await PlatformDeviceId.getDeviceId;
    // if (kDebugMode) {
    //   print('i am device id' + deviceId!);
    // }
    // LocalStorage.setString(firebaseId, deviceId!);
  }

  // add to cart function, to add a product to chart
  addToCartFunction(context,{required ProductResponse productItem,String? productQuantity,
  String? currency,
  }) async {
    try {
      if(productQuantity!=null)loadingDialog(context, text: 'Adding ${productItem.name} of $productQuantity quantity to cart');
      // get firebaseId from the local storage
      String? firebaseIdValue=  await LocalStorage.getString(firebaseId);

        AddToCartService.addToCart(
            productId: productItem.id.toString(),
            productName: productItem.name,
            description: productItem.description,
            price: productItem.price,
            currency: currency??"default",
            firebaseId: firebaseIdValue,
            image: productItem.images![0].src!,
          productQuantity: productQuantity
        ).then((value){
          if(productQuantity!=null){
            Navigator.pop(context);
            loaderWithClose(context,text: 'You have successfully added ${productItem.name} to cart',
              iconColor: Colors.green,icon: Icons.done

            );
          }
        });

    }
    catch (error) {
      if(error is SocketException){
        final snackBar = SnackBar(
          content: GeneralTextDisplay('Unable to connect, kindly check your internet connection',
              primary, 1, 12, FontWeight.w400, 'error'),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        final snackBar = SnackBar(
          content: GeneralTextDisplay('An error occurred try again later', primary, 1, 12, FontWeight.w400, 'error'),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  // delete item from cart
  Future deleteItemFromCart(context,{ ProductResponse? productItem, String? productId}) async {
    try {
      // get firebaseId from the local storage
      String? firebaseIdValue=  await LocalStorage.getString(firebaseId);

      if(productId!=null){
        AddToCartService.deleteRequest(
          firebaseIdValue!,
          productId,
        );
      }

      else{
        AddToCartService.deleteRequest(
          firebaseIdValue!,
          productItem!.id.toString(),
        );
      }
      return true;
    }
    catch (error) {
      if(error is SocketException){
        final snackBar = SnackBar(
          content: GeneralTextDisplay('Unable to connect, kindly check your internet connection',
              primary, 1, 12, FontWeight.w400, 'error'),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      else{
        final snackBar = SnackBar(
          content: GeneralTextDisplay('An error occurred try again later', primary, 1, 12, FontWeight.w400, 'error'),
        );
        // Find the ScaffoldMessenger in the widget tree
        // and use it to show a SnackBar.
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  // added to cart for a single product
  bool isAddedToCart=false;
  setAddedToCart(bool value){
    isAddedToCart=value;
    notifyListeners();
  }
  updateAddedToCart(index){
    isAddedToCart=!isAddedToCart;
    notifyListeners();

  }

  // delete product to firebase favorite
 Future deleteToFavoriteFirebase(context,{
    required String productId
  })async{
    // get firebaseId from the local storage
    String? firebaseIdValue=  await LocalStorage.getString(firebaseId);
    AddToFavoriteService.deleteRequest(firebaseIdValue!, productId);
    return true;
  }
}

// consumer key ck_4a29035b7c6e950e898f665bfba4212f02c68e06
// consumer secret cs_3b95464418f8ce06e594919c50c2b54825b6d92a

// cart data structure on empty cart
/*
{
  "cart": {
    "cart_contents": [],
    "removed_cart_contents": [],
    "applied_coupons": [],
    "cart_session_data": {
      "cart_contents_total": 0,
      "total": 0,
      "subtotal": 0,
      "subtotal_ex_tax": 0,
      "tax_total": 0,
      "taxes": [],
      "shipping_taxes": [],
      "discount_cart": 0,
      "discount_cart_tax": 0,
      "shipping_total": 0,
      "shipping_tax_total": 0,
      "coupon_discount_amounts": [],
      "coupon_discount_tax_amounts": [],
      "fee_total": 0,
      "fees": []
    },
    "coupon_applied_count": [],
    "coupon_discount_totals": [],
    "coupon_discount_tax_totals": []
  }
}

 */