

class Visits {
  int? id;
  String? name;
  String? doctorName;
  String? mobileNumber;
  String? telephoneNumber;
  String? email;
  String? whatsappNumber;
  String? location;
  String? clinicType;
  String? clinicChairs;
  int? visitsCount;
  String? logoUrl;

  Visits(
      {this.id,
        this.name,
        this.doctorName,
        this.mobileNumber,
        this.telephoneNumber,
        this.email,
        this.whatsappNumber,
        this.location,
        this.clinicType,
        this.clinicChairs,
        this.visitsCount,
        this.logoUrl});

  Visits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    doctorName = json['doctor_name'];
    mobileNumber = json['mobile_number'];
    telephoneNumber = json['telephone_number'];
    email = json['email'];
    whatsappNumber = json['whatsapp_number'];
    location = json['location'];
    clinicType = json['clinic_type'];
    clinicChairs = json['clinic_chairs'];
    visitsCount = json['visits_count'];
    logoUrl = json['logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['doctor_name'] = this.doctorName;
    data['mobile_number'] = this.mobileNumber;
    data['telephone_number'] = this.telephoneNumber;
    data['email'] = this.email;
    data['whatsapp_number'] = this.whatsappNumber;
    data['location'] = this.location;
    data['clinic_type'] = this.clinicType;
    data['clinic_chairs'] = this.clinicChairs;
    data['visits_count'] = this.visitsCount;
    data['logo_url'] = this.logoUrl;
    return data;
  }
}
