class WalletTransactionResponse {
  String? transactionId;
  String? blogId;
  String? userId;
  String? type;
  String? amount;
  String? balance;
  String? currency;
  String? details;
  String? createdBy;
  String? deleted;
  String? date;
  List<WalletTransactionMeta>? meta;

  WalletTransactionResponse(
      {this.transactionId,
        this.blogId,
        this.userId,
        this.type,
        this.amount,
        this.balance,
        this.currency,
        this.details,
        this.createdBy,
        this.deleted,
        this.date,
        this.meta});

  WalletTransactionResponse.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    blogId = json['blog_id'];
    userId = json['user_id'];
    type = json['type'];
    amount = json['amount'];
    balance = json['balance'];
    currency = json['currency'];
    details = json['details'];
    createdBy = json['created_by'];
    deleted = json['deleted'];
    date = json['date'];
    if (json['meta'] != null) {
      meta = <WalletTransactionMeta>[];
      json['meta'].forEach((v) {
        meta!.add( WalletTransactionMeta.fromJson(v));
      });
    }
  }


}

class WalletTransactionMeta {
  String? metaKey;
  String? metaValue;

  WalletTransactionMeta({this.metaKey, this.metaValue});

  WalletTransactionMeta.fromJson(Map<String, dynamic> json) {
    metaKey = json['meta_key'];
    metaValue = json['meta_value'];
  }

}
