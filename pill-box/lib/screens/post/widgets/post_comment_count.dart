import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flutter/material.dart';

class PostCommentCount extends StatelessWidget with PostMixin {
  final Post? post;
  final Color? color;

  PostCommentCount({Key? key, this.post, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return buildComment(theme, post!, color);
  }
}
