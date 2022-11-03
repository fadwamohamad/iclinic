class Satisfaction{
  String? id;
  String? name;
  Satisfaction({this.id, this.name});
  @override
  String toString() {
    // TODO: implement toString
    return name ?? '';
  }
}

class VisitType{
  String? id;
  String? name;


  VisitType({this.id, this.name});

  @override
  String toString() {
    // TODO: implement toString
    return name ?? '';
  }
}