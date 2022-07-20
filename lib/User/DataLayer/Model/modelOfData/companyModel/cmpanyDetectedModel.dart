class CompanyDetectedModel {
  bool? status;
  CompanyDetectedData? company;

  CompanyDetectedModel({this.status, this.company});

  CompanyDetectedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    company = json['company'] != null
        ? new CompanyDetectedData.fromJson(json['company'])
        : null;
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

class CompanyDetectedData {
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
  List<MyBranches>? myBranches;
  String? date;

  CompanyDetectedData(
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
      this.myBranches,
      this.date});

  CompanyDetectedData.fromJson(Map<String, dynamic> json) {
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
    if (json['myBranches'] != null) {
      myBranches = <MyBranches>[];
      json['myBranches'].forEach((v) {
        myBranches!.add(new MyBranches.fromJson(v));
      });
    }
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
    if (this.myBranches != null) {
      data['myBranches'] = this.myBranches!.map((v) => v.toJson()).toList();
    }
    data['date'] = this.date;
    return data;
  }
}

class MyBranches {
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
  List<String>? myBranches;
  String? date;

  MyBranches(
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
      this.myBranches,
      this.date});

  MyBranches.fromJson(Map<String, dynamic> json) {
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
    if (json['myBranches'] != null) {
      myBranches = <String>[];
      json['myBranches'].forEach((v) {
        myBranches?.add(myBranches![v]);
      });
    }
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
    if (this.myBranches != null) {
      data['myBranches'] = this.myBranches!.map((v) => v).toList();
    }
    data['date'] = this.date;
    return data;
  }
}
