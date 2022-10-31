
class ResponseVisit {
  Visit? visit;

  ResponseVisit({this.visit});

  ResponseVisit.fromJson(Map<String, dynamic> json) {
    visit = json['visit'] != null ? new Visit.fromJson(json['visit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.visit != null) {
      data['visit'] = this.visit!.toJson();
    }
    return data;
  }
}

class Visit {
  int? visitNumber;
  String? visitDate;
  String? beginVisit;
  String? endVisit;
  int? clinicId;
  int? userId;

  Visit(
      {this.visitNumber,
        this.visitDate,
        this.beginVisit,
        this.endVisit,
        this.clinicId,
        this.userId});

  Visit.fromJson(Map<String, dynamic> json) {
    visitNumber = json['visit_number'];
    visitDate = json['visit_date'];
    beginVisit = json['begin_visit'];
    endVisit = json['end_visit'];
    clinicId = json['clinic_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['visit_number'] = this.visitNumber;
    data['visit_date'] = this.visitDate;
    data['begin_visit'] = this.beginVisit;
    data['end_visit'] = this.endVisit;
    data['clinic_id'] = this.clinicId;
    data['user_id'] = this.userId;
    return data;
  }
}