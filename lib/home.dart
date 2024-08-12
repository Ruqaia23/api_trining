import 'dart:convert';
import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Color.fromARGB(255, 205, 135, 217),
                  onPressed: () => dataCall(),
                  child: Text("Get"),
                ),
                SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  color: Color.fromARGB(255, 205, 135, 217),
                  onPressed: () => createPoat('title', 'body'),
                  child: Text("Post"),
                ),
                SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  color: Color.fromARGB(255, 205, 135, 217),
                  onPressed: () => deletePost(),
                  child: Text("Delete"),
                ),
              ],
            ),
          ),
          ...posts
              .map((item) => Card(
                    child: ListTile(
                      title: Text("${item.title}"),
                      subtitle: Text("${item.body}"),
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Future<void> dataCall() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      print('successfully ${response.body}');
      setState(() {
        List<dynamic> jsonData = jsonDecode(response.body);
        posts = jsonData.map((item) => Post.fromJson(item)).toList();
      });
    }
  }

  Future<Post> createPoat(String title, String body) async {
    Map<String, dynamic> request = {
      'title': title,
      'body': body,
      'userId': '111'
    };
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await http.post(uri, body: request);
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed');
    }
  }

  Future<void> deletePost() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    final response = await http.delete(uri);
    if (response.statusCode != 200) {
      throw Exception('Failed');
    }
  }
}
