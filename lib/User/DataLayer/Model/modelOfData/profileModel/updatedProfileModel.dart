class UploadedDataModel {
  bool? status;
  Client? client;

  UploadedDataModel({this.status, this.client});

  UploadedDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (client != null) {
      data['client'] = client!.toJson();
    }
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
  dynamic reason;
  String? status;

  Client(
      {this.id,
      this.userName,
      this.email,
      this.country,
      this.city,
      this.image,
      this.gender,
      this.phone,
      this.reason,
      this.status});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    image = json['image'];
    gender = json['gender'];
    phone = json['phone'];
    reason = json['reason'];
    status = json['status'];
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
    data['reason'] = reason;
    data['status'] = status;
    return data;
  }
}
