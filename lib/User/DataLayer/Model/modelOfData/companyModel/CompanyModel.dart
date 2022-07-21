class CompanyModel {
  bool? status;
  Company? company;

  CompanyModel({this.status, this.company});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    company =
    json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    return data;
  }
}

class Company {
  List<CompanyData>? data;
  Links? links;
  Meta? meta;

  Company({this.data, this.links, this.meta});

  Company.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CompanyData>[];
      json['data'].forEach((v) {
        data!.add(new CompanyData.fromJson(v));
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

class CompanyData {
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

  CompanyData(
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
        this.phone});

  CompanyData.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Links {
  String? first;
  String? last;
  Null? prev;
  Null? next;

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
