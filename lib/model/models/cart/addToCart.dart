class AddToCart{
  // add product to cart
  String productName;
  String description;
  String price;
  String productId;
  String productQuantity;
  String currency;

  AddToCart({required this.productName, required this.description,required this.price,required this.productId,
  required  this.productQuantity,required this.currency});

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'description': description,
      'price': price,
      'productId': productId,
      'productQuantity': productQuantity,
      'currency': currency,
    };
  }

  factory AddToCart.fromMap(Map<String, dynamic> map) {
    return AddToCart(
      productName: map['productName'] as String,
      description: map['description'] as String,
      price: map['price'] as String,
      productId: map['productId'] as String,
      productQuantity: map['productQuantity'] as String,
      currency: map['currency'] as String,
    );
  }
}