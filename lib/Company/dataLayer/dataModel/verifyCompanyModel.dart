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
    json['company'] != null ? new Company.fromJson(json['company']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['type'] = this.type;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Company {
  int? id;
  String? name;
  String? email;
  String? country;
  String? city;
  Null? motherCompany;
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
