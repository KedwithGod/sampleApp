class UserResponse {
  int id;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String email;
  String firstName;
  String lastName;
  String role;
  String username;
  Billing billing;
  Shipping shipping;
  bool isPayingCustomer;
  String avatarUrl;
  WooCommerceCustomerMetaData metaData;
  dynamic amsRewardsPointsBalance;
  Links lLinks;

  UserResponse(
      {required this.id,
        required this.dateCreated,
        required this.dateCreatedGmt,
        required this.dateModified,
        required this.dateModifiedGmt,
        required this.email,
        required this.firstName,
        required this.lastName,
        required this.role,
        required this.username,
        required this.billing,
        required this.shipping,
        required this.isPayingCustomer,
        required this.avatarUrl,
        required this.metaData,
        required this.amsRewardsPointsBalance,
        required this.lLinks});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
   return UserResponse(
       id : json['id'],
       dateCreated : json['date_created'],
       dateCreatedGmt : json['date_created_gmt'],
       dateModified : json['date_modified'],
       dateModifiedGmt : json['date_modified_gmt'],
       email : json['email'],
       firstName : json['first_name'],
       lastName : json['last_name'],
       role : json['role'],
       username : json['username'],
       billing :
       Billing.fromJson(json['billing'])  ,
    shipping :Shipping.fromJson( json['shipping']) ,
    isPayingCustomer : json['is_paying_customer'],
    avatarUrl : json['avatar_url'],
       metaData : WooCommerceCustomerMetaData.fromJson(json['meta_data'][0]),

    amsRewardsPointsBalance : json['ams-rewards-points-balance'],
    lLinks : Links.fromMap(json['_links'])
   );
  }


}

class Billing {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String email;
  String phone;

  Billing(
      {required this.firstName,
        required this.lastName,
        required this.company,
        required this.address1,
        required this.address2,
        required this.city,
        required this.postcode,
        required this.country,
        required this.state,
        required this.email,
        required this.phone});

  factory Billing.fromJson(Map<String, dynamic> json) {
   return Billing(
     firstName : json['first_name'],
     lastName : json['last_name'],
     company : json['company'],
     address1 : json['address_1'],
     address2 : json['address_2'],
     city : json['city'],
     postcode : json['postcode'],
     country : json['country'],
     state : json['state'],
     email : json['email'],
     phone : json['phone'],
   );
  }

}

class Shipping {
  String firstName;
  String lastName;
  String company;
  String address1;
  String address2;
  String city;
  String postcode;
  String country;
  String state;
  String phone;

  Shipping(
      {required this.firstName,
        required this.lastName,
        required this.company,
        required this.address1,
        required this.address2,
        required this.city,
        required this.postcode,
        required this.country,
        required this.state,
        required this.phone});

  factory Shipping.fromJson(Map<String, dynamic> json) {
    return Shipping(
      firstName : json['first_name'],
      lastName : json['last_name'],
      company : json['company'],
      address1 : json['address_1'],
      address2 : json['address_2'],
      city : json['city'],
      postcode : json['postcode'],
      country : json['country'],
      state : json['state'],
      phone : json['phone'],
    );
  }


}

class WooCommerceCustomerMetaData {
  int id;
  String key;
  dynamic value;

  WooCommerceCustomerMetaData({required this.id, required this.key, required this.value});

  factory WooCommerceCustomerMetaData.fromJson(Map<String, dynamic> json) {
   return WooCommerceCustomerMetaData(
       id : json['id'],
       key : json['key'],
       value : json['value'],
   );
  }

 
}

class Links {
  List self;
  List collection;

  Links({required this.self, required this.collection});


  factory Links.fromMap(Map<String, dynamic> map) {
    return Links(
      self: map['self']??[],
      collection: map['collection']??[]  ,
    );
  }

}

class Self {
  String href;

  Self({required this.href});

 factory Self.fromJson(Map<String, dynamic> json) {
    return Self(
        href : json['href']
    );
  }

}
