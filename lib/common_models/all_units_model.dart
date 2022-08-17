import 'package:osol/common_models/pagination/links.dart';
import 'package:osol/common_models/pagination/meta.dart';
import 'package:osol/common_models/unit_model.dart';

class AllUnitsModel {
  List<UnitModel> data = [];
  Links? links;
  Meta? meta;

  AllUnitsModel({required this.data, this.links, this.meta});

  AllUnitsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UnitModel>[];
      json['data'].forEach((v) {
        data.add(UnitModel.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}
