class AddNewProjectModel {
  bool? status;
  Project? project;

  AddNewProjectModel({this.status, this.project});

  AddNewProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
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

class Project {
  int? id;
  String? title;
  String? long;
  String? lat;
  String? country_id;
  String? city_id;
  String? country;
  String? city;
  String? deliveryDate;
  String? description;
  String? company;
  String? numOfUnits;
  String? status;
  String? image;

  Project(
      {this.id,
      this.title,
      this.long,
      this.lat,
      this.country_id,
      this.city_id,
      this.country,
      this.city,
      this.deliveryDate,
      this.description,
      this.company,
      this.numOfUnits,
      this.status,
      this.image});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    long = json['long'];
    lat = json['lat'];
    country_id = json['country_id'];
    city_id = json['city_id'];
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
    data['delivery_date'] = deliveryDate;
    data['description'] = description;
    data['company'] = company;
    data['num_of_units'] = numOfUnits;
    data['status'] = status;
    data['image'] = image;
    return data;
  }
}
