class ResultCompanyVerifyModel {
  bool? status;
  String? type;
  Company? company;
  String? token;

  ResultCompanyVerifyModel({this.status, this.type, this.company, this.token});

  ResultCompanyVerifyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['type'] = type;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? email;
  String? country;
  String? city;
  dynamic motherCompany;
  String? image;
  String? address;
  String? about;
  int? branchesNum;
  String? type;
  String? regestrationNum;
  String? phone;

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
      this.phone});

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
    return data;
  }
}
