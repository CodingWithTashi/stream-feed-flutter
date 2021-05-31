import 'package:flutter/material.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:stream_feed_flutter/src/comment_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stream_feed_flutter/stream_feed_flutter.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  testWidgets('CommentItem', (tester) async {
    await mockNetworkImages(() async {
      var pressedHashtags = <String?>[];
      var pressedMentions = <String?>[];

      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: CommentItem(
          user: User(data: {
            'name': 'Rosemary',
            'subtitle': 'likes playing fresbee in the park',
            'profile_image': 'https://randomuser.me/api/portraits/women/20.jpg',
          }),
          reaction: Reaction(
            createdAt: DateTime.now(),
            kind: 'comment',
            data: {
              'text': 'Snowboarding is awesome! #snowboarding #winter @sacha',
            },
          ),
          onMentionTap: (String? mention) {
            pressedMentions.add(mention);
          },
          onHashtagTap: (String? hashtag) {
            pressedHashtags.add(hashtag);
          },
        ),
      )));

      final avatar = find.byType(Avatar);

      expect(avatar, findsOneWidget);
      final richtexts = tester.widgetList<Text>(find.byType(Text));

      expect(richtexts.toList().map((e) => e.data), [
        'Rosemary',
        'a moment ago',
        'Snowboarding ',
        'is ',
        'awesome! ',
        ' #snowboarding',
        ' #winter',
        ' @sacha',
      ]);
      expect(richtexts.toList().map((e) => e.style), [
        TextStyle(
            inherit: true,
            color: Color(0xff0ba8e0),
            fontSize: 14.0,
            fontWeight: FontWeight.w700),
        TextStyle(
            inherit: true,
            color: Color(0xff7a8287),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            height: 1.5),
        TextStyle(
            inherit: true,
            color: Color(0xff095482),
            fontSize: 14.0,
            fontWeight: FontWeight.w600),
        TextStyle(
            inherit: true,
            color: Color(0xff095482),
            fontSize: 14.0,
            fontWeight: FontWeight.w600),
        TextStyle(
            inherit: true,
            color: Color(0xff095482),
            fontSize: 14.0,
            fontWeight: FontWeight.w600),
        TextStyle(
            inherit: true,
            color: Color(0xff7a8287),
            fontSize: 14.0,
            fontWeight: FontWeight.w600),
        TextStyle(
            inherit: true,
            color: Color(0xff7a8287),
            fontSize: 14.0,
            fontWeight: FontWeight.w600),
        TextStyle(
            inherit: true,
            color: Color(0xff095482),
            fontSize: 14.0,
            fontWeight: FontWeight.w600)
      ]);

      await tester.tap(find.widgetWithText(InkWell, ' #winter'));
      await tester.tap(find.widgetWithText(InkWell, ' @sacha'));
      expect(pressedHashtags, ['winter']);
      expect(pressedMentions, ['sacha']);
    });
  });
}