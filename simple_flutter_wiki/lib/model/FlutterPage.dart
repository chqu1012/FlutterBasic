class FlutterPage {
  int id;
  int categoryId;
  String title;
  String content;
  String created;
  String updated;

  FlutterPage(
      {this.id,
      this.categoryId,
      this.title,
      this.content,
      this.created,
      this.updated});

  FlutterPage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    title = json['title'];
    content = json['content'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
