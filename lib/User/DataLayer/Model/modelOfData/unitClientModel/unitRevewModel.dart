class UnitReviewModel {
  bool? status;
  Review? review;

  UnitReviewModel({this.status, this.review});

  UnitReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    review = json['review'] != null ? Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (review != null) {
      data['review'] = review!.toJson();
    }
    return data;
  }
}

class Review {
  int? id;
  Client? client;
  dynamic company;
  String? body;
  double? strNum;
  bool? myReview;
  String? date;

  Review(
      {this.id,
      this.client,
      this.company,
      this.body,
      this.strNum,
      this.myReview,
      this.date});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    company = json['company'];
    body = json['body'];
    strNum = json['strNum'];
    myReview = json['myReview'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    data['company'] = company;
    data['body'] = body;
    data['strNum'] = strNum;
    data['myReview'] = myReview;
    data['date'] = date;
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
