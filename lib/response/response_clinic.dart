import 'dart:convert';

import 'package:iclinic/response/response_area.dart';
import 'package:iclinic/response/response_clinic_type.dart';



class City {
  int? id;
  String? name;
  int? areaId;
  String? createdAt;
  String? updatedAt;
  Area? area;

  City(
      {this.id,
      this.name,
      this.areaId,
      this.createdAt,
      this.updatedAt,
      this.area});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaId = json['area_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    area = json['area'] != null ? Area.fromJson(json['area']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['area_id'] = areaId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (area != null) {
      data['area'] = area!.toJson();
    }
    return data;
  }
}
