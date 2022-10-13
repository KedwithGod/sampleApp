class WalletBalanceResponse {
  String? balance;
  String? currency;

  WalletBalanceResponse({this.balance, this.currency});

  WalletBalanceResponse.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    currency = json['currency'];
  }


}
