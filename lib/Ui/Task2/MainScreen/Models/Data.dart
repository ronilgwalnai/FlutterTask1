class Data {
  Data({
      this.bannerId, 
      this.bannerName, 
      this.bannerImage, 
      this.displayOrder, 
      this.bannerImageUrl,});

  Data.fromJson(dynamic json) {
    bannerId = json['banner_id'];
    bannerName = json['banner_name'];
    bannerImage = json['banner_image'];
    displayOrder = json['display_order'];
    bannerImageUrl = json['banner_image_url'];
  }
  String? bannerId;
  String? bannerName;
  String? bannerImage;
  String? displayOrder;
  String? bannerImageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['banner_id'] = bannerId;
    map['banner_name'] = bannerName;
    map['banner_image'] = bannerImage;
    map['display_order'] = displayOrder;
    map['banner_image_url'] = bannerImageUrl;
    return map;
  }

}