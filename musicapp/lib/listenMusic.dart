import 'package:flutter/material.dart';

class Listenmusic extends StatefulWidget {
  const Listenmusic({super.key});

  @override
  State<Listenmusic> createState() => _ListenmusicState();
}

class _ListenmusicState extends State<Listenmusic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
            child: Column(
          children: [
            Text(
              "Now playing",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            Center(
                child: Text(
              "Playlist 'Platlist of the day'",
              style: TextStyle(color: Colors.white, fontSize: 18),
            )),
          ],
        )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline,
              color: Colors.white,
              size: 25,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 25,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 55, 15, 124),
              const Color.fromARGB(193, 13, 1, 34),
            ],
            end: Alignment.topCenter,
            begin: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
