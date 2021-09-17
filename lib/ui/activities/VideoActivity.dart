import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:app/data/bloc/lib.dart';
import 'package:app/data/entities/lib.dart';
import 'package:app/db/lib.dart';
import 'package:app/services/lib.dart';
import 'package:app/ui/widgets/lib.dart';
import 'package:app/utils/lib.dart';

class VideoActivity extends StatefulWidget {

  final String? videoId;

  const VideoActivity({
    Key? key,
    this.videoId = "VID0001",
  }) : super(key: key);

  @override
  _VideoActivityState createState() => _VideoActivityState();

}

class _VideoActivityState extends State<VideoActivity> {

  static const _TAG = "VideoActivity";
  Logger _logger = Logger.getInstance;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  DatabaseManager? _manager;
  NotesProvider? _provider;
  List<String> _noteIdList = [];
  List<ENotes> _notesList = [];

  @override
  void initState() {
    _provider = NotesProvider.getInstance;
    _initializePlayer();
    _getAssignedNotes();
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
                  activityContext: context,
        chewieController: _chewieController)),
    Expanded(
      flex: 4,
      child: Container(color: AppTheme.lightBlue,),

    )

          ],
        ));
  }


  void _getAssignedNotes() async {
    try {
      _logger.d(_TAG, "getAssignedNotes()", message: "Getting assigned notes if any");
      if (_notesList.isNotEmpty) _notesList.clear();
      if (_noteIdList.isNotEmpty) _noteIdList.clear();
      _manager = await DatabaseHelper.getInstance;
      await _manager!.userDao.getNotesList("VID0001").then((response) {
        if (response.isNotEmpty) {
          _notesList = response;
          for (ENotes note in response) {
            _noteIdList.add(note.noteId!);
          }
          print(_noteIdList.toString());
        }
        else print("EMPTY !!!!!!!!!!!!!!!!!!!!!!!!!");
      });
    } catch (error) {
      _logger.d(_TAG, "getAssignedNotes()", message: error.toString());
    }
  }

  Future<void> _initializePlayer() async {
    _videoController = VideoPlayerController.network("https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4")..addListener(_getNotesBasedOnDuration);
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
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      //showOptions: false,
      additionalOptions: (BuildContext optionsContext) => _getVideoOptions(optionsContext),
      customControls: MaterialControls(),
    );
  }

  List<OptionItem> _getVideoOptions(BuildContext context) {
    return [
      OptionItem(
        onTap: () async {
          print(_chewieController!.videoPlayerController.value.position.inSeconds.toString());
          _chewieController?.videoPlayerController.pause();
          _provider?.videoId = widget.videoId.toString();
          _provider?.noteId = _chewieController!.videoPlayerController.value.position.inSeconds.toString();
          Navigator.pop(context);
          DialogService.getInstance.notesDialog(context, controller: _chewieController?.videoPlayerController);
        },
        iconData: Icons.assignment_outlined,
        title: Strings.add_note,
      ),
    ];
  }

  void _getNotesBasedOnDuration() {
    String? second = _chewieController?.videoPlayerController.value.position.inSeconds.toString();
    if (_noteIdList.contains(second)) {
      Future.delayed(Duration(milliseconds: 1000), () {
        if (!AppConstants.isNoteShown) {
          AppConstants.isNoteShown = true;
          _chewieController?.videoPlayerController.pause();
          _manager?.userDao.getNote(second!, widget.videoId!).then((note) {
            DialogService.getInstance.notesBottomDialog(controller: _chewieController?.videoPlayerController, note: note?.noteContent);
          });
        }
      });
    }
  }

  @override
  void dispose() {
     _videoController?.removeListener(_getNotesBasedOnDuration);
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

}
