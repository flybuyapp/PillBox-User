import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/models/models.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flutter/material.dart';

class PostDate extends StatelessWidget with PostMixin {
  final Post? post;
  final Color? color;

  PostDate({Key? key, this.post, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(
        formatDate(
            date: post!.date!,
            dateFormat: 'dd/MM/yyyy',
            locate: getLocate(context)),
        style: theme.textTheme.bodySmall!.copyWith(color: color));
  }
}
