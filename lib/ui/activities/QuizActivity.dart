import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app/data/podos/lib.dart';
import 'package:app/utils/lib.dart';
import 'package:app/ui/widgets/lib.dart';
import 'package:app/services/DialogService.dart';
import 'package:app/data/controller/lib.dart';
import 'package:app/services/lib.dart';

class QuizActivity extends StatefulWidget {

  const QuizActivity({
    Key? key,
  }) : super(key: key);

  @override
  _QuizActivityState createState() => _QuizActivityState();

}

class _QuizActivityState extends State<QuizActivity> {

  static const _TAG = "QuizActivity";
  Logger _logger = Logger.getInstance;
  VideoCategory? _category;
  late QuestionController _controller;

  @override
  void initState() {
    _category = Get.arguments["category"];
    _controller = Get.put(QuestionController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller.getQuestionsList();
    return ActivityContainer(
      context: context,
      onBackPressed: () => DialogService.getInstance.exitQuizDialog(),
      title: _category!.name + " " + Strings.quiz,
      child: Obx(() => _controller.isLoading.value ? LoadingIndicator() : _buildQuizForm(context)



    ));
  }

  Widget _buildQuizForm(BuildContext context) =>     Column( //TODO
    children: [
      Padding(
        padding: EdgeInsets.all(20.0),
        child: ProgressBar(),
      ),
      SizedBox(height: 20.0),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Text.rich(
          TextSpan(
            text: "Question ${_controller.questionNumber.value}",
            children: [
              TextSpan(
                text: "/${_controller.questions.length}",
              ),
            ],
          ),
        ),

      ),
      Divider(thickness: 1.5),
      SizedBox(height: 20.0),
      Expanded(
        flex: 2,
        child: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _controller.pageController,
          onPageChanged: _controller.updateTheQnNum,
          itemCount: _controller.questions.length,
          itemBuilder: (context, index) => QuestionCard(question: _controller.questions[index]),
        ),
      ),
    ],
  );

  // Widget _buildForm() {
  //   Question question = _questions![_currentIndex];
  //   List<dynamic>? options = question.incorrectAnswers;
  //   if (!options!.contains(question.correctAnswer)) {
  //     options.add(question.correctAnswer);
  //     options.shuffle();
  //   }
  //   return Stack(
  //     children: <Widget>[
  //       Padding(
  //         padding: EdgeInsets.all(16.0),
  //         child: Column(
  //           children: <Widget>[
  //             Row(
  //               children: <Widget>[
  //                 CircleAvatar(
  //                   backgroundColor: Colors.white70,
  //                   child: Text("${_currentIndex + 1}"),
  //                 ),
  //                 SizedBox(width: 16.0),
  //                 Expanded(
  //                   child: Text(
  //                     HtmlUnescape().convert(_questions![_currentIndex].question!),
  //                     softWrap: true,
  //                     style: MediaQuery.of(context).size.width > 800 ? _questionStyle.copyWith(fontSize: 30.0)
  //                         : _questionStyle,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 20.0),
  //             Expanded(
  //               child: GridView.builder(
  //
  //                   scrollDirection: Axis.vertical,
  //                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //
  //                 crossAxisCount: true ? 2 : 1,
  //                  mainAxisSpacing: 20.0,
  //                  crossAxisSpacing: 12.0,
  //                 childAspectRatio: 10,
  //               ), itemCount: options.length,
  //                   itemBuilder: (BuildContext context, int index) =>
  //
  //                       RadioListTile<String>(
  //
  //                     title: Text(HtmlUnescape().convert("${options[index]}"),
  //                      ),
  //                     groupValue: _answers[_currentIndex],
  //                     value: options[index],
  //                     onChanged: (value) {
  //                       setState(() {
  //                         _answers[_currentIndex] = options[index];
  //                       });
  //                     },
  //                   )
  //               ) ,
  //             ),
  //             Container(
  //               alignment: Alignment.bottomCenter,
  //               child: RaisedButton(
  //                 padding: MediaQuery.of(context).size.width > 800
  //                     ? const EdgeInsets.symmetric(vertical: 20.0,horizontal: 64.0) : null,
  //                 child: Text(
  //                   _currentIndex == (_questions!.length - 1)
  //                       ? "Submit"
  //                       : "Next", style: MediaQuery.of(context).size.width > 800
  //                     ? TextStyle(fontSize: 30.0) : null,),
  //                 onPressed: _nextSubmit,
  //               ),
  //             )
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }
  //
  // void _nextSubmit() {
  //   if (_answers[_currentIndex] == null) {
  //     _key.currentState!.showSnackBar(SnackBar(
  //       content: Text("You must select an answer to continue."),
  //     ));
  //     return;
  //   }
  //   if (_currentIndex < (_questions!.length - 1)) {
  //     setState(() {
  //       _currentIndex++;
  //     });
  //   } else NavigationService.getInstance.quizFinishedActivity(_questions!, _answers);
  // }

  // Future<void> _initQuiz() async {
  //   _questions = await SyncCommunication.getInstance.getQuestions(_category!.name);
  //       //.then((value) => print(value.toString()));
  //   print(_questions.value);
  // }

}

//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//
//   AnimationController? animationController;
//   bool multiple = true;
//
//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 2000), vsync: this);
//     super.initState();
//   }
//
//   Future<bool> getData() async {
//     await Future<dynamic>.delayed(const Duration(milliseconds: 0));
//     return true;
//   }
//
//   @override
//   void dispose() {
//     animationController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.white,
//       body: FutureBuilder<bool>(
//         future: getData(),
//         builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
//           if (!snapshot.hasData) {
//             return const SizedBox();
//           } else {
//             return Padding(
//               padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   appBar(),
//                   Expanded(
//                     child: FutureBuilder<bool>(
//                       future: getData(),
//                       builder:
//                           (BuildContext context, AsyncSnapshot<bool> snapshot) {
//                         if (!snapshot.hasData) {
//                           return const SizedBox();
//                         } else {
//                           return GridView(
//                             padding: const EdgeInsets.only(
//                                 top: 0, left: 12, right: 12),
//                             physics: const BouncingScrollPhysics(),
//                             scrollDirection: Axis.horizontal,
//                             children: List<Widget>.generate(
//                               homeList.length,
//                                   (int index) {
//                                 final int count = homeList.length;
//                                 final Animation<double> animation =
//                                 Tween<double>(begin: 0.0, end: 1.0).animate(
//                                   CurvedAnimation(
//                                     parent: animationController!,
//                                     curve: Interval((1 / count) * index, 1.0,
//                                         curve: Curves.fastOutSlowIn),
//                                   ),
//                                 );
//                                 animationController?.forward();
//                                 return HomeListView(
//                                   animation: animation,
//                                   animationController: animationController,
//                                   callBack: () {
//                                     Navigator.push<dynamic>(
//                                       context,
//                                       MaterialPageRoute<dynamic>(
//                                         builder: (BuildContext context) =>
//                                         homeList[index].navigateScreen!,
//                                       ),
//                                     );
//                                   },
//                                 );
//                               },
//                             ),
//                             gridDelegate:
//                             SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: multiple ? 2 : 1,
//                               mainAxisSpacing: 12.0,
//                               crossAxisSpacing: 12.0,
//                               childAspectRatio: 1.5,
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Widget appBar() {
//     return SizedBox(
//       height: AppBar().preferredSize.height,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 8, left: 8),
//             child: Container(
//               width: AppBar().preferredSize.height - 8,
//               height: AppBar().preferredSize.height - 8,
//             ),
//           ),
//           Expanded(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 4),
//                 child: Text(
//                   'Flutter UI',
//                   style: TextStyle(
//                     fontSize: 22,
//                     color: AppTheme.darkText,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 8, right: 8),
//             child: Container(
//               width: AppBar().preferredSize.height - 8,
//               height: AppBar().preferredSize.height - 8,
//               color: Colors.white,
//               child: Material(
//                 color: Colors.transparent,
//                 child: InkWell(
//                   borderRadius:
//                   BorderRadius.circular(AppBar().preferredSize.height),
//                   child: Icon(
//                     multiple ? Icons.dashboard : Icons.view_agenda,
//                     color: AppTheme.darkGrey,
//                   ),
//                   onTap: () {
//                     setState(() {
//                       multiple = !multiple;
//                     });
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class HomeListView extends StatelessWidget {
//   const HomeListView(
//       {Key? key,
//         this.callBack,
//         this.animationController,
//         this.animation})
//       : super(key: key);
//
//   final VoidCallback? callBack;
//   final AnimationController? animationController;
//   final Animation<double>? animation;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation!.value), 0.0),
//             child: AspectRatio(
//               aspectRatio: 1.5,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//                 child: Stack(
//                   alignment: AlignmentDirectional.center,
//                   children: <Widget>[
//
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         splashColor: Colors.grey.withOpacity(0.2),
//                         borderRadius:
//                         const BorderRadius.all(Radius.circular(4.0)),
//                         onTap: callBack,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
