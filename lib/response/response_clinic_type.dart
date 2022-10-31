class ResponseClinicsType {
  List<ClinicsType>? clinicsType;

  ResponseClinicsType({this.clinicsType});

  ResponseClinicsType.fromJson(Map<String, dynamic> json) {
    if (json['clinics_Type'] != null) {
      clinicsType = <ClinicsType>[];
      json['clinics_Type'].forEach((v) {
        clinicsType!.add(ClinicsType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (clinicsType != null) {
      data['clinics_Type'] = clinicsType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClinicsType {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  ClinicsType({this.id, this.name, this.createdAt, this.updatedAt});

  ClinicsType.fromJson(Map<String, dynamic> json) {
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