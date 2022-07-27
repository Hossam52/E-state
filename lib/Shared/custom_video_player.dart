import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
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
        style: TextStyle(fontSize: 18.sp),
      ),
    );
    if (widget.videoUrl.contains('youtube.com/') ||
        widget.videoUrl.contains('youtu.be/')) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Video demo",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
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
