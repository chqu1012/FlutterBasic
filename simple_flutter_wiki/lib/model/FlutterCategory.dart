class FlutterCategory {
  int id;
  String name;
  String created;
  String updated;

  FlutterCategory({this.id, this.name, this.created, this.updated});

  FlutterCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
