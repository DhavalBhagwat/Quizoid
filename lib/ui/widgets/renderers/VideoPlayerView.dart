import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:app/db/lib.dart';
import 'package:app/data/entities/lib.dart';
import 'package:app/utils/lib.dart';
import 'package:app/data/bloc/lib.dart';
import 'package:app/services/lib.dart';

class VideoPlayerView extends StatefulWidget {

  final String? videoId;
  final String? url;

  const VideoPlayerView({
    this.videoId = "VID0001",
    @required this.url,
    Key? key
  }) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();

}

class _VideoPlayerState extends State<VideoPlayerView> {

  static const _TAG = "VideoPlayerView";
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  DatabaseManager? _manager;
  List<String> _noteIdList = [];
  Logger _logger = Logger.getInstance;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _getAssignedNotes();
  }

  @override
  Widget build(BuildContext context) {
    print(_noteIdList.toString());
    return Center(
      child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized ? ValueListenableBuilder(
        valueListenable: _chewieController!.videoPlayerController,
        builder: (BuildContext context, VideoPlayerValue value, Widget? child) {
          if (_noteIdList.contains(value.position.inSeconds.toString())) print(value.position.inSeconds.toString());
          return Chewie(controller: _chewieController!);
        },
      ) : Column( //TODO add loading
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading'),
        ],
      ),
    );
  }


  Future<void> _initializePlayer() async {
    _videoController = VideoPlayerController.network(widget.url!);
    await _videoController!.initialize().then((_) {
      setState(() {
        _videoController!.play();
      });
    });
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      looping: true,
      showControls: true,
      autoInitialize: true,
      aspectRatio: 16 / 9,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      additionalOptions: (BuildContext optionsContext) => _getVideoOptions(optionsContext),
      customControls: MaterialControls(),
      placeholder: Container(
        color: Colors.grey,
      ),
      // autoInitialize: true,
    );
  }

  List<OptionItem> _getVideoOptions(BuildContext context) => [
    OptionItem(
      onTap: () async {
        _videoController?.pause();
        NotesProvider.getInstance.set(widget.videoId.toString(), _chewieController?.videoPlayerController.value.position.inSeconds.toString(), "Hello World !!");
        Navigator.pop(context);
        DialogService.getInstance.notesDialog(context, controller: _chewieController?.videoPlayerController);
        },
      iconData: Icons.assignment_outlined,
      title: Strings.add_note,
    ),
  ];

  void _getAssignedNotes() async {
    try {
      _logger.d(_TAG, "getAssignedNotes()", message: "Getting assigned notes if any");
      _manager = await DatabaseHelper.getInstance;
      await _manager!.userDao.getNotesList("1234").then((response) {
        if (response.isNotEmpty) {
          for (ENotes note in response) {
            _noteIdList.add(note.noteId!);
          }
        }
        else print("EMPTY !!!!!!!!!!!!!!!!!!!!!!!!!");
      });
    } catch (error) {
      _logger.d(_TAG, "getAssignedNotes()", message: error.toString());
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

}
