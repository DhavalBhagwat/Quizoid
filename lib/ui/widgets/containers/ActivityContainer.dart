import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/utils/lib.dart';

class ActivityContainer extends StatelessWidget {

  final BuildContext? context;
  final Function? onBackPressed;
  final String? title;
  final Widget? child;
  final bool? isBackAvailable;

  ActivityContainer({
    Key? key,
    @required this.context,
    @required this.onBackPressed,
    this.isBackAvailable = true,
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
                color: AppTheme.nearlyWhite,
              ),
              onTap: () => onBackPressed!(),
            ) : Container(),
            middle: Text(title!),
          ),
          body: child,
        ),
      ),
    );
  }

}
