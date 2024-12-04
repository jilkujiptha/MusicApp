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
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(193, 38, 13, 80),
                boxShadow: [
                  BoxShadow(blurRadius: 5, color: Colors.black),
                ],
              ),
              child: Image.asset(
                "./Image/images.jpeg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Kesariya",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    Text(
                      "Arijith Singh",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    )
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        "./Image/share.png",
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              height: 10,
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
            )
          ],
        ),
      ),
    );
  }
}
