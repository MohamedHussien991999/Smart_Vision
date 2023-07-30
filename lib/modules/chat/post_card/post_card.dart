// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../../../model/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              color: Color(0xFFF2F2F2),
              child: Column(
                children: [
                  ListTile(
                    title: const Text(
                      '{user.FirstName} {user.LastName}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text('@${post.username}',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.blue)),
                    ),

                    // Adjust the vertical value as needed
                  ),
                ],
              ),
            ),
          ),
          ListTile(title: Text('${post.content}')),
        ],
      ),
    );
  }
}
