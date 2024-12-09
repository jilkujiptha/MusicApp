import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class musicProvider extends ChangeNotifier {
  List<File> musicFiles = [];
  final AudioPlayer player = AudioPlayer();

  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  String? _page;
  int currentIndex = 0;
  late AnimationController _controller;
  bool _isIcon = false;
  bool _isFavorite = false;
  bool _isShuffle = false;
  bool _isRepeat = false;
  bool _ismuted = false;

  Future<void> loadMusicFiles() async {
    await requestPermission();

    var files = await getMusicFile();
    notifyListeners();
    musicFiles = files;
    print(musicFiles);
  }

  Future<void> requestPermission() async {
    if (await Permission.storage.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted) {
      print("permmission granted");
    } else {
      print("permission denied");
    }
  }

  Future<List<File>> getMusicFile() async {
    // final directory = await getExternalStorageDirectory();
    final musicDir = Directory("/storage/emulated/0/Music");

    if (musicDir.existsSync()) {
      return musicDir
          .listSync()
          .where((file) => file.path.endsWith(".mp3"))
          .map((file) => File(file.path))
          .toList();
    } else {
      return [];
    }
  }

  final Player = AudioPlayer();
  Future<void> playMusic(String filePath) async {
    try {
      await player.setFilePath(filePath);
      await Player.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  String? _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void duration(){
    player.positionStream.listen((position) {
     currentPosition = position;
     notifyListeners();
    });

    player.durationStream.listen((duration) {
        totalDuration = duration ?? Duration.zero;
        notifyListeners();
      });
    // playMusic(musicFiles[currentIndex].path);
  }
  }

