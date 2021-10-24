/// trainingType : ""

class PlatformVariables {
  PlatformVariables({
      String? trainingTypes,}){
    _trainingTypes = trainingTypes;
}

  PlatformVariables.fromJson(dynamic json) {
    _trainingTypes = json['trainingTypes'];
  }
  String? _trainingTypes;

  String? get trainingTypes => _trainingTypes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['trainingTypes'] = _trainingTypes;
    return map;
  }

}