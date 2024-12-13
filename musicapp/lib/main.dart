import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:musicapp/MusicPage.dart';
import 'package:musicapp/changeNotifier.dart';
import 'package:musicapp/favoriteSong.dart';
import 'package:musicapp/listenMusic.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:musicapp/showBottomSheet.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 await Hive.initFlutter();
  var fav = await Hive.openBox("mybox");

  runApp(ChangeNotifierProvider(create: (context)=>musicProvider(),
  child: MaterialApp(
    home: MusicPage(),
    routes: {
      "listen": (context) => Listenmusic(),
      "music": (context) => MusicPage(),
      "fav": (context) => FavoriteMusiclist(),
      "show":(context)=>ShowBottomSheet(),
    },
  ),
  ));
}
 