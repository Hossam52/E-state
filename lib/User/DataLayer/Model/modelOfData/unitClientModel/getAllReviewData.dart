class GetAllReviewData {
  bool? status;
  AllReviews? reviews;

  GetAllReviewData({this.status, this.reviews});

  GetAllReviewData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reviews =
        json['reviews'] != null ? AllReviews.fromJson(json['reviews']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (reviews != null) {
      data['reviews'] = reviews!.toJson();
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
        data!.add(DataAllReview.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? MetaUnitReview.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}
