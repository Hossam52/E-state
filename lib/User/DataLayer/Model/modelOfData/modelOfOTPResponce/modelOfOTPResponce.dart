class OTPVerificationResultModel {
  bool? status;
  Client? client;
  String? token;

  OTPVerificationResultModel({this.status, this.client, this.token});

  OTPVerificationResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    client =
        json['client'] != null ? Client.fromJson(json['client']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Client {
  int? id;
  String? userName;
  String? email;
  String? country;
  String? city;
  String? image;
  int? gender;
  String? phone;

  Client(
      {this.id,
      this.userName,
      this.email,
      this.country,
      this.city,
      this.image,
      this.gender,
      this.phone});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    image = json['image'];
    gender = json['gender'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['email'] = email;
    data['country'] = country;
    data['city'] = city;
    data['image'] = image;
    data['gender'] = gender;
    data['phone'] = phone;
    return data;
  }
}
