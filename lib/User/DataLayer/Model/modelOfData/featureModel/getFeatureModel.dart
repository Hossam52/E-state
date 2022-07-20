class ClientFeatureModel {
  bool? status;
  Units? units;

  ClientFeatureModel({this.status, this.units});

  ClientFeatureModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    units = json['units'] != null ? new Units.fromJson(json['units']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.units != null) {
      data['units'] = this.units!.toJson();
    }
    return data;
  }
}

class Units {
  List<FeatureData>? data;
  Links? links;
  Meta? meta;

  Units({this.data, this.links, this.meta});

  Units.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FeatureData>[];
      json['data'].forEach((v) {
        data!.add(new FeatureData.fromJson(v));
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

class FeatureData {
  int? id;
  String? title;
  String? type;
  String? requiredFields;
  String? view;
  String? description;
  String? purpose;
  int? downPayment;
  int? monthlyPayment;
  int? deposite;
  int? numYears;
  int? price;
  String? paymentMethod;
  String? city;
  String? country;
  int? countryId;
  int? cityId;
  int? areaId;
  bool? available;
  String? availableDate;
  String? lat;
  String? long;
  String? video;
  int? rooms;
  int? bathroom;
  int? floor;
  int? yearBuild;
  int? area;
  int? bedrooms;
  String? finishedType;
  int? metro;
  int? train;
  int? bus;
  int? pharmacy;
  int? beach;
  int? bakary;
  int? resturant;
  int? coffe;
  String? airCondition;
  String? cableTv;
  String? computer;
  String? gasLine;
  String? dishwasher;
  String? internet;
  String? heater;
  String? microwave;
  String? balcony;
  String? lift;
  String? grill;
  String? pool;
  String? parking;
  String? recption;
  String? security;
  String? addType;
  String? companyId;
  String? status;
  List<String>? images;
  int? watchNum;
  int? leadNum;
  int? openedNum;
  bool? authWatch;
  bool? authOpen;
  bool? authLead;
  bool? authFavourite;

  FeatureData(
      {this.id,
      this.city,
      this.country,
      this.title,
      this.type,
      this.requiredFields,
      this.view,
      this.description,
      this.purpose,
      this.downPayment,
      this.monthlyPayment,
      this.deposite,
      this.numYears,
      this.price,
      this.paymentMethod,
      this.countryId,
      this.cityId,
      this.areaId,
      this.available,
      this.availableDate,
      this.lat,
      this.long,
      this.video,
      this.rooms,
      this.bathroom,
      this.floor,
      this.yearBuild,
      this.area,
      this.bedrooms,
      this.finishedType,
      this.metro,
      this.train,
      this.bus,
      this.pharmacy,
      this.beach,
      this.bakary,
      this.resturant,
      this.coffe,
      this.airCondition,
      this.cableTv,
      this.computer,
      this.gasLine,
      this.dishwasher,
      this.internet,
      this.heater,
      this.microwave,
      this.balcony,
      this.lift,
      this.grill,
      this.pool,
      this.parking,
      this.recption,
      this.security,
      this.addType,
      this.companyId,
      this.status,
      this.images,
      this.watchNum,
      this.leadNum,
      this.openedNum,
      this.authWatch,
      this.authOpen,
      this.authLead,
      this.authFavourite});

  FeatureData.fromJson(Map<String, dynamic> json) {
    city = json["city"];
    country = json["country"];
    id = json['id'];
    title = json['title'];
    type = json['type'];
    requiredFields = json['required_fields'];
    view = json['view'];
    description = json['description'];
    purpose = json['purpose'];
    downPayment = json['down_payment'];
    monthlyPayment = json['monthly_payment'];
    deposite = json['deposite'];
    numYears = json['num_years'];
    price = json['price'];
    paymentMethod = json['payment_method'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    available = json['available'];
    availableDate = json['available_date'];
    lat = json['lat'];
    long = json['long'];
    video = json['video'];
    rooms = json['rooms'];
    bathroom = json['bathroom'];
    floor = json['floor'];
    yearBuild = json['year_build'];
    area = json['area'];
    bedrooms = json['bedrooms'];
    finishedType = json['finished_type'];
    metro = json['metro'];
    train = json['train'];
    bus = json['bus'];
    pharmacy = json['pharmacy'];
    beach = json['beach'];
    bakary = json['bakary'];
    resturant = json['resturant'];
    coffe = json['coffe'];
    airCondition = json['air_condition'];
    cableTv = json['cable_tv'];
    computer = json['computer'];
    gasLine = json['gas_line'];
    dishwasher = json['dishwasher'];
    internet = json['internet'];
    heater = json['heater'];
    microwave = json['microwave'];
    balcony = json['balcony'];
    lift = json['lift'];
    grill = json['grill'];
    pool = json['pool'];
    parking = json['parking'];
    recption = json['recption'];
    security = json['security'];
    addType = json['add_type'];
    companyId = json['company_id'];
    status = json['status'];
    images = json['images'].cast<String>();
    watchNum = json['watch_num'];
    leadNum = json['lead_num'];
    openedNum = json['opened_num'];
    authWatch = json['auth_watch'];
    authOpen = json['auth_open'];
    authLead = json['auth_lead'];
    authFavourite = json['auth_Favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data["city"]=this.city;
    data["country"]=this.country;
    data['title'] = this.title;
    data['type'] = this.type;
    data['required_fields'] = this.requiredFields;
    data['view'] = this.view;
    data['description'] = this.description;
    data['purpose'] = this.purpose;
    data['down_payment'] = this.downPayment;
    data['monthly_payment'] = this.monthlyPayment;
    data['deposite'] = this.deposite;
    data['num_years'] = this.numYears;
    data['price'] = this.price;
    data['payment_method'] = this.paymentMethod;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    data['area_id'] = this.areaId;
    data['available'] = this.available;
    data['available_date'] = this.availableDate;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['video'] = this.video;
    data['rooms'] = this.rooms;
    data['bathroom'] = this.bathroom;
    data['floor'] = this.floor;
    data['year_build'] = this.yearBuild;
    data['area'] = this.area;
    data['bedrooms'] = this.bedrooms;
    data['finished_type'] = this.finishedType;
    data['metro'] = this.metro;
    data['train'] = this.train;
    data['bus'] = this.bus;
    data['pharmacy'] = this.pharmacy;
    data['beach'] = this.beach;
    data['bakary'] = this.bakary;
    data['resturant'] = this.resturant;
    data['coffe'] = this.coffe;
    data['air_condition'] = this.airCondition;
    data['cable_tv'] = this.cableTv;
    data['computer'] = this.computer;
    data['gas_line'] = this.gasLine;
    data['dishwasher'] = this.dishwasher;
    data['internet'] = this.internet;
    data['heater'] = this.heater;
    data['microwave'] = this.microwave;
    data['balcony'] = this.balcony;
    data['lift'] = this.lift;
    data['grill'] = this.grill;
    data['pool'] = this.pool;
    data['parking'] = this.parking;
    data['recption'] = this.recption;
    data['security'] = this.security;
    data['add_type'] = this.addType;
    data['company_id'] = this.companyId;
    data['status'] = this.status;
    data['images'] = this.images;
    data['watch_num'] = this.watchNum;
    data['lead_num'] = this.leadNum;
    data['opened_num'] = this.openedNum;
    data['auth_watch'] = this.authWatch;
    data['auth_open'] = this.authOpen;
    data['auth_lead'] = this.authLead;
    data['auth_Favourite'] = this.authFavourite;
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
