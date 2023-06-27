class Data {
  Data({
      this.userId, 
      this.communityId, 
      this.locationId, 
      this.name, 
      this.email, 
      this.mobile, 
      this.deviceId, 
      this.platformType, 
      this.address1, 
      this.address2, 
      this.areaId, 
      this.country, 
      this.state, 
      this.city, 
      this.zipcode, 
      this.latitude, 
      this.longitude, 
      this.otpCode, 
      this.driverCode, 
      this.status, 
      this.isSecurityDeposited, 
      this.securityDeposit, 
      this.cashConversionPoint, 
      this.bagsRequiredId, 
      this.bagsRequired, 
      this.bagsDelivered, 
      this.bagsDeliveredStatus, 
      this.profilePic, 
      this.userType, 
      this.userToken, 
      this.geofencingAddress, 
      this.addressType, 
      this.referralCode, 
      this.referralCodeUsed, 
      this.isReferralCodeUsed, 
      this.forMarketing, 
      this.addressOfShop, 
      this.proofOfBusiness, 
      this.typeOfBusiness, 
      this.pictureOfShop, 
      this.isApprove, 
      this.creationDatetime, 
      this.updationDatetime, 
      this.communityName, 
      this.locationName, 
      this.qrCode, 
      this.qrCodeUrl,});

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    communityId = json['community_id'];
    locationId = json['location_id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    deviceId = json['device_id'];
    platformType = json['platform_type'];
    address1 = json['address1'];
    address2 = json['address2'];
    areaId = json['area_id'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    zipcode = json['zipcode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    otpCode = json['otp_code'];
    driverCode = json['driver_code'];
    status = json['status'];
    isSecurityDeposited = json['is_security_deposited'];
    securityDeposit = json['security_deposit'];
    cashConversionPoint = json['cash_conversion_point'];
    bagsRequiredId = json['bags_required_id'];
    bagsRequired = json['bags_required'];
    bagsDelivered = json['bags_delivered'];
    bagsDeliveredStatus = json['bags_delivered_status'];
    profilePic = json['profile_pic'];
    userType = json['user_type'];
    userToken = json['user_token'];
    geofencingAddress = json['geofencing_address'];
    addressType = json['address_type'];
    referralCode = json['referral_code'];
    referralCodeUsed = json['referral_code_used'];
    isReferralCodeUsed = json['is_referral_code_used'];
    forMarketing = json['for_marketing'];
    addressOfShop = json['address_of_shop'];
    proofOfBusiness = json['proof_of_business'];
    typeOfBusiness = json['type_of_business'];
    pictureOfShop = json['picture_of_shop'];
    isApprove = json['is_approve'];
    creationDatetime = json['creation_datetime'];
    updationDatetime = json['updation_datetime'];
    communityName = json['community_name'];
    locationName = json['location_name'];
    qrCode = json['qr_code'];
    qrCodeUrl = json['qr_code_url'];
  }
  String? userId;
  String? communityId;
  String? locationId;
  String? name;
  String? email;
  String? mobile;
  String? deviceId;
  String? platformType;
  String? address1;
  String? address2;
  String? areaId;
  String? country;
  String? state;
  String? city;
  String? zipcode;
  String? latitude;
  String? longitude;
  String? otpCode;
  String? driverCode;
  String? status;
  String? isSecurityDeposited;
  String? securityDeposit;
  String? cashConversionPoint;
  String? bagsRequiredId;
  String? bagsRequired;
  String? bagsDelivered;
  String? bagsDeliveredStatus;
  String? profilePic;
  String? userType;
  String? userToken;
  String? geofencingAddress;
  String? addressType;
  String? referralCode;
  String? referralCodeUsed;
  String? isReferralCodeUsed;
  String? forMarketing;
  dynamic addressOfShop;
  String? proofOfBusiness;
  dynamic typeOfBusiness;
  String? pictureOfShop;
  String? isApprove;
  String? creationDatetime;
  String? updationDatetime;
  dynamic communityName;
  String? locationName;
  String? qrCode;
  String? qrCodeUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['community_id'] = communityId;
    map['location_id'] = locationId;
    map['name'] = name;
    map['email'] = email;
    map['mobile'] = mobile;
    map['device_id'] = deviceId;
    map['platform_type'] = platformType;
    map['address1'] = address1;
    map['address2'] = address2;
    map['area_id'] = areaId;
    map['country'] = country;
    map['state'] = state;
    map['city'] = city;
    map['zipcode'] = zipcode;
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['otp_code'] = otpCode;
    map['driver_code'] = driverCode;
    map['status'] = status;
    map['is_security_deposited'] = isSecurityDeposited;
    map['security_deposit'] = securityDeposit;
    map['cash_conversion_point'] = cashConversionPoint;
    map['bags_required_id'] = bagsRequiredId;
    map['bags_required'] = bagsRequired;
    map['bags_delivered'] = bagsDelivered;
    map['bags_delivered_status'] = bagsDeliveredStatus;
    map['profile_pic'] = profilePic;
    map['user_type'] = userType;
    map['user_token'] = userToken;
    map['geofencing_address'] = geofencingAddress;
    map['address_type'] = addressType;
    map['referral_code'] = referralCode;
    map['referral_code_used'] = referralCodeUsed;
    map['is_referral_code_used'] = isReferralCodeUsed;
    map['for_marketing'] = forMarketing;
    map['address_of_shop'] = addressOfShop;
    map['proof_of_business'] = proofOfBusiness;
    map['type_of_business'] = typeOfBusiness;
    map['picture_of_shop'] = pictureOfShop;
    map['is_approve'] = isApprove;
    map['creation_datetime'] = creationDatetime;
    map['updation_datetime'] = updationDatetime;
    map['community_name'] = communityName;
    map['location_name'] = locationName;
    map['qr_code'] = qrCode;
    map['qr_code_url'] = qrCodeUrl;
    return map;
  }

}