import 'comment_model.dart';

class Post {
  final String username;
  final String content;
  int likes;
  bool isLiked;
  int dislikes;
  bool isDisLike;
  final List<Comment> comments;

  Post(
      {required this.username,
      required this.content,
      required this.likes,
      required this.comments,
      required this.isLiked,
      required this.dislikes,
      required this.isDisLike});
}
