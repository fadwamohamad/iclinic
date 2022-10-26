
class ResponseClinic2 {
  Clinic? clinic;
  ResponseClinic2({this.clinic});

  ResponseClinic2.fromJson(Map<String, dynamic> json) {
    clinic =
    json['clinic'] != null ? new Clinic.fromJson(json['clinic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clinic != null) {
      data['clinic'] = this.clinic!.toJson();
    }
    return data;
  }
}

class Clinic {
  String? name;
  String? doctorName;
  int? id;
  String? logoUrl;

  Clinic({this.name, this.doctorName, this.id, this.logoUrl});

  Clinic.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    doctorName = json['doctor_name'];
    id = json['id'];
    logoUrl = json['logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['doctor_name'] = this.doctorName;
    data['id'] = this.id;
    data['logo_url'] = this.logoUrl;
    return data;
  }
}