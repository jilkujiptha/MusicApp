import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/changeNotifier.dart';
import 'package:musicapp/showBottomSheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController search = TextEditingController();
  List<File> musicFiles = [];
  final AudioPlayer player = AudioPlayer();
  List favorite = [];
  final _favorite = Hive.box("mybox");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    data();
    favortes();
  }

  Future<void> loadMusicFiles() async {
    musicFiles = await getMusicFile();
    setState(() {});
  }

  void data() {
    var data = Provider.of<musicProvider>(context, listen: false);

    data.loadMusicFiles();
  }

  void _bottomButton() {
    showModalBottomSheet(
      context: context,
      builder: (cxt) => ShowBottomSheet(),
      backgroundColor: const Color.fromARGB(255, 40, 6, 97),
    );
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
  bool isFavorite = false;
  Future<void> playMusic(String filePath) async {
    try {
      await Player.play();
    } catch (e) {
      print("Error Playing audio:$e");
    }
  }

  void favortes() {
    if (_favorite.get("key") != null) {
      favorite = _favorite.get("key");
    }
    print("===================================");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<musicProvider>(
        builder: (context, music, child) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                title: Text(
                  "Music Player",
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.widgets_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_vert,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              body: Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 55, 15, 124),
                        Colors.black,
                      ],
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        "Hi",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontFamily: "Schyler"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "WHAT YOU WANT TO HEAR TODAY?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: "Schyler"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20, top: 5),
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(255, 28, 4, 70),
                          ),
                          child: Expanded(
                            child: TextField(
                              controller: search,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  prefixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.search,
                                    ),
                                  ),
                                  hintText: "Search..."),
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            width: 150,
                            height: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(255, 51, 7, 126)),
                            child: Center(
                              child: Text(
                                "All Songs",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "fav");
                            },
                            child: Container(
                              padding: EdgeInsets.all(20),
                              width: 150,
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color.fromARGB(255, 51, 7, 126)),
                              child: Center(
                                child: Text(
                                  "Favorites",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "My Music",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Container(
                        child: TabBar(
                          unselectedLabelColor: Colors.white,
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          tabs: [
                            Tab(
                              text: "Song",
                            ),
                            Tab(
                              text: "Artist",
                            ),
                            Tab(
                              text: "Album",
                            ),
                            Tab(
                              text: "Favorites",
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:
                            TabBarView(controller: _tabController, children: [
                          Container(
                              child: music.musicFiles.isEmpty
                                  ? Center(
                                      child: Text(
                                        "No music files found",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : Expanded(
                                      child: ListView.builder(
                                          padding: EdgeInsets.only(top: 10),
                                          itemCount: music.musicFiles.length,
                                          itemBuilder: (context, index) {
                                            final file =
                                                music.musicFiles[index];
                                            return GestureDetector(
                                              onTap: () {
                                                music.playMusic(file.path);

                                                Navigator.pushNamed(
                                                    context, "listen",
                                                    arguments: file.path);
                                              },
                                              child: Container(
                                                  margin:
                                                      EdgeInsets.only(top: 20),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 60,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: const Color
                                                                .fromARGB(193,
                                                                38, 13, 80)),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          child: Image.asset(
                                                            "./Image/images.jpeg",
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            file.path
                                                                .split("/")
                                                                .last
                                                                .split("-")
                                                                .first,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            file.path
                                                                .split("/")
                                                                .last
                                                                .split("-")
                                                                .last
                                                                .substring(
                                                                    0,
                                                                    file.path
                                                                            .split("/")
                                                                            .last
                                                                            .split("-")
                                                                            .last
                                                                            .length -
                                                                        4),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          )
                                                        ],
                                                      ),
                                                      Spacer(),
                                                      IconButton(
                                                          onPressed:
                                                              _bottomButton,
                                                          icon: Icon(
                                                            Icons.more_vert,
                                                            color: Colors.white,
                                                          ))
                                                    ],
                                                  )),
                                            );
                                          }),
                                    )),
                          Container(
                              child: ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  itemCount: music.musicFiles.length,
                                  itemBuilder: (context, index) {
                                    final file = music.musicFiles[index];

                                    return Container(
                                        child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: const Color.fromARGB(
                                                  193, 38, 13, 80),
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 1,
                                                    color: const Color.fromARGB(
                                                        193, 19, 2, 49),
                                                    offset: Offset(5, 5))
                                              ]),
                                          child: Icon(
                                            Icons.person,
                                            size: 35,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          file.path
                                              .split("/")
                                              .last
                                              .split("-")
                                              .last
                                              .substring(
                                                  0,
                                                  file.path
                                                          .split("/")
                                                          .last
                                                          .split("-")
                                                          .last
                                                          .length -
                                                      4),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13),
                                        )
                                      ],
                                    ));
                                  })),
                          Container(
                              child: ListView.builder(
                                  padding: EdgeInsets.all(10),
                                  itemCount: music.musicFiles.length,
                                  itemBuilder: (context, index) {
                                    final file = music.musicFiles[index];
                                    return GestureDetector(
                                      onTap: () async {
                                        await player.setFilePath(file.path);
                                        player.play();
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              file.path
                                                  .split("/")
                                                  .last
                                                  .split("-")
                                                  .first,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Text(
                                              file.path
                                                  .split("/")
                                                  .last
                                                  .split("-")
                                                  .last
                                                  .substring(
                                                      0,
                                                      file.path
                                                              .split("/")
                                                              .last
                                                              .split("-")
                                                              .last
                                                              .length -
                                                          4),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                          Container(
                              child: Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(top: 5),
                                      itemCount: favorite.length,
                                      itemBuilder: (context, index) {
                                        final file = favorite[index];
                                        return GestureDetector(
                                          onTap: () async {
                                            await player.setFilePath(file);
                                            Navigator.pushNamed(
                                                context, "listen",
                                                arguments: file);
                                          },
                                          child: Container(
                                              margin: EdgeInsets.only(top: 20),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 60,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: const Color
                                                            .fromARGB(
                                                            193, 38, 13, 80)),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Image.asset(
                                                        "./Image/images.jpeg",
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        file
                                                            .split("/")
                                                            .last
                                                            .split("-")
                                                            .first,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        file
                                                            .split("/")
                                                            .last
                                                            .split("-")
                                                            .last
                                                            .substring(
                                                                0,
                                                                file
                                                                        .split(
                                                                            "/")
                                                                        .last
                                                                        .split(
                                                                            "-")
                                                                        .last
                                                                        .length -
                                                                    4),
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                  Spacer(),
                                                  IconButton(
                                                      onPressed: _bottomButton,
                                                      icon: Icon(
                                                        Icons.more_vert,
                                                        color: Colors.white,
                                                      ))
                                                ],
                                              )),
                                        );
                                      }))),
                        ]),
                      ),
                    ],
                  )),
            ));
  }
}
