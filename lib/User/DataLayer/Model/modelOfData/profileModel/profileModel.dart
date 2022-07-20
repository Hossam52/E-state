class ProfileModel {
  bool? status;
  Client? client;

  ProfileModel({this.status, this.client});

  ProfileModel.fromJson(Map<String, dynamic> json) {
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

class ChangePassModel {
  bool? status;
  String? message;

  ChangePassModel({this.message, this.status});

  ChangePassModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
