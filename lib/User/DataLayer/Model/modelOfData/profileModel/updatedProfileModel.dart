class UploadedDataModel {
  bool? status;
  Client? client;

  UploadedDataModel({this.status, this.client});

  UploadedDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
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
  Null? reason;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_name'] = this.userName;
    data['email'] = this.email;
    data['country'] = this.country;
    data['city'] = this.city;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['reason'] = this.reason;
    data['status'] = this.status;
    return data;
  }
}
