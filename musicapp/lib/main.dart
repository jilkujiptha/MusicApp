import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:musicapp/MusicPage.dart';
import 'package:musicapp/favoriteSong.dart';
import 'package:musicapp/listenMusic.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  var fav = await Hive.openBox("mybox");

  runApp(MaterialApp(
    home: MusicPage(),
    routes: {
      "listen": (context) => Listenmusic(),
      "music": (context) => MusicPage(),
      "album": (context) => Album()
    },
  ));
}
