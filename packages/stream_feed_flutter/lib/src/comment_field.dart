import 'package:flutter/material.dart';
import 'package:stream_feed_flutter/src/textarea.dart';
import 'package:stream_feed_flutter/stream_feed_flutter.dart';
import 'package:stream_feed_flutter_core/stream_feed_flutter_core.dart';

class CommentField extends StatefulWidget {
  final EnrichedActivity activity;
  final List<FeedId>? targetFeeds;

  CommentField({required this.activity, this.targetFeeds});

  @override
  _CommentFieldState createState() => _CommentFieldState();
}

class _CommentFieldState extends State<CommentField> {
  late String text;

  @override
  Widget build(BuildContext context) {
    final streamFeed = StreamFeedCore.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Avatar(),
            ),
            TextArea(onSubmitted: (value) {
              setState(() {
                text = value;
              });
            }),
          ],
        ),
        Button(
            label: 'Post',
            onPressed: () async {
              await streamFeed.onAddReaction(
                  kind: 'comment',
                  activity: widget.activity,
                  data: {'text': text},
                  targetFeeds: widget.targetFeeds);
            },
            type: ButtonType.faded)
      ],
    );
  }
}