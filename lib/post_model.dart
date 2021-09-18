class Post {
  final int id;
  final String test_char;
  final int test_num;

  Post({
    required this.id,
    required this.test_char,
    required this.test_num,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      test_char: json['test_char'] as String,
      test_num: json['test_num'] as int,
    );
  }
}
