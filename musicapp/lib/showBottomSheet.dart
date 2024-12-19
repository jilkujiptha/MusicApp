import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musicapp/changeNotifier.dart';
import 'package:provider/provider.dart';

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({super.key});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  // String? _page;
  @override
  Widget build(BuildContext context) {
    // _page = ModalRoute.of(context)!.settings.arguments as String;
    return Consumer<musicProvider>(
        builder: (context, music, child) => Container(
              color: const Color.fromARGB(255, 40, 6, 97),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    music.bottom.split("/").last.split("-").first,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    music.bottom.split("/").last.split("-").last.substring(0,
                        music.bottom.split("/").last.split("-").last.length - 4),
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Add to Liked Songs",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Colors.white,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Add to Playlist",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle_outlined,
                        color: Colors.white,
                      ),
                      TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, "album",arguments: _page);
                          },
                          child: Text(
                            "View Album",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "View Artist",
                            style: TextStyle(color: Colors.white),
                          )),
                    ],
                  ),
                ],
              ),
            ));
  }
}
