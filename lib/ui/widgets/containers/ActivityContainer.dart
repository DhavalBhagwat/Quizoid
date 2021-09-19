import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/utils/lib.dart';

class ActivityContainer extends StatelessWidget {

  final BuildContext? context;
  final Function? onBackPressed;
  final Widget? actions;
  final String? title;
  final Widget? child;
  final Widget? bottomNavigationBar;

  ActivityContainer({
    Key? key,
    @required this.context,
    @required this.onBackPressed,
    this.actions,
    @required this.title,
    @required this.child,
    this.bottomNavigationBar,
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
            leading: InkWell(
              child: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.nearlyWhite,
              ),
              onTap: () => onBackPressed!(),
            ),
            middle: Text(
              title!,
            ),
            trailing: actions,
          ),
          body: child,
          bottomNavigationBar: bottomNavigationBar != null ? bottomNavigationBar : null,
        ),
      ),
    );
  }

}
