import 'dart:convert';
import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppAPIs {
  List<Post> posts = [];

  Future<List<Post>> dataCall() async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        posts = jsonData.map((item) => Post.fromJson(item)).toList();
        return posts;
      } else {
        print('Failed to load posts');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

  Future<bool> deletePost(BuildContext context, int postId) async {
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId");
    try {
      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        // This method now receives the context and shows a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post deleted successfully')),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete post')),
        );
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      return false;
    }
  }

  Future<Post?> createPost(
      {required String title, required String body}) async {
    Map<String, dynamic> request = {'title': title, 'body': body};

    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    try {
      final response =
          await http.post(uri, body: json.encode(request), headers: {
        "Content-Type": "application/json",
      });
      print(response.body);
      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Post?> updatePost(int postId, String title, String body) async {
    Map<String, dynamic> request = {
      'title': title,
      'body': body,
    };
    final uri = Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId");
    try {
      final response =
          await http.put(uri, body: json.encode(request), headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update post');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
