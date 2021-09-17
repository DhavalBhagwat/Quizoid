import 'package:app/data/entities/ENotes.dart';
import 'package:app/db/DatabaseHelper.dart';
import 'package:app/db/lib.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage();

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;

  DatabaseManager? _manager;

  @override
  void initState() {
    super.initState();
    initializeDatabase();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoController = VideoPlayerController.network('https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4');
    await _videoController?.initialize();
    _chewieController = ChewieController(
        videoPlayerController: _videoController!,
        autoPlay: true,
        looping: true,
        showControls: true,
      additionalOptions: (context) {
        return <OptionItem>[
          OptionItem(
            onTap: () async {
            await   _manager!.userDao.insertNote(ENotes(videoId: "1234", noteId: "noteid", noteContent: "HHELLO WORLD"));
            },
            iconData: Icons.chat,
            title: 'My localized title',
          ),
          OptionItem(
            onTap: () =>
                debugPrint('Another option working!'),
            iconData: Icons.chat,
            title: 'Another localized title',
          ),
        ];
      },
      customControls: MaterialControls()
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  void initializeDatabase() async {
    _manager = await DatabaseHelper.getInstance;
    _manager!.userDao.getNotesList("1234").then((response) => {
      if(response.isNotEmpty)print(" NOT EMPTY !!!!!!!!!!!!!!!!!!!!!!!!!")
      else print("EMPTY !!!!!!!!!!!!!!!!!!!!!!!!!")
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Flutter Demo Home Page"),
      ),
      body: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(
        controller: _chewieController!,
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Loading'),
        ],
      ),

    );
  }
}
