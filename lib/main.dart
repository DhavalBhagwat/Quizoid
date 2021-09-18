import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app/data/bloc/lib.dart';
import 'package:app/App.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  // Workmanager().initialize(SystemUtils.syncPendingVehicles, isInDebugMode: !kReleaseMode);
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(TODO REMOVE
  //     statusBarColor: AppTheme.colorPrimary,
  //     statusBarBrightness: Brightness.dark,
  //   ),
 // );

 // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

//  await Firebase.initializeApp();
//  FirebaseMessaging.onBackgroundMessage(NotificationUtils.firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NotesProvider()),
      ],
      child: App(),
    ),
  );
}



