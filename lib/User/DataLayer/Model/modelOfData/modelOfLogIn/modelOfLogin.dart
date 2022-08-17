class LoginResultModel {
  bool? status;
  String? type;
  ClientData? client;
  String? token;

  LoginResultModel({this.status, this.type, this.client, this.token});

  LoginResultModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    client =
        json['client'] != null ? ClientData.fromJson(json['client']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['type'] = type;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class ClientData {
  int? id;
  String? userName;
  String? email;
  String? country;
  String? city;
  String? image;
  int? gender;
  String? phone;

  ClientData(
      {this.id,
      this.userName,
      this.email,
      this.country,
      this.city,
      this.image,
      this.gender,
      this.phone});

  ClientData.fromJson(Map<String, dynamic> json) {
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
