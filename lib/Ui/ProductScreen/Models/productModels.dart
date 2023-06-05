class ProductModel {
  ProductModel({
    String? status,
    String? heading,
    String? subheading,
    List<Data>? data,
  }) {
    _status = status;
    _heading = heading;
    _subheading = subheading;
    _data = data;
  }

  ProductModel.fromJson(dynamic json) {
    _status = json['status'];
    _heading = json['heading'];
    _subheading = json['subheading'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  String? _status;
  String? _heading;
  String? _subheading;
  List<Data>? _data;

  ProductModel copyWith({
    String? status,
    String? heading,
    String? subheading,
    List<Data>? data,
  }) =>
      ProductModel(
        status: status ?? _status,
        heading: heading ?? _heading,
        subheading: subheading ?? _subheading,
        data: data ?? _data,
      );

  String? get status => _status;

  String? get heading => _heading;

  String? get subheading => _subheading;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['heading'] = _heading;
    map['subheading'] = _subheading;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    String? id,
    String? cityId,
    String? cityName,
    String? areaName,
    String? pincode,
    String? subscriptionProductId,
    String? subscriptionTitle,
    String? productsId,
    String? productName,
    String? productDescription,
    String? productImage,
    String? price,
    String? allowAddons,
    List<AddOns>? addOns,
  }) {
    _id = id;
    _cityId = cityId;
    _cityName = cityName;
    _areaName = areaName;
    _pincode = pincode;
    _subscriptionProductId = subscriptionProductId;
    _subscriptionTitle = subscriptionTitle;
    _productsId = productsId;
    _productName = productName;
    _productDescription = productDescription;
    _productImage = productImage;
    _price = price;
    _allowAddons = allowAddons;
    _addOns = addOns;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _cityId = json['city_id'];
    _cityName = json['city_name'];
    _areaName = json['area_name'];
    _pincode = json['pincode'];
    _subscriptionProductId = json['subscription_product_id'];
    _subscriptionTitle = json['subscription_title'];
    _productsId = json['products_id'];
    _productName = json['product_name'];
    _productDescription = json['product_description'];
    _productImage = json['product_image'];
    _price = json['price'];
    _allowAddons = json['allow_addons'];
    if (json['add_ons'] != null) {
      _addOns = [];
      json['add_ons'].forEach((v) {
        _addOns?.add(AddOns.fromJson(v));
      });
    }
  }

  String? _id;
  String? _cityId;
  String? _cityName;
  String? _areaName;
  String? _pincode;
  String? _subscriptionProductId;
  String? _subscriptionTitle;
  String? _productsId;
  String? _productName;
  String? _productDescription;
  String? _productImage;
  String? _price;
  String? _allowAddons;
  List<AddOns>? _addOns;

  Data copyWith({
    String? id,
    String? cityId,
    String? cityName,
    String? areaName,
    String? pincode,
    String? subscriptionProductId,
    String? subscriptionTitle,
    String? productsId,
    String? productName,
    String? productDescription,
    String? productImage,
    String? price,
    String? allowAddons,
    List<AddOns>? addOns,
  }) =>
      Data(
        id: id ?? _id,
        cityId: cityId ?? _cityId,
        cityName: cityName ?? _cityName,
        areaName: areaName ?? _areaName,
        pincode: pincode ?? _pincode,
        subscriptionProductId: subscriptionProductId ?? _subscriptionProductId,
        subscriptionTitle: subscriptionTitle ?? _subscriptionTitle,
        productsId: productsId ?? _productsId,
        productName: productName ?? _productName,
        productDescription: productDescription ?? _productDescription,
        productImage: productImage ?? _productImage,
        price: price ?? _price,
        allowAddons: allowAddons ?? _allowAddons,
        addOns: addOns ?? _addOns,
      );

  String? get id => _id;

  String? get cityId => _cityId;

  String? get cityName => _cityName;

  String? get areaName => _areaName;

  String? get pincode => _pincode;

  String? get subscriptionProductId => _subscriptionProductId;

  String? get subscriptionTitle => _subscriptionTitle;

  String? get productsId => _productsId;

  String? get productName => _productName;

  String? get productDescription => _productDescription;

  String? get productImage => _productImage;

  String? get price => _price;

  String? get allowAddons => _allowAddons;

  int quantity = 0;

  List<AddOns>? get addOns => _addOns;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['city_id'] = _cityId;
    map['city_name'] = _cityName;
    map['area_name'] = _areaName;
    map['pincode'] = _pincode;
    map['subscription_product_id'] = _subscriptionProductId;
    map['subscription_title'] = _subscriptionTitle;
    map['products_id'] = _productsId;
    map['product_name'] = _productName;
    map['product_description'] = _productDescription;
    map['product_image'] = _productImage;
    map['price'] = _price;
    map['allow_addons'] = _allowAddons;
    if (_addOns != null) {
      map['add_ons'] = _addOns?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  String toString() {
    return 'Data{_id: $_id, _cityId: $_cityId, _cityName: $_cityName, _areaName: $_areaName, _pincode: $_pincode, _subscriptionProductId: $_subscriptionProductId, _subscriptionTitle: $_subscriptionTitle, _productsId: $_productsId, _productName: $_productName, _productDescription: $_productDescription, _productImage: $_productImage, _price: $_price, _allowAddons: $_allowAddons, _addOns: ${_addOns.toString()}, quantity: $quantity}';
  }
}

/// products_id : "16"
/// product_name : "sambar"
/// price : 0

class AddOns {
  AddOns({
    String? productsId,
    String? productName,
    num? price,
  }) {
    _productsId = productsId;
    _productName = productName;
    _price = price;
  }

  AddOns.fromJson(dynamic json) {
    _productsId = json['products_id'];
    _productName = json['product_name'];
    _price = json['price'];
  }

  String? _productsId;
  String? _productName;
  num? _price;
  int quantity=0;

  AddOns copyWith({
    String? productsId,
    String? productName,
    num? price,
  }) =>
      AddOns(
        productsId: productsId ?? _productsId,
        productName: productName ?? _productName,
        price: price ?? _price,
      );

  String? get productsId => _productsId;

  String? get productName => _productName;

  num? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['products_id'] = _productsId;
    map['product_name'] = _productName;
    map['price'] = _price;
    return map;
  }

  @override
  String toString() {
    return 'AddOns{_productsId: $_productsId, _productName: $_productName, _price: $_price, quantity: $quantity}';
  }
}
