import 'dart:async';

import 'package:http/http.dart';

class WebAPI {
  final Client _client;

  WebAPI(this._client);

  Future<Response> getPosts() {
    return _client.get(Uri.https("jsonplaceholder.typicode.com", "posts"));
  }

  Future<Response> getPost(int postId) {
    return _client.get(Uri.https(
        "jsonplaceholder.typicode.com", "posts", {"id": postId.toString()}));
  }

  Future<Response> getComments(int postId) {
    return _client.get(Uri.https("jsonplaceholder.typicode.com", "comments",
        {"postId": postId.toString()}));
  }
}
