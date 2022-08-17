import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class CustomVideoPlayer extends StatelessWidget {
//   const CustomVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);
//   final String videoUrl;
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//         aspectRatio: 16 / 9, child: BetterPlayer.network(videoUrl));
//   }
// }

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);
  final String videoUrl;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    log('Init');
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log(widget.videoUrl);
    final noVideoWidget = Center(
      child: Text(
        'No video available',
        style: Theme.of(context).textTheme.headline2,
      ),
    );
    if (widget.videoUrl.contains('youtube.com/') ||
        widget.videoUrl.contains('youtu.be/')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Video demo",
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 22.sp),
            ),
          ),
          SizedBox(height: 20.h),
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,

            progressIndicatorColor: Colors.amber,
            progressColors: const ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            // onReady: () {
            //   _controller.addListener(() {});
            // },
          ),
        ],
      );
    } else {
      return noVideoWidget;
    }
  }
}
