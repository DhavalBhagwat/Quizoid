import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppContainer extends StatelessWidget {

  final Widget? child;

  AppContainer({
    Key? key,
    @required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: child!,
    );
  }

}
