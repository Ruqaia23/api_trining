import 'dart:convert';
import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppAPIs {
  String dataURL = "https://jsonplaceholder.typicode.com/posts";
  List<Post> posts = [];

  Future<List<Post>> dataCall() async {
    final uri = Uri.parse('$dataURL');
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
    final uri = Uri.parse('$dataURL/$postId');
    try {
      final response = await http.delete(uri);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Post deleted successfully')),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to delete post. Status code: ${response.statusCode}')),
        );
        return false;
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      return false;
    }
  }

  Future<Post?> createPost(
      {required String title, required String body}) async {
    Map<String, dynamic> request = {'title': title, 'body': body};

    final uri = Uri.parse('$dataURL');
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

  Future<Post?> updatePost({
    required int postId,
    required String title,
    required String body,
  }) async {
    Map<String, dynamic> request = {
      "id": postId,
      'title': title,
      'body': body,
    };
    final uri = Uri.parse('$dataURL/$postId');
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
