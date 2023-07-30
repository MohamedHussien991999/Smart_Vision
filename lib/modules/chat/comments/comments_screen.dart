// ignore_for_file: must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm/model/post_model.dart';

import '../comment_item/comment_item.dart';
import '../cubit/community_cubit.dart';
import '../cubit/community_states.dart';

class CommentsScreen extends StatelessWidget {
  Post post;
  CommentsScreen({Key? key, required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityCubit(),
      child: BlocConsumer<CommunityCubit, CommunityStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CommunityCubit cubit = CommunityCubit.get(context);

          // Keep track of the comment text
          TextEditingController commentController = TextEditingController();

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.grey[300],
              title: const Text(
                'Comments',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20.0),
                    ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: post.comments.map((comment) {
                        return CommentItem(
                          comment: comment,
                          onLikePressed: () {
                            cubit.updateCommentLike(post, comment);
                          },
                          onDislikePressed: () {
                            cubit.updateCommentDisLike(post, comment);
                          },
                          onReplyPressed: () {
                            cubit.addComment(
                              post,
                              null,
                            ); // Add your reply handling logic here
                          },
                          onLikeReplyPressed: () {},
                          onDislikeReplyPressed: () {},
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: const InputDecoration(
                            hintText: 'Add a comment',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      IconButton(
                        onPressed: () {
                          String commentText = commentController.text;
                          if (commentText.isNotEmpty) {
                            cubit.addComment(post, commentText);
                            commentController.clear();
                          }
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
