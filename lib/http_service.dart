import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';

class HttpService {
  final String postsURL = "http://127.0.0.1:8000/generic/api";

  Future<List<Post>> getPosts() async {
    Response res = await get(postsURL);
    print(res);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();
      print(posts);
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}