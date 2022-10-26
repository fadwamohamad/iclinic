
class Clinics {
  int? id;
  String? name;
  String? doctorName;
  String? mobileNumber;
  String? telephoneNumber;
  String? email;
  String? logo;
  String? whatsappNumber;
  String? location;
  String? clinicType;
  String? clinicChairs;

  Clinics(
      {this.id,
        this.name,
        this.doctorName,
        this.mobileNumber,
        this.telephoneNumber,
        this.email,
        this.logo,
        this.whatsappNumber,
        this.location,
        this.clinicType,
        this.clinicChairs});

  Clinics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    doctorName = json['doctor_name'];
    mobileNumber = json['mobile_number'];
    telephoneNumber = json['telephone_number'];
    email = json['email'];
    logo = json['logo'];
    whatsappNumber = json['whatsapp_number'];
    location = json['location'];
    clinicType = json['clinic_type'];
    clinicChairs = json['clinic_chairs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['doctor_name'] = doctorName;
    data['mobile_number'] = this.mobileNumber;
    data['telephone_number'] = this.telephoneNumber;
    data['email'] = this.email;
    data['logo'] = this.logo;
    data['whatsapp_number'] = this.whatsappNumber;
    data['location'] = this.location;
    data['clinic_type'] = this.clinicType;
    data['clinic_chairs'] = this.clinicChairs;
    return data;
  }
}
