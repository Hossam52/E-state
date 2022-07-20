class GetAllReviewData {
  bool? status;
  AllReviews? reviews;

  GetAllReviewData({this.status, this.reviews});

  GetAllReviewData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reviews =
    json['reviews'] != null ? new AllReviews.fromJson(json['reviews']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.toJson();
    }
    return data;
  }
}

class AllReviews {
  List<DataAllReview>? data;
  Links? links;
  MetaUnitReview? meta;

  AllReviews({this.data, this.links, this.meta});

  AllReviews.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataAllReview>[];
      json['data'].forEach((v) {
        data!.add(new DataAllReview.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new MetaUnitReview.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class DataAllReview {
  int? id;
  Client? client;
  String? company;
  String? body;
  var strNum;
  bool? myReview;
  String? date;

  DataAllReview(
      {this.id,
        this.client,
        this.company,
        this.body,
        this.strNum,
        this.myReview,
        this.date});

  DataAllReview.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['last'] = this.last;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}

class MetaUnitReview {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  MetaUnitReview(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  MetaUnitReview.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
