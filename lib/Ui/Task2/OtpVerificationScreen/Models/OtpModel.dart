import 'OtpData.dart';

class OtpModels {
  OtpModels({
    this.status,
    this.message,
    this.data,
  });

  OtpModels.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json[data] != null) {
      data = Data.fromJson(json['data']);
    }
  }

  String? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.toJson();
    }
    return map;
  }
}
