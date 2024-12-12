import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/changeNotifier.dart';
import 'package:musicapp/showBottomSheet.dart';
import 'package:provider/provider.dart';

class Listenmusic extends StatefulWidget {
  const Listenmusic({super.key});

  @override
  State<Listenmusic> createState() => _ListenmusicState();
}

class _ListenmusicState extends State<Listenmusic>
    with SingleTickerProviderStateMixin {
  final AudioPlayer player = AudioPlayer();
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  List<File> musicFiles = [];

  final _favorite = Hive.box("mybox");
// ======================================================
  String? _page;
  int currentIndex = 0;
  late AnimationController _controller;
  bool _isIcon = false;
  bool _isFavorite = false;
  bool _isShuffle = false;
  bool _isRepeat = false;
  bool _ismuted = false;
// ===============================================
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    play();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    player.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    player.durationStream.listen((duration) {
      setState(() {
        _totalDuration = duration ?? Duration.zero;
      });
    });
    // playMusic(musicFiles[currentIndex].path);
  }

  // void dispose() {
  //   player.dispose();
  //   super.dispose();
  // }

// ========================================================================
  void _bottomButton() {
    showModalBottomSheet(
      context: context,
      builder: (cxt) => ShowBottomSheet(),
      backgroundColor: const Color.fromARGB(255, 40, 6, 97),
    );
  }
  // =====================================================================

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
    playMusic(musicFiles[currentIndex].path);
  }

  Future<void> playPrevious() async {
    setState(() {
      currentIndex = (currentIndex - 1 + musicFiles.length) % musicFiles.length;
    });
    playMusic(musicFiles[currentIndex].path);
  }

  String? _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, "0");
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, "0");
    return "$minutes:$seconds";
  }

  void play() {
    var Play = Provider.of<musicProvider>(context, listen: false);
    Play.duration();
    print(Play);
    print("=========================================");
  }

  @override
  Widget build(BuildContext context) {
    _page = ModalRoute.of(context)!.settings.arguments as String;
    return Consumer<musicProvider>(
        builder: (context, Music, child) => Scaffold(
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
                        List ls = [];
                        ls.add(_page);
                        _favorite.put("key", ls);
                        print(ls);
                        print("==============================================");
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _page!.split("/").last.split("-").first,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              _page!.split("/").last.split("-").last.substring(
                                  0,
                                  _page!
                                          .split("/")
                                          .last
                                          .split("-")
                                          .last
                                          .length -
                                      4),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          overlayShape: SliderComponentShape.noOverlay),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 9,
                        // height: 5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Slider(
                            activeColor: const Color.fromARGB(255, 40, 6, 97),
                            inactiveColor: Colors.white,
                            min: 0.0,
                            max: Music.totalDuration.inSeconds.toDouble(),
                            value: Music.currentPosition.inSeconds
                                .toDouble()
                                .clamp(0.0,
                                    Music.totalDuration.inSeconds.toDouble()),
                            onChanged: (value) {
                              final newPosition =
                                  Duration(seconds: value.round());
                              Music.player.seek(newPosition);
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${_formatDuration(Music.currentPosition)}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "${_formatDuration(Music.totalDuration)}",
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
                        // Text(musicFiles[currentIndex].path.split("/").last),
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
                                backgroundColor:
                                    const Color.fromARGB(255, 40, 6, 97)),
                            onPressed: () {
                              setState(() {
                                _isIcon = !_isIcon;

                                _isIcon
                                    ? _controller.forward()
                                    : _controller.reverse();
                                _isIcon ? player.pause() : player.play();
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
                                _ismuted = !_ismuted;
                              });
                              player.setVolume(_ismuted ? 0.0 : 1.0);
                            },
                            icon: Icon(
                              _ismuted ? Icons.volume_off : Icons.volume_up,
                              color: Colors.white,
                              size: 30,
                            )),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isRepeat = !_isRepeat;
                              _isRepeat
                                  ? player.setLoopMode(LoopMode.one)
                                  : player.setLoopMode(LoopMode.off);
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
            ));
  }
}
