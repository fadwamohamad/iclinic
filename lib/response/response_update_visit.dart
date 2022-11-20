import 'package:iclinic/response/response_clinic_visits.dart';

class UpdateVisitReportResponse {
  ClinicVisits? visit;
  VisitDetail? visitDetail;

  UpdateVisitReportResponse({this.visit, this.visitDetail});

  UpdateVisitReportResponse.fromJson(Map<String, dynamic> json) {
    visit = json['visit'] != null ? ClinicVisits.fromJson(json['visit']) : null;
    visitDetail = json['visit_detail'] != null
        ? VisitDetail.fromJson(json['visit_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (visit != null) {
      data['visit'] = visit!.toJson();
    }
    if (visitDetail != null) {
      data['visit_detail'] = visitDetail!.toJson();
    }
    return data;
  }
}
