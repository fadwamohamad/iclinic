class ResponseCity {
  List<Cities>? cities;

  ResponseCity({this.cities});

  ResponseCity.fromJson(Map<String, dynamic> json) {
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(Cities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (cities != null) {
      data['cities'] = cities!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cities {
  int? id;
  String? name;
  int? areaId;
  String? createdAt;
  String? updatedAt;

  Cities({this.id, this.name, this.areaId, this.createdAt, this.updatedAt});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    areaId = json['area_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['area_id'] = areaId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return name ?? '';
  }
}