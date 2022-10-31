
import 'dart:convert';

class Clinics {
  int? id;
  String? name;
  String? doctorName;
  String? mobileNumber;
  String? telephoneNumber;
  String? email;
  String? whatsappNumber;
  String? address;
  String? clinicChairs;
  String? clinicTypeId;
  String? longitude;
  String? latitude;
  String? timeStart;
  String? timeEnd;
  List<String>? workdays;
  String? logoUrl;
  String? businessCardUrl;
  int? cityId;

  Clinics(
      {this.id,
        this.name,
        this.doctorName,
        this.mobileNumber,
        this.telephoneNumber,
        this.email,
        this.whatsappNumber,
        this.address,
        this.clinicChairs,
        this.clinicTypeId,
        this.longitude,
        this.latitude,
        this.timeStart,
        this.timeEnd,
        this.workdays,
        this.logoUrl,
        this.cityId,
        this.businessCardUrl});

  Clinics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    doctorName = json['doctor_name'];
    mobileNumber = json['mobile_number'];
    telephoneNumber = json['telephone_number'];
    email = json['email'];
    whatsappNumber = json['whatsapp_number'];
    address = json['address'];
    clinicChairs = json['clinic_chairs'];
    clinicTypeId = json['clinic_type_id'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    workdays = json['all_work_days'].cast<String>();
    //json["all_work_days"] == null ? null : List<String>.from(json["all_work_days"].map((x) => x));
    // workdays = json["all_work_days"] == null? [] : List<String>.from(json["all_work_days"].map((dynamic) => dynamic));
   //    json['all_work_days'].cast<String>();
   //  if (json['all_work_days'] != null) {
   //    workdays = <String>[];
   //    print(json["all_work_days"]);
   //   // workdays=List<String>.from(json["all_work_days"].map((x) => x));
   //
   //  }workdays = (json["all_work_days"] as List<String>).cast<String>();

   // workdays = json['all_work_days'];
    logoUrl = json['logo_url'];
    businessCardUrl = json['business_card_url'];
    cityId = json['city_id'];
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
    data['address'] = address;
    data['clinic_chairs'] = clinicChairs;
    data['clinic_type_id'] = clinicTypeId;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['time_start'] = timeStart;
    data['time_end'] = timeEnd;
    data['all_work_days'] =  workdays;
    data['all_work_days'] = workdays;
    data['logo_url'] = logoUrl;
    data['business_card_url'] = businessCardUrl;
    data['city_id'] = cityId;
    return data;
  }
}
