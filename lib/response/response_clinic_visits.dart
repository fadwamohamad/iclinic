

import 'package:iclinic/response/response_add_clinic.dart';

class DataClinicVisits {
  Clinic? clinic;
  List<ClinicVisits>? visits;

  DataClinicVisits({this.visits});

  DataClinicVisits.fromJson(Map<String, dynamic> json) {
    if (json['visits'] != null) {
      visits = <ClinicVisits>[];
      json['visits'].forEach((v) {
        visits!.add(new ClinicVisits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.visits != null) {
      data['visits'] = this.visits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ClinicVisits {
  int? id;
  String? visitNumber;
  String? visitDate;
  String? beginVisit;
  String? endVisit;
  int? userId;
  int? clinicId;
  String? createdAt;
  String? updatedAt;

  ClinicVisits(
      {this.id,
        this.visitNumber,
        this.visitDate,
        this.beginVisit,
        this.endVisit,
        this.userId,
        this.clinicId,
        this.createdAt,
        this.updatedAt});

  ClinicVisits.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitNumber = json['visit_number'];
    visitDate = json['visit_date'];
    beginVisit = json['begin_visit'];
    endVisit = json['end_visit'];
    userId = json['user_id'];
    clinicId = json['clinic_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['visit_number'] = this.visitNumber;
    data['visit_date'] = this.visitDate;
    data['begin_visit'] = this.beginVisit;
    data['end_visit'] = this.endVisit;
    data['user_id'] = this.userId;
    data['clinic_id'] = this.clinicId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}