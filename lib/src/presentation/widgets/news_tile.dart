import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String title;
  final String content;
  final bool isLiked;
  final VoidCallback onLikePressed;

  const NewsTile({
    super.key,
    required this.title,
    required this.content,
    required this.isLiked,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(title),
        subtitle: Text(content),
        trailing: IconButton(
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            color: isLiked ? Colors.red : null,
          ),
          onPressed: onLikePressed,
        ),
      ),
    );
  }
}