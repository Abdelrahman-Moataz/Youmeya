class Welcome {
  int id;
  int parentId;
  String status;
  String currency;
  String version;
  bool pricesIncludeTax;
  DateTime dateCreated;
  DateTime dateModified;
  String discountTotal;
  String discountTax;
  String shippingTotal;
  String shippingTax;
  String cartTax;
  String total;
  String totalTax;
  int customerId;
  String orderKey;
  Ing billing;
  Ing shipping;
  String paymentMethod;
  String paymentMethodTitle;
  String transactionId;
  String customerIpAddress;
  String customerUserAgent;
  String createdVia;
  String customerNote;
  DateTime? dateCompleted;
  DateTime? datePaid;
  String cartHash;
  String number;
  List<WelcomeMetaDatum> metaData;
  List<LineItem> lineItems;
  List<dynamic> taxLines;
  List<ShippingLine> shippingLines;
  List<dynamic> feeLines;
  List<CouponLine> couponLines;
  List<dynamic> refunds;
  String paymentUrl;
  bool isEditable;
  bool needsPayment;
  bool needsProcessing;
  DateTime dateCreatedGmt;
  DateTime dateModifiedGmt;
  DateTime? dateCompletedGmt;
  DateTime? datePaidGmt;
  String currencySymbol;
  Links links;

  Welcome({
    required this.id,
    required this.parentId,
    required this.status,
    required this.currency,
    required this.version,
    required this.pricesIncludeTax,
    required this.dateCreated,
    required this.dateModified,
    required this.discountTotal,
    required this.discountTax,
    required this.shippingTotal,
    required this.shippingTax,
    required this.cartTax,
    required this.total,
    required this.totalTax,
    required this.customerId,
    required this.orderKey,
    required this.billing,
    required this.shipping,
    required this.paymentMethod,
    required this.paymentMethodTitle,
    required this.transactionId,
    required this.customerIpAddress,
    required this.customerUserAgent,
    required this.createdVia,
    required this.customerNote,
    required this.dateCompleted,
    required this.datePaid,
    required this.cartHash,
    required this.number,
    required this.metaData,
    required this.lineItems,
    required this.taxLines,
    required this.shippingLines,
    required this.feeLines,
    required this.couponLines,
    required this.refunds,
    required this.paymentUrl,
    required this.isEditable,
    required this.needsPayment,
    required this.needsProcessing,
    required this.dateCreatedGmt,
    required this.dateModifiedGmt,
    required this.dateCompletedGmt,
    required this.datePaidGmt,
    required this.currencySymbol,
    required this.links,
  });

}

class Ing {
  FirstName firstName;
  LastName lastName;
  String company;
  Address1 address1;
  String address2;
  City city;
  State state;
  String postcode;
  Country country;
  String? email;
  Phone phone;

  Ing({
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.address1,
    required this.address2,
    required this.city,
    required this.state,
    required this.postcode,
    required this.country,
    this.email,
    required this.phone,
  });

}

enum Address1 {
  BBB,
  EMPTY
}

enum City {
  EMPTY,
  THE_7_AMO
}

enum Country {
  EG,
  EMPTY
}

enum FirstName {
  EMPTY,
  MOHAMED
}

enum LastName {
  BOUDA,
  EMPTY
}

enum Phone {
  EMPTY,
  THE_01101234258
}

enum State {
  EGC,
  EMPTY
}

class CouponLine {
  int id;
  String code;
  String discount;
  String discountTax;
  List<CouponLineMetaDatum> metaData;
  String discountType;
  int nominalAmount;
  bool freeShipping;

  CouponLine({
    required this.id,
    required this.code,
    required this.discount,
    required this.discountTax,
    required this.metaData,
    required this.discountType,
    required this.nominalAmount,
    required this.freeShipping,
  });

}

class CouponLineMetaDatum {
  int id;
  String key;
  String value;
  String displayKey;
  String displayValue;

  CouponLineMetaDatum({
    required this.id,
    required this.key,
    required this.value,
    required this.displayKey,
    required this.displayValue,
  });

}

class LineItem {
  int id;
  String name;
  int productId;
  int variationId;
  int quantity;
  String taxClass;
  String subtotal;
  String subtotalTax;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<CouponLineMetaDatum> metaData;
  dynamic sku;
  int price;
  Image image;
  dynamic parentName;

  LineItem({
    required this.id,
    required this.name,
    required this.productId,
    required this.variationId,
    required this.quantity,
    required this.taxClass,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
    required this.sku,
    required this.price,
    required this.image,
    required this.parentName,
  });

}

class Image {
  int id;
  String src;

  Image({
    required this.id,
    required this.src,
  });

}

class Links {
  List<Collection> self;
  List<Collection> collection;
  List<Collection>? customer;

  Links({
    required this.self,
    required this.collection,
    this.customer,
  });

}

class Collection {
  String href;

  Collection({
    required this.href,
  });

}

class WelcomeMetaDatum {
  int id;
  String key;
  dynamic value;

  WelcomeMetaDatum({
    required this.id,
    required this.key,
    required this.value,
  });

}

class ValueClass {
  int? transactionId;
  String? value;
  String? displayShippingAddress;
  String? displayEmail;
  String? displayPhone;
  String? displayDate;
  String? displayNumber;
  String? displayCustomerNotes;
  String? headerLogo;
  String? headerLogoHeight;
  dynamic vatNumber;
  dynamic cocNumber;
  dynamic shopName;
  dynamic shopAddress;
  dynamic footer;
  dynamic extra1;
  dynamic extra2;
  dynamic extra3;
  String? number;
  String? formattedNumber;
  String? prefix;
  String? suffix;
  String? documentType;
  int? orderId;
  String? padding;

  ValueClass({
    this.transactionId,
    this.value,
    this.displayShippingAddress,
    this.displayEmail,
    this.displayPhone,
    this.displayDate,
    this.displayNumber,
    this.displayCustomerNotes,
    this.headerLogo,
    this.headerLogoHeight,
    this.vatNumber,
    this.cocNumber,
    this.shopName,
    this.shopAddress,
    this.footer,
    this.extra1,
    this.extra2,
    this.extra3,
    this.number,
    this.formattedNumber,
    this.prefix,
    this.suffix,
    this.documentType,
    this.orderId,
    this.padding,
  });

}

class CocNumberClass {
  Default cocNumberDefault;

  CocNumberClass({
    required this.cocNumberDefault,
  });

}

enum Default {
  EMPTY,
  YOUMEYA_INC
}

class ShippingLine {
  int id;
  String methodTitle;
  String methodId;
  String instanceId;
  String total;
  String totalTax;
  List<dynamic> taxes;
  List<CouponLineMetaDatum> metaData;

  ShippingLine({
    required this.id,
    required this.methodTitle,
    required this.methodId,
    required this.instanceId,
    required this.total,
    required this.totalTax,
    required this.taxes,
    required this.metaData,
  });

}
