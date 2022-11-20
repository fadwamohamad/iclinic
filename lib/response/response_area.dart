class ResponseArea {
  List<Area>? area;

  ResponseArea({this.area});

  ResponseArea.fromJson(Map<String, dynamic> json) {
    if (json['area'] != null) {
      area = <Area>[];
      json['area'].forEach((v) {
        area!.add(Area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (area != null) {
      data['area'] = area!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Area {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Area({this.id, this.name, this.createdAt, this.updatedAt});

  Area.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
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