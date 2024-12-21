import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class musicProvider extends ChangeNotifier {
  List<File> musicFiles = [];
  final AudioPlayer player = AudioPlayer();

  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  int currentIndex = 0;
  late AnimationController controller;
  bool isIcon = false;
  bool isShuffle = false;
  bool isRepeat = false;
  bool ismuted = false;
  bool isPlayer = false;
  int currentMusicIndex = 0;

  String name = "";
  String bottom = "";

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
          .where((file) => file.path.endsWith(".m4a"))
          .map((file) => File(file.path))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> playMusic(String filePath) async {
    try {
      await player.setFilePath(filePath);
      await player.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  String? _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$minutes:$seconds";
  }

  void duration() {
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

  void playNext() {
    if (currentMusicIndex < musicFiles.length - 1) {
      currentMusicIndex++;
      notifyListeners();
      playMusic(musicFiles[currentMusicIndex].path);
      name = musicFiles[currentMusicIndex].path;
    }
  }

  void playPrevious() {
    if (currentMusicIndex > 0) {
      currentMusicIndex--;
      notifyListeners();
      playMusic(musicFiles[currentMusicIndex].path);
      name = musicFiles[currentMusicIndex].path;
    }
  }

  void automaticNext() {
    player.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        playNext();
      }
    });
  }

  void shuffle() {
    musicFiles.shuffle();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}
