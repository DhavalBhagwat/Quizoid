import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Logger {

  static Logger? _instance;
  Logger._();
  factory Logger() => getInstance;

  static Logger get getInstance {
    if (_instance == null) {
      _instance = new Logger._();
    }
    return _instance!;
  }

  void e(String tag, String methodName, {String? message}) {
    if (message != null) log("$tag : $methodName - $message");
    else log("$tag : $methodName");
  }

  void d(String tag, String methodName, {String? message}) {
    if (kDebugMode) {
      e(tag, methodName, message: message);
    } else {
      if (message != null) debugPrint("$tag : $methodName - $message");
      else debugPrint("$tag : $methodName");
    }
  }

}
