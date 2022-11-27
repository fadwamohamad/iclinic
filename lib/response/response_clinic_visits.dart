

import 'package:iclinic/response/response_add_clinic.dart';

class DataClinicVisits {
  Clinic? clinic;
  List<ClinicVisits>? visits;

  DataClinicVisits({this.visits});

  DataClinicVisits.fromJson(Map<String, dynamic> json) {
    if (json['visits'] != null) {
      visits = <ClinicVisits>[];
      json['visits'].forEach((v) {
        visits!.add(ClinicVisits.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (visits != null) {
      data['visits'] = visits!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataClinicVisit {
  ClinicVisits? visit;

  DataClinicVisit({this.visit});

  DataClinicVisit.fromJson(Map<String, dynamic> json) {
    if (json['visit'] != null) {
      visit=ClinicVisits.fromJson(json['visit']);

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (visit != null) {
      data['visit'] = visit?.toJson();
    }
    return data;
  }
}

class ClinicVisits {
  int? id;
  int? visitNumber;
  String? visitDate;
  String? beginVisit;
  String? endVisit;
  int? userId;
  int? clinicId;
  String? createdAt;
  String? updatedAt;
  VisitDetail? visitDetail;

  ClinicVisits(
      {this.id,
        this.visitNumber,
        this.visitDate,
        this.beginVisit,
        this.endVisit,
        this.userId,
        this.clinicId,
        this.createdAt,
        this.updatedAt,
        this.visitDetail});

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
    visitDetail = json['visit_detail'] != null
        ? VisitDetail.fromJson(json['visit_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['visit_number'] = visitNumber;
    data['visit_date'] = visitDate;
    data['begin_visit'] = beginVisit;
    data['end_visit'] = endVisit;
    data['user_id'] = userId;
    data['clinic_id'] = clinicId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (visitDetail != null) {
      data['visit_detail'] = visitDetail!.toJson();
    }
    return data;
  }
}

class VisitDetail {
  int? id;
  String? visitReport;
  String? customerSatisfaction;
  String? visitType;
  int? checkAnotherApp;
  String? anotherApp;
  int? visitId;
  String? customerRecommendations;
  String? createdAt;
  String? updatedAt;

  VisitDetail(
      {this.id,
        this.visitReport,
        this.customerSatisfaction,
        this.visitType,
        this.checkAnotherApp,
        this.anotherApp,
        this.visitId,
        this.customerRecommendations,
        this.createdAt,
        this.updatedAt});

  VisitDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitReport = json['visit_report'];
    customerSatisfaction = json['customer_satisfaction'];
    visitType = json['visit_type'];
    checkAnotherApp = json['check_another_app'];
    anotherApp = json['another_app'];
    visitId = json['visit_id'];
    customerRecommendations = json['customer_recommendations'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['visit_report'] = visitReport;
    data['customer_satisfaction'] = customerSatisfaction;
    data['visit_type'] = visitType;
    data['check_another_app'] = checkAnotherApp;
    data['another_app'] = anotherApp;
    data['visit_id'] = visitId;
    data['customer_recommendations'] = this.customerRecommendations;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}