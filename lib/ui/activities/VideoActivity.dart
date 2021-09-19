import 'package:app/services/NavigationService.dart';
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
import 'package:app/data/podos/lib.dart';

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
  VideoCategory? _category;

  @override
  void initState() {
    _category = Get.arguments["category"];
    _provider = NotesProvider.getInstance;
    _isPlayerInitialized = initializePlayer();
    getAssignedNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityContainer(
        context: context,
        onBackPressed: () => NavigationService.getInstance.dashboardActivity(),
        title: _category?.name,
        child: Container(
          color: AppTheme.colorPrimaryLight,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: FutureBuilder<void>(
                  future: _isPlayerInitialized,
                  builder: (context, snapshot) => snapshot.connectionState == ConnectionState.done ? VideoPlayerView(
                      activityContext: context,
                      chewieController: _chewieController
                  ) : LoadingIndicator(),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Video Description",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(
                        "This is a test video.",
                        style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }

  @override
  void getAssignedNotes() async {
    try {
      _logger.d(_TAG, "getAssignedNotes()", message: "Getting assigned notes if any");
      if (_notesList.isNotEmpty) _notesList.clear();
      if (_noteIdList.isNotEmpty) _noteIdList.clear();
      _manager = await DatabaseHelper.getInstance;
      await _manager!.userDao.getNotesList(_category!.videoId).then((response) {
        if (response.isNotEmpty) {
          _notesList = response;
          for (ENotes note in response) {
            _noteIdList.add(note.noteId!);
          }
        }
      });
    } catch (error) {
      _logger.d(_TAG, "getAssignedNotes()", message: error.toString());
    }
  }

  @override
  Future<void> initializePlayer() async {
    _videoController = VideoPlayerController.network(_category!.videoUrl)..addListener(videoNotesListener)..addListener(videoDurationListener);
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
      additionalOptions: (BuildContext optionsContext) => getVideoOptions(optionsContext),
      customControls: MaterialControls(),
    );
  }

  @override
  List<OptionItem> getVideoOptions(BuildContext context) {
    return [
      OptionItem(
        onTap: () async {
          print(_chewieController!.videoPlayerController.value.position.inSeconds.toString());
          _chewieController?.videoPlayerController.pause();
          _provider?.videoId = _category!.videoId;
          _provider?.noteId = _chewieController!.videoPlayerController.value.position.inSeconds.toString();
          Navigator.pop(context);
          DialogService.getInstance.notesDialog(
              context,
              controller: _chewieController?.videoPlayerController,
              callback: getAssignedNotes
          );
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
        Future.delayed(Duration(milliseconds: 1000), () {
          NavigationService.getInstance.quizActivity(_category!);
        });
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
            _manager?.userDao.getNote(second!, _category!.videoId).then((note) {
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
