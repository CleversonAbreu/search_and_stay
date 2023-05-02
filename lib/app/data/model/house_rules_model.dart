class HouseRulesModel {

  int? id;
  String name;
  int active;
  int order;

  HouseRulesModel({
    required this.id,
    required this.name,
    required this.active,
    required this.order,
  });

  factory HouseRulesModel.fromJson(Map<String, dynamic> json) {
    return HouseRulesModel(
      id: json['id'] ?? 0,
      name: json['name'],
      active: json['active'] ?? 0,
      order: json['order'] ?? 0,
    );
  }

  static HouseRulesModel fromMap(Map<String,dynamic> map){
    return HouseRulesModel(
      id:map['id'],
      name:map['name'],
      active:map['active'],
      order:map['order'],
    );
  }

  Map toMap(){
    Map<String,dynamic> map = {
      'id':id,
      'name': name,
      'active': active,
      'order': order,
    };
    return map;
  }
}
