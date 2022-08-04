class UnitModel {
  int? id;
  String? title;
  String? type;
  String? requiredFields;
  String? view;
  String? description;
  String? purpose;

  String? companyName;
  String? companyLogo;
  int? downPayment;
  int? monthlyPayment;
  int? deposite;
  int? numYears;
  int? price;
  String? paymentMethod;
  String? countryId;
  String? cityId;
  String? areaId;
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
  String? country;
  String? city;
  String? cityArea;

  UnitModel({
    this.id,
    this.title,
    this.type,
    this.requiredFields,
    this.view,
    this.description,
    this.purpose,
    this.companyName,
    this.companyLogo,
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
    this.watchNum,
    this.leadNum,
    this.openedNum,
    this.authWatch,
    this.authOpen,
    this.authLead,
    this.authFavourite,
    this.country,
    this.city,
    this.cityArea,
    this.images,
  });
  UnitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = json['type'];
    requiredFields = json['required_fields'];
    view = json['view'];
    description = json['description'];
    purpose = json['purpose'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    downPayment = json['down_payment'];
    monthlyPayment = json['monthly_payment'];
    deposite = json['deposite'];
    numYears = json['num_years'];
    price = json['price'];
    paymentMethod = json['payment_method'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    areaId = json['area_id'];
    country = json['country'];
    city = json['city'];
    cityArea = json['city_area'];
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
    data['id'] = id;
    data['title'] = title;
    data['type'] = type;
    data['required_fields'] = requiredFields;
    data['view'] = view;
    data['description'] = description;
    data['purpose'] = purpose;
    data['company_name'] = companyName;
    data['company_logo'] = companyLogo;
    data['down_payment'] = downPayment;
    data['monthly_payment'] = monthlyPayment;
    data['deposite'] = deposite;
    data['num_years'] = numYears;
    data['price'] = price;
    data['payment_method'] = paymentMethod;
    data['country_id'] = countryId;
    data['city_id'] = cityId;
    data['area_id'] = areaId;
    data['country'] = country;
    data['city'] = city;
    data['city_area'] = cityArea;
    data['available'] = available;
    data['available_date'] = availableDate;
    data['lat'] = lat;
    data['long'] = long;
    data['video'] = video;
    data['rooms'] = rooms;
    data['bathroom'] = bathroom;
    data['floor'] = floor;
    data['year_build'] = yearBuild;
    data['area'] = area;
    data['bedrooms'] = bedrooms;
    data['finished_type'] = finishedType;
    data['metro'] = metro;
    data['train'] = train;
    data['bus'] = bus;
    data['pharmacy'] = pharmacy;
    data['beach'] = beach;
    data['bakary'] = bakary;
    data['resturant'] = resturant;
    data['coffe'] = coffe;
    data['air_condition'] = airCondition;
    data['cable_tv'] = cableTv;
    data['computer'] = computer;
    data['gas_line'] = gasLine;
    data['dishwasher'] = dishwasher;
    data['internet'] = internet;
    data['heater'] = heater;
    data['microwave'] = microwave;
    data['balcony'] = balcony;
    data['lift'] = lift;
    data['grill'] = grill;
    data['pool'] = pool;
    data['parking'] = parking;
    data['recption'] = recption;
    data['security'] = security;
    data['add_type'] = addType;
    data['company_id'] = companyId;
    data['status'] = status;
    data['images'] = images;
    data['watch_num'] = watchNum;
    data['lead_num'] = leadNum;
    data['opened_num'] = openedNum;
    data['auth_watch'] = authWatch;
    data['auth_open'] = authOpen;
    data['auth_lead'] = authLead;
    data['auth_Favourite'] = authFavourite;
    return data;
  }

  void toggleFavorite() {
    authFavourite = !authFavourite!;
  }
}
