class ResponseArea {
  List<Area>? area;

  ResponseArea({this.area});

  ResponseArea.fromJson(Map<String, dynamic> json) {
    if (json['area'] != null) {
      area = <Area>[];
      json['area'].forEach((v) {
        area!.add(new Area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.area != null) {
      data['area'] = this.area!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
  @override
  String toString() {
    // TODO: implement toString
    return name ?? '';
  }
}