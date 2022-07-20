class CompanyDetectedReviewModel {
  bool? status;
  CompanyReview? reviews;

  CompanyDetectedReviewModel({this.status, this.reviews});

  CompanyDetectedReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reviews =
    json['reviews'] != null ? new CompanyReview.fromJson(json['reviews']) : null;
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

class CompanyReview {
  List<DataOfReview>? data;
  Links? links;
  Meta? meta;

  CompanyReview({this.data, this.links, this.meta});

  CompanyReview.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataOfReview>[];
      json['data'].forEach((v) {
        data!.add(new DataOfReview.fromJson(v));
      });
    }
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
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

class DataOfReview {
  int? id;
  Client? client;
  Company? company;
  String? body;
  double? strNum;
  bool? myReview;
  String? date;

  DataOfReview(
      {this.id,
        this.client,
        this.company,
        this.body,
        this.strNum,
        this.myReview,
        this.date});

  DataOfReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    client =
    json['client'] != null ? new Client.fromJson(json['client']) : null;
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    body = json['body'];
    strNum = json['strNum']?.toDouble();
    myReview = json['myReview'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.client != null) {
      data['client'] = this.client!.toJson();
    }
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
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

class Company {
  int? id;
  String? name;
  String? email;
  String? country;
  String? city;
  String? motherCompany;
  String? image;
  String? address;
  String? about;
  int? branchesNum;
  String? type;
  String? regestrationNum;
  String? phone;
  Null? reason;
  String? status;
  String? date;

  Company(
      {this.id,
        this.name,
        this.email,
        this.country,
        this.city,
        this.motherCompany,
        this.image,
        this.address,
        this.about,
        this.branchesNum,
        this.type,
        this.regestrationNum,
        this.phone,
        this.reason,
        this.status,
        this.date});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    motherCompany = json['mother_company'];
    image = json['image'];
    address = json['address'];
    about = json['about'];
    branchesNum = json['branches_num'];
    type = json['type'];
    regestrationNum = json['regestration_num'];
    phone = json['phone'];
    reason = json['reason'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['country'] = this.country;
    data['city'] = this.city;
    data['mother_company'] = this.motherCompany;
    data['image'] = this.image;
    data['address'] = this.address;
    data['about'] = this.about;
    data['branches_num'] = this.branchesNum;
    data['type'] = this.type;
    data['regestration_num'] = this.regestrationNum;
    data['phone'] = this.phone;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['date'] = this.date;
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

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,
        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
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
