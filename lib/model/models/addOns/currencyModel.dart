class CurrencyModel {
  String code;
  String name;
  String symbol;
  CurrencyLinks lLinks;

  CurrencyModel({required this.code, required this.name, required this.symbol, required this.lLinks});

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
        code: json['code'],
        name :json['name'],
        symbol :json['symbol'],
    lLinks: (json['_links'] != null ?  CurrencyLinks.fromJson(json['_links']) : null)!    );
  }

}

class CurrencyLinks {
  List<CurrencySelf>? self;
  List? collection;

  CurrencyLinks({this.self, this.collection});

  CurrencyLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <CurrencySelf>[];
      json['self'].forEach((v) {
        self!.add(new CurrencySelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = json['collection'];
      json['collection'].forEach((v) {
      });
    }
  }


}

class CurrencySelf {
  String? href;

  CurrencySelf({this.href});

  CurrencySelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }


}
