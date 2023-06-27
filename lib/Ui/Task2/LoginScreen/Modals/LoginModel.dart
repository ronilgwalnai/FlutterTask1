
class LoginModel {
  LoginModel({
      required this.status,
      required this.message,
      required this.data,});

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  @override
  String toString() {
    return 'LoginModel{status: $status, message: $message, data: $data}';
  }

  String? status;
  String? message;
  dynamic data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['data'] = data;
    return map;
  }

}