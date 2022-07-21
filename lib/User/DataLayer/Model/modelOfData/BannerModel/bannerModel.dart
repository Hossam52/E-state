import 'package:osol/common_models/pagination/links.dart';
import 'package:osol/common_models/pagination/meta.dart';

class ClientBannerModel {
  bool? status;
  Banners? banners;

  ClientBannerModel({this.status, this.banners});

  ClientBannerModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    banners =
        json['banners'] != null ? new Banners.fromJson(json['banners']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.banners != null) {
      data['banners'] = this.banners!.toJson();
    }
    return data;
  }
}

class Banners {
  List<DataOfBanner>? data;
  Links? links;
  Meta? meta;

  Banners({this.data, this.links, this.meta});

  Banners.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataOfBanner>[];
      json['data'].forEach((v) {
        data!.add(new DataOfBanner.fromJson(v));
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

class DataOfBanner {
  int? id;
  String? title;
  String? videoUrl;
  String? endDate;
  String? description;
  String? company;
  String? image;
  String? status;

  DataOfBanner(
      {this.id,
      this.title,
      this.videoUrl,
      this.endDate,
      this.description,
      this.company,
      this.image,
      this.status});

  DataOfBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['video_url'];
    endDate = json['end_date'];
    description = json['description'];
    company = json['company'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['video_url'] = this.videoUrl;
    data['end_date'] = this.endDate;
    data['description'] = this.description;
    data['company'] = this.company;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

// class Links {
//   String? first;
//   String? last;
//   Null? prev;
//   Null? next;

//   Links({this.first, this.last, this.prev, this.next});

//   Links.fromJson(Map<String, dynamic> json) {
//     first = json['first'];
//     last = json['last'];
//     prev = json['prev'];
//     next = json['next'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['first'] = this.first;
//     data['last'] = this.last;
//     data['prev'] = this.prev;
//     data['next'] = this.next;
//     return data;
//   }
// }

// class Meta {
//   int? currentPage;
//   int? from;
//   int? lastPage;
//   String? path;
//   int? perPage;
//   int? to;
//   int? total;

//   Meta(
//       {this.currentPage,
//       this.from,
//       this.lastPage,
//       this.path,
//       this.perPage,
//       this.to,
//       this.total});

//   Meta.fromJson(Map<String, dynamic> json) {
//     currentPage = json['current_page'];
//     from = json['from'];
//     lastPage = json['last_page'];
//     path = json['path'];
//     perPage = json['per_page'];
//     to = json['to'];
//     total = json['total'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['current_page'] = this.currentPage;
//     data['from'] = this.from;
//     data['last_page'] = this.lastPage;
//     data['path'] = this.path;
//     data['per_page'] = this.perPage;
//     data['to'] = this.to;
//     data['total'] = this.total;
//     return data;
//   }
// }
