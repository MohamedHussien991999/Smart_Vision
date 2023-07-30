import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_farm/modules/chat/post_card/post_card.dart';

import 'comments/comments_screen.dart';
import 'cubit/community_cubit.dart';
import 'cubit/community_states.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CommunityCubit(),
      child: BlocConsumer<CommunityCubit, CommunityStates>(
        listener: (context, state) {},
        builder: (context, state) {
          CommunityCubit cubit = CommunityCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Posts'),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0),
              child: ListView.builder(
                itemCount: cubit.posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        PostCard(post: cubit.posts[index]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                                icon: Icon(cubit.posts[index].isLiked
                                    ? Icons.thumb_up
                                    : Icons.thumb_up_alt_outlined),
                                color: cubit.posts[index].isLiked
                                    ? Colors.blue
                                    : null,
                                onPressed: () {
                                  cubit.changeStateLike(cubit.posts[index]);
                                  print("ok");
                                }),
                            Text('${cubit.posts[index].likes} Like'),
                            IconButton(
                                icon: Icon(cubit.posts[index].isDisLike
                                    ? Icons.thumb_down
                                    : Icons.thumb_down_alt_outlined),
                                color: cubit.posts[index].isDisLike
                                    ? Colors.blue
                                    : null,
                                onPressed: () {
                                  cubit.changeStateDisLike(cubit.posts[index]);
                                  print("ok");
                                }),
                            Text('${cubit.posts[index].dislikes} Dislike'),
                            IconButton(
                                icon: const Icon(Icons.comment),
                                onPressed: () {
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                      enableDrag: true,
                                      context: context,
                                      builder: (context) {
                                        return CommentsScreen(
                                          post: cubit.posts[index],
                                        );
                                      });
                                }),
                            Text(
                                '${cubit.posts[index].comments.length} Comment'),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  } /**
  
  
             */
}
