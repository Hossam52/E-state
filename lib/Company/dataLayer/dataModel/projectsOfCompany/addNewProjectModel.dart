class AddNewProjectModel {
  bool? status;
  Project? project;

  AddNewProjectModel({this.status, this.project});

  AddNewProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    project =
        json['project'] != null ? new Project.fromJson(json['project']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.project != null) {
      data['project'] = this.project!.toJson();
    }
    return data;
  }
}

class Project {
  int? id;
  String? title;
  String? long;
  String? lat;
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
    deliveryDate = json['delivery_date'];
    description = json['description'];
    company = json['company'];
    numOfUnits = json['num_of_units'];
    status = json['status'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['long'] = this.long;
    data['lat'] = this.lat;
    data['delivery_date'] = this.deliveryDate;
    data['description'] = this.description;
    data['company'] = this.company;
    data['num_of_units'] = this.numOfUnits;
    data['status'] = this.status;
    data['image'] = this.image;
    return data;
  }
}
