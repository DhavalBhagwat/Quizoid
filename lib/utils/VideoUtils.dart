import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoUtils {

  static const String _TAG = "VideoUtils";

  static Future<ChewieController> getChewieController(VideoPlayerController? _videoController, Function(BuildContext) additionalOptions) async {
    return ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: false,
      showControls: true,
      autoInitialize: true,
      aspectRatio: 16 / 9,
      placeholder: Column(
        //TODO add loading
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
        ],
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,//TODO add colors
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      //showOptions: false,
      additionalOptions: (BuildContext context) => additionalOptions(context),
      customControls: MaterialControls(),
    );
  }

}