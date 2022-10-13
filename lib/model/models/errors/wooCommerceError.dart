class WooCommerceErrorResponse{
  String code,message;
  int status;

  WooCommerceErrorResponse({required this.code,
    required this.message,
    required this.status});


  factory WooCommerceErrorResponse.fromMap(Map<String, dynamic> map) {
    return WooCommerceErrorResponse(
      code: map.isEmpty?"":map['code']??"",
      message: map.isEmpty?"":map['message']??"",
      status: map.isEmpty?"":map["data"]['status'],
    );
  }
}

