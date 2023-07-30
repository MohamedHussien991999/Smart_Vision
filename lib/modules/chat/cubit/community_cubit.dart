import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../model/comment_model.dart';
import '../../../model/post_model.dart';
import 'community_states.dart';

class CommunityCubit extends Cubit<CommunityStates> {
  CommunityCubit() : super(CommunityInitialState());

  static CommunityCubit get(context) => BlocProvider.of(context);
  List<Post> posts = [
    Post(
      username: 'John Doe',
      content: 'This is my first post!',
      likes: 10,
      dislikes: 0,
      isDisLike: false,
      isLiked: false,
      comments: [
        Comment(
          username: 'Jane Smith',
          content: 'Nice post!',
          likes: 5,
          dislikes: 0,
        ),
        Comment(
          username: 'Michael Johnson',
          content: 'I like it!',
          likes: 7,
          dislikes: 2,
          replies: [
            Comment(
              username: 'John Doe',
              content: 'Thanks!',
              likes: 3,
              dislikes: 0,
            ),
          ],
        ),
      ],
    ),
    Post(
      username: 'John Doe',
      content: 'This is my first post!',
      likes: 10,
      dislikes: 0,
      isDisLike: false,
      isLiked: false,
      comments: [
        Comment(
          username: 'Jane Smith',
          content: 'Nice post!',
          likes: 5,
          dislikes: 0,
        ),
        Comment(
          username: 'Michael Johnson',
          content: 'I like it!',
          likes: 7,
          dislikes: 2,
          replies: [
            Comment(
              username: 'John Doe',
              content: 'Thanks!',
              likes: 3,
              dislikes: 0,
            ),
          ],
        ),
      ],
    ),
    Post(
      username: 'John Doe',
      content: 'This is my first post!',
      likes: 10,
      dislikes: 0,
      isDisLike: false,
      isLiked: false,
      comments: [
        Comment(
          username: 'Jane Smith',
          content: 'Nice post!',
          likes: 5,
          dislikes: 0,
        ),
        Comment(
          username: 'Michael Johnson',
          content: 'I like it!',
          likes: 7,
          dislikes: 2,
          replies: [
            Comment(
              username: 'John Doe',
              content: 'Thanks!',
              likes: 3,
              dislikes: 0,
            ),
          ],
        ),
      ],
    ),
    Post(
      username: 'John Doe',
      content: 'This is my first post!',
      likes: 10,
      dislikes: 0,
      isDisLike: false,
      isLiked: false,
      comments: [
        Comment(
          username: 'Jane Smith',
          content: 'Nice post!',
          likes: 5,
          dislikes: 0,
        ),
        Comment(
          username: 'Michael Johnson',
          content: 'I like it!',
          likes: 7,
          dislikes: 2,
          replies: [
            Comment(
              username: 'John Doe',
              content: 'Thanks!',
              likes: 3,
              dislikes: 0,
            ),
          ],
        ),
      ],
    ),
    Post(
      username: 'John Doe',
      content: 'This is my first post!',
      likes: 10,
      dislikes: 0,
      isDisLike: false,
      isLiked: false,
      comments: [
        Comment(
          username: 'Jane Smith',
          content: 'Nice post!',
          likes: 5,
          dislikes: 0,
        ),
        Comment(
          username: 'Michael Johnson',
          content: 'I like it!',
          likes: 7,
          dislikes: 2,
          replies: [
            Comment(
              username: 'John Doe',
              content: 'Thanks!',
              likes: 3,
              dislikes: 0,
            ),
          ],
        ),
      ],
    ),
    Post(
      username: 'John Doe',
      content: 'This is my first post!',
      likes: 10,
      dislikes: 0,
      isDisLike: false,
      isLiked: false,
      comments: [
        Comment(
          username: 'Jane Smith',
          content: 'Nice post!',
          likes: 5,
          dislikes: 0,
        ),
        Comment(
          username: 'Michael Johnson',
          content: 'I like it!',
          likes: 7,
          dislikes: 2,
          replies: [
            Comment(
              username: 'John Doe',
              content: 'Thanks!',
              likes: 3,
              dislikes: 0,
            ),
          ],
        ),
      ],
    ),
    Post(
      username: 'John Doe',
      content: 'This is my first post!',
      likes: 10,
      dislikes: 0,
      isDisLike: false,
      isLiked: false,
      comments: [
        Comment(
          username: 'Jane Smith',
          content: 'Nice post!',
          likes: 5,
          dislikes: 0,
        ),
        Comment(
          username: 'Michael Johnson',
          content: 'I like it!',
          likes: 7,
          dislikes: 2,
          replies: [
            Comment(
              username: 'John Doe',
              content: 'Thanks!',
              likes: 3,
              dislikes: 0,
            ),
          ],
        ),
      ],
    ),
    Post(
      username: 'John Doe',
      content: 'This is my first post!',
      likes: 10,
      dislikes: 0,
      isDisLike: false,
      isLiked: false,
      comments: [
        Comment(
          username: 'Jane Smith',
          content: 'Nice post!',
          likes: 5,
          dislikes: 0,
        ),
        Comment(
          username: 'Michael Johnson',
          content: 'I like it!',
          likes: 7,
          dislikes: 2,
          replies: [
            Comment(
              username: 'John Doe',
              content: 'Thanks!',
              likes: 3,
              dislikes: 0,
            ),
          ],
        ),
      ],
    ),
    // Add more posts here
  ];

  void changeStateLike(Post postLikesChange) {
    if (postLikesChange.isLiked) {
      postLikesChange.likes--;
    } else {
      postLikesChange.likes++;
      if (postLikesChange.isDisLike == true) {
        postLikesChange.isDisLike = false;
        postLikesChange.dislikes != 0 ? postLikesChange.dislikes-- : null;
      }
    }
    postLikesChange.isLiked = !postLikesChange.isLiked;
    emit(CommunityChangeState());
  }

  void changeStateDisLike(Post postLikesChange) {
    if (postLikesChange.isDisLike) {
      postLikesChange.dislikes--;
    } else {
      postLikesChange.dislikes++;
      if (postLikesChange.isLiked == true) {
        postLikesChange.isLiked = false;
        postLikesChange.likes != 0 ? postLikesChange.likes-- : null;
      }
    }
    postLikesChange.isDisLike = !postLikesChange.isDisLike;
    emit(CommunityChangeState());
  }

  void addComment(Post post, String? comment) {
    if (comment != null && comment.isNotEmpty) {
      post.comments.add(
        Comment(
          username: 'User', // Replace this with the actual username
          content: comment,
          likes: 0,
          isDislike: false,
          isLiked: false,
          dislikes: 0,
        ),
      );
    }
  }

  void updateCommentLike(Post post, Comment comment) {
    emit(CommunityLoadingState());

    if (comment.isLiked) {
      comment.likes--;
    } else {
      comment.likes++;
      if (comment.isDislike == true) {
        comment.isDislike = false;
        comment.dislikes != 0 ? comment.dislikes-- : null;
      }
    }
    comment.isLiked = !comment.isLiked;
    emit(CommunityChangeState());
    // You can put your logic here to update the like/dislike status of the comment.
    // For example:

    // After updating the like/dislike status, emit a new state to trigger a rebuild.
    emit(CommunityChangeState());
  }

  void updateCommentDisLike(Post post, Comment comment) {
    emit(CommunityLoadingState());

    if (comment.isDislike) {
      comment.dislikes--;
    } else {
      comment.dislikes++;
      if (comment.isLiked == true) {
        comment.isLiked = false;
        comment.likes != 0 ? comment.likes-- : null;
      }
    }
    comment.isDislike = !comment.isDislike;
    emit(CommunityChangeState());
    // You can put your logic here to update the like/dislike status of the comment.
    // For example:

    // After updating the like/dislike status, emit a new state to trigger a rebuild.
    emit(CommunityChangeState());
  }
}
