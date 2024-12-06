import 'package:flutter/material.dart';
import 'package:musicapp/MainPage.dart';
import 'package:musicapp/MusicPage.dart';
import 'package:musicapp/listenMusic.dart';
import 'package:musicapp/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    home: MusicPage(),
    routes: {
      "listen": (context) => Listenmusic(),
      "login": (context) => LoginPage(),
      "main": (context) => MainPage(),
      "music": (context) => MusicPage()
    },
  ));
}
