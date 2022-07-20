class UnitReviewModel {
  bool? status;
  Review? review;

  UnitReviewModel({this.status, this.review});

  UnitReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    review =
    json['review'] != null ? new Review.fromJson(json['review']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.review != null) {
      data['review'] = this.review!.toJson();
    }
    return data;
  }
}

class Review {
  int? id;
  Client? client;
  Null? company;
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
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
    company = json['company'];
    body = json['body'];
    strNum = json['strNum'];
    myReview = json['myReview'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    data['company'] = this.company;
    data['body'] = this.body;
    data['strNum'] = this.strNum;
    data['myReview'] = this.myReview;
    data['date'] = this.date;
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
