import 'package:quizoid/utils/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
          color: AppTheme.colorAccent
      ),
    );
  }

}
