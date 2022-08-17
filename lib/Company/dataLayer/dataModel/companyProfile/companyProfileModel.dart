class CompanyProfileModel {
  bool? status;
  Company? company;

  CompanyProfileModel({this.status, this.company});

  CompanyProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    company =
    json['company'] != null ? Company.fromJson(json['company']) : null;
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
