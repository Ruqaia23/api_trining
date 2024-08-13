import 'dart:convert';
import 'package:api_trining/bottomsheet.dart';
import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: ListView(
        children: [
          buildButton(context),
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

  Padding buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(children: [
            isLoading
                ? CircularProgressIndicator(
                    color: Colors.blue,
                  )
                : MaterialButton(
                    color: Color.fromARGB(255, 205, 135, 217),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      dataCall().then((_) {
                        setState(() {
                          isLoading = false;
                        });
                      });
                    },
                    child: Text("Get"),
                  ),
          ]),
          SizedBox(
            width: 20,
          ),
          MaterialButton(
            color: Color.fromARGB(255, 205, 135, 217),
            onPressed: () => showAddEditBottomSheet(context),
            child: Text("Post"),
          ),
          SizedBox(
            width: 20,
          ),
          MaterialButton(
            color: Color.fromARGB(255, 205, 135, 217),
            onPressed: () {
              if (posts.isNotEmpty) {
                // deletePost(posts.last.);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('No posts to delete')),
                );
              }
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }

  Widget buildPostCard(Post item) {
    return Card(
      child: ListTile(
        title: Text("${item.title}"),
        subtitle: Text("${item.body}"),
        trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {}
            // => deletePost(Post.id),
            ),
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
    } else {
      print('Failed');
      setState(() {});
    }
  }

  Future<void> deletePost(int postId) async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId");
    final response = await http.delete(uri);

    if (response.statusCode == 200) {
      setState(() {
        posts.removeWhere((post) => post.id == postId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Post deleted successfully')),
      );
    }
  }
}
