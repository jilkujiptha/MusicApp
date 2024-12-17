import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List favorite = [];
  final _favorite = Hive.box("mybox");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        title: Text(
          "My Playlist",
          style: TextStyle(color: Colors.white),
        ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[800]),
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor:
                                    const Color.fromARGB(255, 44, 10, 102),
                                title: Center(
                                  child: Text(
                                    " New Playlist",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                actions: [
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: TextField(
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Cancel",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            "Confirm",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "New Playlist",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
