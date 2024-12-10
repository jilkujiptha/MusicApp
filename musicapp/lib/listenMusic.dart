import 'dart:io';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/showBottomSheet.dart';

class Listenmusic extends StatefulWidget {
  const Listenmusic({super.key});

  @override
  State<Listenmusic> createState() => _ListenmusicState();
}

class _ListenmusicState extends State<Listenmusic>
    with SingleTickerProviderStateMixin {
  final AudioPlayer player = AudioPlayer();
  List<File> musicFiles = [];

  String? _page;
  int currentIndex = 0;
  late AnimationController _controller;
  bool _isIcon = false;
  bool _isFavorite = false;
  bool _isShuffle = false;
  bool _isRepeat = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    Future.delayed(
      Duration(milliseconds: 50),
      () => playMusic(_page!),
    );
  }

  void _bottomButton() {
    showModalBottomSheet(
      context: context,
      builder: (cxt) => ShowBottomSheet(),
      backgroundColor: const Color.fromARGB(255, 40, 6, 97),
    );
  }

  Future<void> playMusic(String filePath) async {
    try {
      await player.setFilePath(filePath);
      await player.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  Future<void> playNext() async {
    setState(() {
      currentIndex = (currentIndex + 1) % musicFiles.length;
    });
  }

  Future<void> playPrevious() async {
    setState(() {
      currentIndex = (currentIndex - 1 + musicFiles.length) % musicFiles.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    _page = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Text(
              "Now playing",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            // Center(
            //     child: Text(
            //   "Playlist  'Platlist of the day'",
            //   style: TextStyle(color: Colors.white, fontSize: 18),
            // ),
            // ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: _isFavorite ? Colors.red : Colors.white,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: _bottomButton,
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 44, 10, 102),
              Colors.black,
            ],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(193, 38, 13, 80),
                boxShadow: [
                  BoxShadow(blurRadius: 5, color: Colors.black),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "./Image/images.jpeg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      _page!.split("/").last.split("-").first,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      _page!.split("/").last.split("-").last.substring(
                          0, _page!.split("/").last.split("-").last.length - 4),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              height: 5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 40, 6, 97)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "0.00",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "0.00",
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: playPrevious,
                  icon: Icon(
                    Icons.skip_previous,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                    alignment: Alignment.center,
                    style: IconButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {
                      setState(() {
                        _isIcon = !_isIcon;

                        _isIcon ? _controller.reverse() : _controller.forward();
                      });
                    },
                    icon: AnimatedIcon(
                        icon: AnimatedIcons.pause_play,
                        size: 50,
                        color: Colors.white,
                        progress: _controller)),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  onPressed: playNext,
                  icon: Icon(
                    Icons.skip_next,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isShuffle = !_isShuffle;
                    });
                  },
                  icon: Icon(
                    Icons.shuffle,
                    color: _isShuffle ? Colors.green : Colors.white,
                    size: 30,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isRepeat = !_isRepeat;
                    });
                  },
                  icon: Icon(
                    Icons.repeat,
                    color: _isRepeat ? Colors.green : Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
