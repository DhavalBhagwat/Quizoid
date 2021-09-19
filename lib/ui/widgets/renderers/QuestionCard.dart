import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:app/data/controller/lib.dart';
import 'package:app/data/podos/lib.dart';
import 'package:app/ui/widgets/lib.dart';

class QuestionCard extends StatelessWidget {

  final Question? question;

  const QuestionCard({
    Key? key,
    @required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(question!.question!),
          SizedBox(height: 10.0),
          ...List.generate(
            question!.options!.length,
            (index) => Option(
              index: index,
              text: question!.options![index],
              onTap: () => _controller.checkAnswer(question!, index),
            ),
          ),
        ],
      ),
    );
  }

}
