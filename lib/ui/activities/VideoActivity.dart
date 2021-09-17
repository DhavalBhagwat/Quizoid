import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app/ui/widgets/lib.dart';
import 'package:app/utils/lib.dart';

class VideoActivity extends StatefulWidget {

  const VideoActivity({
    Key? key
  }) : super(key: key);

  @override
  _VideoActivityState createState() => _VideoActivityState();

}

class _VideoActivityState extends State<VideoActivity> {

  static const _TAG = "VideoActivity";
  Logger _logger = Logger.getInstance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the VideoActivity object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text("Flutter Demo Home Page"),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
                child: VideoPlayerView(
        url:
        "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4")),
    Expanded(
      flex: 4,
      child: Container(),

    )
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

}
