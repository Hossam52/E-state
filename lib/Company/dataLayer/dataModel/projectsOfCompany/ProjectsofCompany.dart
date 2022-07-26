import 'package:osol/common_models/pagination/links.dart';
import 'package:osol/common_models/pagination/meta.dart';

class AllProjectsModel {
  bool? status;
  Projects? project;

  AllProjectsModel({this.status, this.project});

  AllProjectsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    project =
        json['project'] != null ? Projects.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (project != null) {
      data['project'] = project!.toJson();
    }
    return data;
  }
}

class Projects {
  List<DataOfProjects>? data;
  Links? links;
  Meta? meta;

  Projects({this.data, this.links, this.meta});

  Projects.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataOfProjects>[];
      json['data'].forEach((v) {
        data!.add(DataOfProjects.fromJson(v));
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

class DataOfProjects {
  int? id;
  String? title;
  String? long;
  String? lat;
  String? countryId;
  String? cityId;
  String? country;
  String? city;
  String? deliveryDate;
  String? description;
  String? company;
  String? numOfUnits;
  String? status;
  String? image;

  DataOfProjects(
      {this.id,
      this.title,
      this.long,
      this.lat,
      this.countryId,
      this.cityId,
      this.country,
      this.city,
      this.deliveryDate,
      this.description,
      this.company,
      this.numOfUnits,
      this.status,
      this.image});

  DataOfProjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    long = json['long'];
    lat = json['lat'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    country = json['country'];
    city = json['city'];
    deliveryDate = json['delivery_date'];
    description = json['description'];
    company = json['company'];
    numOfUnits = json['num_of_units'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['long'] = long;
    data['lat'] = lat;
    data['country_id'] = countryId;
    data['city_id'] = cityId;
    data['country'] = country;
    data['city'] = city;
    data['delivery_date'] = deliveryDate;
    data['description'] = description;
    data['company'] = company;
    data['num_of_units'] = numOfUnits;
    data['status'] = status;
    data['image'] = image;
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
//         this.from,
//         this.lastPage,
//         this.path,
//         this.perPage,
//         this.to,
//         this.total});

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
