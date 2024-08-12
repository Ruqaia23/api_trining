class Post {
  int? userId;
  String? title;
  String? body;

  Post({this.userId, this.title, this.body});

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson(item) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}
