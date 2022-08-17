import 'package:osol/common_models/pagination/links.dart';
import 'package:osol/common_models/pagination/meta.dart';

class CompanyDetectedReviewModel {
  bool? status;
  CompanyReview? reviews;

  CompanyDetectedReviewModel({this.status, this.reviews});

  CompanyDetectedReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reviews = json['reviews'] != null
        ? CompanyReview.fromJson(json['reviews'])
        : null;
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

class CompanyReview {
  List<DataOfReview>? data;
  Links? links;
  Meta? meta;

  CompanyReview({this.data, this.links, this.meta});

  CompanyReview.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataOfReview>[];
      json['data'].forEach((v) {
        data!.add(DataOfReview.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
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
    client = json['client'] != null ? Client.fromJson(json['client']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    body = json['body'];
    strNum = json['strNum']?.toDouble();
    myReview = json['myReview'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (client != null) {
      data['client'] = client!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
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
  String? branchesNum;
  String? type;
  String? regestrationNum;
  String? phone;
  dynamic reason;
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
    branchesNum = json['branches_num'].toString();
    type = json['type'];
    regestrationNum = json['regestration_num'];
    phone = json['phone'];
    reason = json['reason'];
    status = json['status'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['country'] = country;
    data['city'] = city;
    data['mother_company'] = motherCompany;
    data['image'] = image;
    data['address'] = address;
    data['about'] = about;
    data['branches_num'] = branchesNum;
    data['type'] = type;
    data['regestration_num'] = regestrationNum;
    data['phone'] = phone;
    data['reason'] = reason;
    data['status'] = status;
    data['date'] = date;
    return data;
  }
}
