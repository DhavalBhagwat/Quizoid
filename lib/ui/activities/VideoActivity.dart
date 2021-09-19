import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:app/data/bloc/lib.dart';
import 'package:app/data/entities/lib.dart';
import 'package:app/db/lib.dart';
import 'package:app/services/lib.dart';
import 'package:app/ui/widgets/lib.dart';
import 'package:app/utils/lib.dart';
import 'package:app/ui/interfaces/lib.dart';

class VideoActivity extends StatefulWidget {

  const VideoActivity({
    Key? key,
  }) : super(key: key);

  @override
  _VideoActivityState createState() => _VideoActivityState();

}

class _VideoActivityState extends State<VideoActivity> implements IVideoListener {

  static const _TAG = "VideoActivity";
  Logger _logger = Logger.getInstance;
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  DatabaseManager? _manager;
  NotesProvider? _provider;
  List<String> _noteIdList = [];
  List<ENotes> _notesList = [];
  Future<void>? _isPlayerInitialized;
  String? _videoId, _url;

  @override
  void initState() {
    _url = Get.arguments["url"];
    _videoId = Get.arguments["videoId"];
    _provider = NotesProvider.getInstance;
    _isPlayerInitialized = _initializePlayer();
    _getAssignedNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityContainer(
        context: context,
        onBackPressed: Navigator.of(context).pop,
        title: "title",
        child: FutureBuilder<void>(
            future: _isPlayerInitialized,
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done ? Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: VideoPlayerView(
                          activityContext: context,
                          chewieController: _chewieController
                      ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: AppTheme.lightBlue,
                    ),
                  )
                ],
              ) : LoadingIndicator();
            },
        ),
    );
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
    _videoController = VideoPlayerController.network(_url!)..addListener(videoNotesListener)..addListener(videoDurationListener);
    await _videoController!.initialize().then((_) {
      setState(() {
        _videoController!.play();
      });
    });
    _chewieController = ChewieController(
      videoPlayerController: _videoController!,
      autoPlay: true,
      autoInitialize: true,
      aspectRatio: 16 / 9,
      placeholder: LoadingIndicator(),
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,//TODO add colors
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
          _provider?.videoId = _videoId!;
          _provider?.noteId = _chewieController!.videoPlayerController.value.position.inSeconds.toString();
          Navigator.pop(context);
          DialogService.getInstance.notesDialog(context, controller: _chewieController?.videoPlayerController);
        },
        iconData: Icons.assignment_outlined,
        title: Strings.add_note,
      ),
    ];
  }

  @override
  void videoDurationListener() async {
    try {
      if (_chewieController!.videoPlayerController.value.isInitialized && _chewieController?.videoPlayerController.value.position == _chewieController?.videoPlayerController.value.duration) {
        NavigationService.getInstance.quizActivity();
      }
    } catch (error) {
      _logger.d(_TAG, "videoNotesListener()");
    }
  }

  @override
  void videoNotesListener() {
    try {
      String? second = _chewieController?.videoPlayerController.value.position.inSeconds.toString();
      if (_noteIdList.contains(second)) {
        Future.delayed(Duration(milliseconds: 1000), () {
          if (!AppConstants.isNoteShown) {
            AppConstants.isNoteShown = true;
            _chewieController?.videoPlayerController.pause();
            _manager?.userDao.getNote(second!, _videoId!).then((note) {
              DialogService.getInstance.notesBottomDialog(controller: _chewieController?.videoPlayerController, note: note?.noteContent);
            });
          }
        });
      }
    } catch (error) {
      _logger.e(_TAG, "videoNotesListener()", message: error.toString());
    }

  }

  @override
  void dispose() {
    _videoController?.removeListener(videoNotesListener);
    _videoController?.removeListener(videoDurationListener);
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

}
