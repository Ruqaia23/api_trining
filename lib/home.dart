import 'dart:convert';
import 'package:api_trining/bottomsheet.dart';
import 'package:api_trining/modle.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api_trining/Apis/appapis.dart';

import 'widget/button_appber_post.widget.dart';
import 'widget/card_post.widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> posts = [];
  bool isLoading = false;
  AppAPIs appAPIs = AppAPIs();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("API"),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: appAPIs.dataCall(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  snapshot.data;
                  //  print(snapshot.data);

                  return Expanded(
                      child: Column(
                    children: [
                      ButtonAppberPost(
                        onAddPost: _addPost,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return CardPost(
                                post: snapshot.data![index],
                                onDeletePost: (posts) {},
                                onUpdatePost: (posts) {},
                              );
                            }),
                      )
                    ],
                  ));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ],
      ),
    );
  }

  void _addPost() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) =>
          AddOrUpdatePostWidget(onAccept: (post) async {
        await appAPIs.createPost(
          title: post.title ?? "not title",
          body: post.body ?? "not body",
        );
      }),
    );
  }

  void _getPosts() {
    setState(() {
      isLoading = true;
    });
    appAPIs.dataCall().then((posts) {
      this.posts = posts;
      isLoading = false;
      setState(() {});
    });
  }
}
