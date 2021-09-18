import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerView extends StatelessWidget {

  final BuildContext? activityContext;
  final ChewieController? chewieController;

  const VideoPlayerView({
    @required this.activityContext,
    @required this.chewieController,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chewie(controller: chewieController!)
    );
  }

}
