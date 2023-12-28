import 'package:flutter/material.dart';
import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/screens/screens.dart';
import 'package:flybuy/widgets/widgets.dart';

class PostAuthor extends StatelessWidget with PostMixin {
  final Post? post;
  final Color? color;

  PostAuthor({super.key, this.post, this.color});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: () => Navigator.pushNamed(context, PostAuthorScreen.routeName,
          arguments: {'id': post!.author}),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FlybuyCacheImage(
              post?.postAuthorImage?.medium ?? '',
              width: 32,
              height: 32,
            ),
          ),
          const SizedBox(width: 8),
          Text(post!.postAuthor!,
              style: theme.textTheme.bodySmall?.copyWith(color: color)),
        ],
      ),
    );
  }
}
