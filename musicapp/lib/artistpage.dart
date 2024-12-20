import 'package:flutter/material.dart';
import 'package:musicapp/changeNotifier.dart';
import 'package:provider/provider.dart';

class Artist extends StatefulWidget {
  const Artist({super.key});

  @override
  State<Artist> createState() => _ArtistState();
}

class _ArtistState extends State<Artist> {
  @override
  Widget build(BuildContext context) {
    return Consumer<musicProvider>(
        builder: (context, music, child) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                iconTheme: IconThemeData(color: Colors.white),
                backgroundColor: Colors.transparent,
              ),
              body: Container(
                padding: EdgeInsets.all(10),
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
                child: Expanded(
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
                                    borderRadius: BorderRadius.circular(100),
                                    color:
                                        const Color.fromARGB(193, 38, 13, 80),
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
                                music.bottom
                                    .split("/")
                                    .last
                                    .split("-")
                                    .last
                                    .substring(
                                        0,
                                        music.bottom
                                                .split("/")
                                                .last
                                                .split("-")
                                                .last
                                                .length -
                                            4),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 13),
                              )
                            ],
                          ));
                        })),
              ),
            ));
  }
}
