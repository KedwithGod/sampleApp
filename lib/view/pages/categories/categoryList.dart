import 'package:ecommerce/model/imports/generalImport.dart';

class CategoryList extends StatelessWidget {
  final List<int> selectedCategory;

  const CategoryList({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryHomePageViewModel>.reactive(
        onModelReady: (model) {
         selectedCategory.isEmpty? model.fetchCategoryList(context):model.fetchSelectedCategoryList(selectedCategory);
        },
        disposeViewModel: false,
        viewModelBuilder: () => CategoryHomePageViewModel(),
        builder: (context, model, child) => baseUi(children: [
              // backButton
              backButton(context, top: 17),
              //1. if there is list selected, display selected category

              //2. hence all category will be displayed
              rowPositioned(
                child: GeneralTextDisplay(
                    selectedCategory.isEmpty
                        ? "All Categories"
                        : "Selected Category",
                    secondaryColor,
                    1,
                    20,
                    FontWeight.w600,
                    "title"),
                top: 20,
              ),
              Positioned(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // selected category
                        if (selectedCategory.isNotEmpty) ...[
                          if (model.productList.length ==
                              model.itemCount.length)
                            for (int selectedIndex in model.itemCount) ...[

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: sS(context).cW(
                                          width: model.categoryList[selectedIndex].name!
                                                  .length
                                                  .toDouble() *
                                              13),
                                      height: sS(context).cH(height: 30),
                                      padding: EdgeInsets.symmetric(
                                          vertical: sS(context).cH(height: 5),
                                          horizontal: sS(context).cW(width: 5)),
                                      decoration: BoxDecoration(
                                        color: fountainBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              sS(context).cH(height: 15)),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: GeneralTextDisplay(
                                          model.categoryList[selectedIndex].name!,
                                          secondaryColor,
                                          1,
                                          15,
                                          FontWeight.w600,
                                          "name")),
                                  S(h: 10),
                                  S(
                                    w: 160 * 5,
                                    h: 220,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/productPage',
                                                  arguments:[model.productList[selectedIndex][index],model.isProductChecked[index],index,] );
                                                },
                                                child: Container(
                                                  width: sS(context)
                                                      .cW(width: 150),
                                                  height: sS(context)
                                                      .cH(height: 180),
                                                  decoration: BoxDecoration(
                                                    image:  DecorationImage(
                                                        image: NetworkImage(
                                                           model.productList[selectedIndex][index].images![0].src!),
                                                        fit: BoxFit.fill),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset: const Offset(
                                                              0, 4),
                                                          blurRadius: 12,
                                                          color: secondaryColor
                                                              .withOpacity(
                                                                  0.25))
                                                    ],
                                                    color: white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(
                                                          sS(context)
                                                              .cH(height: 15)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // category name
                                              S(h: 10),
                                              GeneralTextDisplay(
                                                  model.productList[selectedIndex][index].name!,
                                                  secondaryColor,
                                                  1,
                                                  13,
                                                  FontWeight.w400,
                                                  "item name"),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return S(w: 15);
                                        },
                                        itemCount: model.productList[selectedIndex].length),
                                  ),
                                  if (selectedIndex == selectedCategory.length - 1)
                                    S(h: 40),
                                ],
                              ),
                              S(h: 10)
                            ]
                          else if (model.productList.length !=
                              model.itemCount.length)
                            S(
                              h: 180,
                              w: 180,
                              child: Center(
                                child: Column(
                                  children: [
                                    loading(height: 55, width: 55),
                                    const Spacer(),
                                    GeneralTextDisplay(
                                        "Loading Categories and product",
                                        secondaryColor,
                                        2,
                                        13,
                                        FontWeight.w400,
                                        "product name",textAlign: TextAlign.center,),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            )
                        ],


                        // all category
                         if (selectedCategory.isEmpty) ...[
                         if (model.productList.length ==
                              model.itemCount.length)
                            for (int categoryIndex in model.itemCount) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: sS(context).cW(
                                          width: model
                                                  .categoryList[categoryIndex]
                                                  .name!
                                                  .length
                                                  .toDouble() *
                                              13),
                                      height: sS(context).cH(height: 30),
                                      padding: EdgeInsets.symmetric(
                                          vertical: sS(context).cH(height: 5),
                                          horizontal: sS(context).cW(width: 5)),
                                      decoration: BoxDecoration(
                                        color: fountainBlue.withOpacity(0.1),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              sS(context).cH(height: 15)),
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                      child: GeneralTextDisplay(
                                          model.categoryList[categoryIndex]
                                              .name!,
                                          secondaryColor,
                                          1,
                                          15,
                                          FontWeight.w600,
                                          "name")),
                                  S(h: 10),
                                  S(
                                    w: 160 * 5,
                                    h: 180,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap:(){
                                                  Navigator.pushNamed(
                                                      context, '/productPage',
                                                      arguments:model.productList[categoryIndex][index] );
                                                },
                                                child: Container(
                                                  width:
                                                      sS(context).cW(width: 150),
                                                  height:
                                                      sS(context).cH(height: 150),
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: NetworkImage(model
                                                            .productList[
                                                                categoryIndex]
                                                                [index]
                                                            .images![0]
                                                            .src!),
                                                        fit: BoxFit.fill),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          offset:
                                                              const Offset(0, 4),
                                                          blurRadius: 12,
                                                          color: secondaryColor
                                                              .withOpacity(0.25))
                                                    ],
                                                    color: white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(sS(context)
                                                          .cH(height: 15)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // category name
                                              S(h: 10),
                                              GeneralTextDisplay(
                                                  model
                                                      .productList[
                                                          categoryIndex][index]
                                                      .name!,
                                                  secondaryColor,
                                                  1,
                                                  13,
                                                  FontWeight.w400,
                                                  "item name"),
                                            ],
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return S(w: 15);
                                        },
                                        itemCount: model
                                            .productList[categoryIndex].length),
                                  ),
                                  if (categoryIndex ==
                                      model.categoryList.length - 1)
                                    S(h: 50),
                                ],
                              ),
                              S(h: 20)
                            ]
                          else if (model.productList.length !=
                              model.itemCount.length)
                            S(
                              h: 180,
                              w: 180,
                              child: Center(
                                child: Column(
                                  children: [
                                    loading(height: 55, width: 55),
                                    const Spacer(),
                                    GeneralTextDisplay(
                                        "Loading Categories and product",
                                        secondaryColor,
                                        1,
                                        13,
                                        FontWeight.w400,
                                        "product name"),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            )
                        ]
                      ],
                    ),
                  ),
                  top: sS(context).cH(height: 100),
                  bottom: 0,
                  left: 20,
                  right: 0),

            ], allowBackButton: false));
  }
}

// all category
