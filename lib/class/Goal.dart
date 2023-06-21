class Goal{
  late int id;
  late String targetHead;
  late String targetDestination;
  late int targetDestinationCityId;
  late String targetDescription;
  late String targetDate;

  Goal({required this.targetDestination, required this.targetDestinationCityId, required this.targetDescription, required this.targetHead, required this.targetDate});

  Map<String, dynamic> toMap(){ // veri eklemek için.
    var map = Map<String, dynamic>();
    map["targetHead"] = targetHead;
    map["targetDestination"] = targetDestination;
    map["targetDestinationCityId"] = targetDestinationCityId;
    map["targetDescription"] = targetDescription;
    map["targetDate"] = targetDate;
    return map;
  }

  Goal.fromMap(Map<String, dynamic> map){
    id = map['id'];
    targetHead = map["targetHead"];
    targetDestination = map["targetDestination"];
    targetDestinationCityId = map["targetDestinationCityId"];
    targetDescription = map["targetDescription"];
    targetDate = map["targetDate"];
  }
}