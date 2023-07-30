import 'package:flutter/material.dart';
import '../../../model/comment_model.dart';

class CommentItem extends StatelessWidget {
  final Comment comment;
  final VoidCallback onLikePressed;
  final VoidCallback onDislikePressed;
  final VoidCallback onReplyPressed;
  final VoidCallback onLikeReplyPressed;
  final VoidCallback onDislikeReplyPressed;

  CommentItem({
    super.key,
    required this.comment,
    required this.onLikePressed,
    required this.onDislikePressed,
    required this.onReplyPressed,
    required this.onLikeReplyPressed,
    required this.onDislikeReplyPressed,
  });
  final TextEditingController replyController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 20.0),
        child: ListBody(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    'mohamed hussien',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                const Spacer(),
                TextButton(onPressed: () {}, child: const Text("EDIT")),
                TextButton(onPressed: () {}, child: const Text("Delete")),
              ],
            ),
            Text('@${comment.username}'),
            ListTile(
              title: Text(comment.username),
            ),
            ListTile(
              title: Text(comment.content),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(comment.isLiked
                      ? Icons.thumb_up
                      : Icons.thumb_up_alt_outlined),
                  color: comment.isLiked ? Colors.blue : null,
                  onPressed: onLikePressed,
                ),
                Text('${comment.likes}'),
                const SizedBox(width: 16),
                IconButton(
                  icon: Icon(comment.isDislike
                      ? Icons.thumb_down
                      : Icons.thumb_down_alt_outlined),
                  color: comment.isDislike ? Colors.blue : null,
                  onPressed: onDislikePressed,
                ),
                Text('${comment.dislikes}'),
                IconButton(icon: const Icon(Icons.comment), onPressed: () {}),
                comment.replies?.length == null
                    ? const Text('0')
                    : Text('${comment.replies!.length}'),
              ],
            ),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                TextField(
                  controller: replyController,
                  decoration: const InputDecoration(
                    hintText: 'Add a reply',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    print("old value $value");
                  },
                ),
                // The IconButton placed at the center right of the Stack
                Positioned(
                  right: 8.0,
                  child: IconButton(
                    onPressed: () {
                      print("new value ${replyController.text}");
                    },
                    icon: const Icon(Icons.send),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (comment.replies != null && comment.replies!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  children: [
                    const Icon(Icons.arrow_drop_down_circle_rounded),
                    const Divider(),
                    ...comment.replies!.map(
                      (reply) => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListTile(
                            title: Text(reply.username),
                            subtitle: Text(reply.content),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(reply.isLikedReply
                                      ? Icons.thumb_up
                                      : Icons.thumb_up_alt_outlined),
                                  color:
                                      reply.isLikedReply ? Colors.blue : null,
                                  onPressed: onLikeReplyPressed,
                                ),
                                Text('${reply.likesReply}'),
                                const SizedBox(width: 16),
                                IconButton(
                                  icon: Icon(reply.isDislikedReply
                                      ? Icons.thumb_down
                                      : Icons.thumb_down_alt_outlined),
                                  color: reply.isDislikedReply
                                      ? Colors.blue
                                      : null,
                                  onPressed: onDislikeReplyPressed,
                                ),
                                Text('${reply.dislikesReply}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
