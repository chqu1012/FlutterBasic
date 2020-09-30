class FlutterPage {
  String title;
  String content;
  String created;
  String updated;

  FlutterPage({this.title, this.content, this.created, this.updated});
/**
  FlutterPage.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    created = json['created'];
    updated = json['updated'];
  }
 */
  factory FlutterPage.fromJson(Map<String, dynamic> json) {
    return FlutterPage(
      title: json['title'],
      content: json['content'],
      created: json['created'],
      updated: json['updated'],
    );
  }
/**
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
  */
}
