class GetProfileDataModel {
  bool? status;
  CompanyProfile? companyProfile;

  GetProfileDataModel({this.status, this.companyProfile});

  GetProfileDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    companyProfile =
        json['RC'] != null ? new CompanyProfile.fromJson(json['RC']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.companyProfile != null) {
      data['RC'] = this.companyProfile!.toJson();
    }
    return data;
  }
}

class CompanyProfile {
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

  CompanyProfile(
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

  CompanyProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    motherCompany = json['mother_company'];
    image = json['image'];
    address = json['address'];
    about = json['about'];
    branchesNum = int.tryParse(json['branches_num']) ?? 0;
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
