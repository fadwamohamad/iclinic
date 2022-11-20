import 'package:iclinic/response/response_clinic_type.dart';

class Visits {
  int? id;
  String? name;
  String? doctorName;
  String? mobileNumber;
  String? telephoneNumber;
  String? email;
  String? whatsappNumber;
  String? location;
  ClinicsType? clinicType;
  String? clinicChairs;
  int? visitsCount;
  String? logoUrl;
  //ClinicVisits? clinicVisits;


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
        this.logoUrl,
       // this.clinicVisits
      });

  Visits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    doctorName = json['doctor_name'];
    mobileNumber = json['mobile_number'];
    telephoneNumber = json['telephone_number'];
    email = json['email'];
    whatsappNumber = json['whatsapp_number'];
    location = json['location'];
    clinicType = json['clinic_type'] != null ?ClinicsType.fromJson(json['clinic_type']):null;
    clinicChairs = json['clinic_chairs'];
    visitsCount = json['visits_count'];
    logoUrl = json['logo_url'];
    //clinicVisits = json['visits'] != null ?ClinicVisits.fromJson(json['visits']):null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['doctor_name'] = doctorName;
    data['mobile_number'] = mobileNumber;
    data['telephone_number'] = telephoneNumber;
    data['email'] = email;
    data['whatsapp_number'] = whatsappNumber;
    data['location'] = location;
    if(clinicType != null){
      data['clinic_type'] = clinicType!.toJson();
    }
    data['clinic_chairs'] = clinicChairs;
    data['visits_count'] = visitsCount;
    data['logo_url'] = logoUrl;
    return data;
  }
}
