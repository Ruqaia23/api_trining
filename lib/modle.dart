class Post {
  int? id;
  int? userId;
  String? title;
  String? body;

  Post({this.id, this.userId, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson(item) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id.toString();
    data['userId'] = this.userId.toString();
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
