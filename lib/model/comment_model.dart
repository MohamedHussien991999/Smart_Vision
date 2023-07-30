class Comment {
  final String username;
  final String content;
  int likes;
  int dislikes;
  List<Comment>? replies;
  bool isLiked;
  bool isDislike;
  bool isLikedReply;
  bool isDislikedReply;
  int likesReply;
  int dislikesReply;

  Comment({
    required this.username,
    required this.content,
    required this.likes,
    required this.dislikes,
    this.replies,
    this.isLiked = false,
    this.isDislike = false,
    this.isLikedReply = false,
    this.isDislikedReply = false,
    this.likesReply = 0,
    this.dislikesReply = 0,
  });
}
