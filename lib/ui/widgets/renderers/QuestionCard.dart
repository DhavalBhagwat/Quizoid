import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:app/data/controller/lib.dart';
import 'package:app/data/podos/lib.dart';
import 'package:app/ui/widgets/lib.dart';

class QuestionCard extends StatelessWidget {

  final Question? question;
  final bool? isList;
  final bool? isVertical;

  const QuestionCard({
    Key? key,
    @required this.question,
    this.isList = true,
    this.isVertical = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text(question!.question!),
          SizedBox(height: 10.0),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isList! ? 1 : 2,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 12.0,
                childAspectRatio: isList! ? 4 : 1,
              ),
              padding: EdgeInsets.all(16.0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: question!.options!.length,
              itemBuilder: (BuildContext context, int index) => Option(
                index: index,
                text: question!.options![index],
                onTap: () => _controller.checkAnswer(question!, index),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
