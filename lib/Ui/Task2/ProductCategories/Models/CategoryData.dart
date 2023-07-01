class CategoryData {
  CategoryData({
      required this.productCategoryId,
      required this.productCategoryName,
      required this.productCategoryImage,});

  CategoryData.fromJson(dynamic json) {
    productCategoryId = json['product_category_id'];
    productCategoryName = json['product_category_name'];
    productCategoryImage = json['product_category_image'];
  }
  String? productCategoryId;
  String? productCategoryName;
  String? productCategoryImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_category_id'] = productCategoryId;
    map['product_category_name'] = productCategoryName;
    map['product_category_image'] = productCategoryImage;
    return map;
  }

}