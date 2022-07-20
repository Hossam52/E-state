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
        json['client'] != null ? new ClientData.fromJson(json['client']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    data['token'] = this.token;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['country'] = this.country;
    data['city'] = this.city;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    return data;
  }
}
