import 'dart:convert';
import 'package:http/http.dart';
import 'post_model.dart';

class HttpService {
  final String postsURL = "http://127.0.0.1:8000/generic/api";

  Future<List<Post>> getPosts() async {
    Response res = await get(postsURL);
    // print(res);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Post> posts = body
          .map(
            (dynamic item) => Post.fromJson(item),
          )
          .toList();
      // print(posts);
      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}

Future<Post> createPost(String name, String age) async {
  final response = await post(
    Uri.parse('http://127.0.0.1:8000/generic/api/'),
    body: {'test_char': name, 'test_num': age},
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Post.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create post.');
  }
}
