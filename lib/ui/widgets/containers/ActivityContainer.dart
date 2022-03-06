import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quizoid/utils/lib.dart';

class ActivityContainer extends StatelessWidget {

  final BuildContext? context;
  final Function? onBackPressed;
  final String? title;
  final Widget? child;
  final bool? isBackAvailable;
  final Widget? action;

  ActivityContainer({
    Key? key,
    @required this.context,
    @required this.onBackPressed,
    this.isBackAvailable = true,
    this.action,
    @required this.title,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () => onBackPressed!(),
        child: Scaffold(
          backgroundColor: AppTheme.background,
          appBar: CupertinoNavigationBar(
            backgroundColor: AppTheme.colorPrimary,
            leading: isBackAvailable! ? InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.colorAccent,
              ),
              onTap: () => onBackPressed!(),
            ) : Container(),
            middle: Text(title!),
            trailing: action,
          ),
          body: child,
        ),
      ),
    );
  }

}
