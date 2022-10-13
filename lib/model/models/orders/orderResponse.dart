class OrderModel {
  int? id;
  int? parentId;
  String? number;
  String? orderKey;
  String? createdVia;
  String? version;
  String? status;
  String? currency;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  bool? pricesIncludeTax;
  int? customerId;
  String? customerIpAddress;
  String? customerUserAgent;
  String? customerNote;
  OrderBilling? billing;
  OrderShipping? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? transactionId;
  String? datePaid;
  String? datePaidGmt;
  dynamic dateCompleted;
  dynamic dateCompletedGmt;
  String? cartHash;
  List? metaData;
  List<OrderLineItems>? lineItems;
  List<OrderTaxLines>? taxLines;
  List<OrderShippingLines>? shippingLines;
  List<dynamic>? feeLines;
  List<dynamic>? couponLines;
  List<dynamic>? refunds;
  OrderLinks? lLinks;

  OrderModel(
      {this.id,
        this.parentId,
        this.number,
        this.orderKey,
        this.createdVia,
        this.version,
        this.status,
        this.currency,
        this.dateCreated,
        this.dateCreatedGmt,
        this.dateModified,
        this.dateModifiedGmt,
        this.discountTotal,
        this.discountTax,
        this.shippingTotal,
        this.shippingTax,
        this.cartTax,
        this.total,
        this.totalTax,
        this.pricesIncludeTax,
        this.customerId,
        this.customerIpAddress,
        this.customerUserAgent,
        this.customerNote,
        this.billing,
        this.shipping,
        this.paymentMethod,
        this.paymentMethodTitle,
        this.transactionId,
        this.datePaid,
        this.datePaidGmt,
        this.dateCompleted,
        this.dateCompletedGmt,
        this.cartHash,
        this.metaData,
        this.lineItems,
        this.taxLines,
        this.shippingLines,
        this.feeLines,
        this.couponLines,
        this.refunds,
        this.lLinks});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    number = json['number'];
    orderKey = json['order_key'];
    createdVia = json['created_via'];
    version = json['version'];
    status = json['status'];
    currency = json['currency'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    cartTax = json['cart_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    pricesIncludeTax = json['prices_include_tax'];
    customerId = json['customer_id'];
    customerIpAddress = json['customer_ip_address'];
    customerUserAgent = json['customer_user_agent'];
    customerNote = json['customer_note'];
    billing =
    json['billing'] != null ?  OrderBilling.fromJson(json['billing']) : null;
    shipping = json['shipping'] != null
        ?  OrderShipping.fromJson(json['shipping'])
        : null;
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    transactionId = json['transaction_id'];
    datePaid = json['date_paid'];
    datePaidGmt = json['date_paid_gmt'];
    dateCompleted = json['date_completed'];
    dateCompletedGmt = json['date_completed_gmt'];
    cartHash = json['cart_hash'];
    if (json['meta_data'] != null) {
      metaData =json['meta_data'];

    }
    if (json['line_items'] != null) {
      lineItems = <OrderLineItems>[];
      json['line_items'].forEach((v) {
        lineItems!.add( OrderLineItems.fromJson(v));
      });
    }
    if (json['tax_lines'] != null) {
      taxLines = <OrderTaxLines>[];
      json['tax_lines'].forEach((v) {
        taxLines!.add( OrderTaxLines.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = <OrderShippingLines>[];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add( OrderShippingLines.fromJson(v));
      });
    }
    if (json['fee_lines'] != null) {
      feeLines = json['fee_lines'];
    }
    if (json['coupon_lines'] != null) {
      couponLines = json['coupon_lines'];
    }
    if (json['refunds'] != null) {
      refunds = json['refunds'];

    }
    lLinks = json['_links'] != null ?  OrderLinks.fromJson(json['_links']) : null;
  }

}

class OrderBilling {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  OrderBilling(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.postcode,
        this.country,
        this.email,
        this.phone});

  OrderBilling.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }

}

class OrderShipping {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  OrderShipping(
      {this.firstName,
        this.lastName,
        this.company,
        this.address1,
        this.address2,
        this.city,
        this.state,
        this.postcode,
        this.country});

  OrderShipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }


}

class OrderMetaData {
  int? id;
  String? key;
  String? value;

  OrderMetaData({this.id, this.key, this.value});

  OrderMetaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    value = json['value'];
  }

}

class OrderLineItems {
  int? id;
  String? name;
  int? productId;
  int? variationId;
  int? quantity;
  String? taxClass;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  List<OrderTaxes>? taxes;
  List<OrderMetaData>? metaData;
  String? sku;
  dynamic price;

  OrderLineItems(
      {this.id,
        this.name,
        this.productId,
        this.variationId,
        this.quantity,
        this.taxClass,
        this.subtotal,
        this.subtotalTax,
        this.total,
        this.totalTax,
        this.taxes,
        this.metaData,
        this.sku,
        this.price});

  OrderLineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    taxClass = json['tax_class'];
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    if (json['taxes'] != null) {
      taxes = <OrderTaxes>[];
      json['taxes'].forEach((v) {
        taxes!.add( OrderTaxes.fromJson(v));
      });
    }
    if (json['meta_data'] != null) {
      metaData = <OrderMetaData>[];
      json['meta_data'].forEach((v) {
        metaData!.add( OrderMetaData.fromJson(v));
      });
    }
    sku = json['sku'];
    price = json['price'];
  }

}

class OrderTaxes {
  int? id;
  String? total;
  String? subtotal;

  OrderTaxes({this.id, this.total, this.subtotal});

  OrderTaxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    subtotal = json['subtotal'];
  }

}

class OrderTaxLines {
  int? id;
  String? rateCode;
  int? rateId;
  String? label;
  bool? compound;
  String? taxTotal;
  String? shippingTaxTotal;
  List? metaData;

  OrderTaxLines(
      {this.id,
        this.rateCode,
        this.rateId,
        this.label,
        this.compound,
        this.taxTotal,
        this.shippingTaxTotal,
        this.metaData});

  OrderTaxLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rateCode = json['rate_code'];
    rateId = json['rate_id'];
    label = json['label'];
    compound = json['compound'];
    taxTotal = json['tax_total'];
    shippingTaxTotal = json['shipping_tax_total'];
    if (json['meta_data'] != null) {
      metaData = json['meta_data'];
    }
  }

}

class OrderShippingLines {
  int? id;
  String? methodTitle;
  String? methodId;
  String? total;
  String? totalTax;
  List? taxes;
  List? metaData;

  OrderShippingLines(
      {this.id,
        this.methodTitle,
        this.methodId,
        this.total,
        this.totalTax,
        this.taxes,
        this.metaData});

  OrderShippingLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodTitle = json['method_title'];
    methodId = json['method_id'];
    total = json['total'];
    totalTax = json['total_tax'];
    if (json['taxes'] != null) {
      taxes = json['taxes'];
    }
    if (json['meta_data'] != null) {
      metaData = json['meta_data'];
    }
  }

}

class OrderLinks {
  List<OrderSelf>? self;
  List? collection;

  OrderLinks({this.self, this.collection});

  OrderLinks.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = <OrderSelf>[];
      json['self'].forEach((v) {
        self!.add( OrderSelf.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection =  json['collection'];
    }
  }
}

class OrderSelf {
  String? href;

  OrderSelf({this.href});

  OrderSelf.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

}
