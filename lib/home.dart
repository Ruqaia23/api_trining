import 'dart:convert';
import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: ListView(
        children: [
          Container(
            width: 500,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: MaterialButton(
              color: Color.fromARGB(255, 205, 135, 217),
              onPressed: () => dataCall(),
              child: Text("Request"),
            ),
          ),
          ...data
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
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Post> posts = jsonData.map((item) => Post.fromJson(item)).toList();
      setState(() {
        data = posts;
      });
    }
  }
}
