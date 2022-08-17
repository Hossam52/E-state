class CompanyDetectedModel {
  bool? status;
  CompanyDetectedData? company;

  CompanyDetectedModel({this.status, this.company});

  CompanyDetectedModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    company = json['company'] != null
        ? CompanyDetectedData.fromJson(json['company'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (company != null) {
      data['company'] = company!.toJson();
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
  String? branchesNum;
  String? type;
  String? regestrationNum;
  String? phone;
  String? reason;
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
    branchesNum = json['branches_num'].toString();
    type = json['type'];
    regestrationNum = json['regestration_num'];
    phone = json['phone'];
    reason = json['reason'];
    status = json['status'];
    if (json['myBranches'] != null) {
      myBranches = <MyBranches>[];
      json['myBranches'].forEach((v) {
        myBranches!.add(MyBranches.fromJson(v));
      });
    }
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
    if (myBranches != null) {
      data['myBranches'] = myBranches!.map((v) => v.toJson()).toList();
    }
    data['date'] = date;
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
  String? branchesNum;
  String? type;
  String? regestrationNum;
  String? phone;
  dynamic reason;
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
    branchesNum = json['branches_num']?.toString();
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
    if (myBranches != null) {
      data['myBranches'] = myBranches!.map((v) => v).toList();
    }
    data['date'] = date;
    return data;
  }
}
