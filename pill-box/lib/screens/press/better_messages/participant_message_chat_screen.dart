import 'package:flybuy/mixins/mixins.dart';
import 'package:flybuy/screens/screens.dart';
import 'package:flybuy/types/types.dart';
import 'package:flybuy/utils/utils.dart';
import 'package:flybuy/widgets/flybuy_tile.dart';
import 'package:flutter/material.dart';

class BMParticipantMessageChatScreen extends StatelessWidget with AppBarMixin {
  final List<BMUser> participants;

  const BMParticipantMessageChatScreen({
    super.key,
    this.participants = const [],
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TranslateType translate = AppLocalizations.of(context)!.translate;

    return Scaffold(
      appBar: baseStyleAppBar(context, title: translate("bm_participants")),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  BMUser user = participants[index];
                  return FlybuyTile(
                    title: Text(user.name ?? "",
                        style: theme.textTheme.titleSmall),
                    onTap: () => Navigator.pushNamed(
                        context, BPMemberDetailScreen.routeName,
                        arguments: {"id": user.userId}),
                  );
                },
                childCount: participants.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
