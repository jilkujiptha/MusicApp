import 'package:flutter/material.dart';

class ShowBottomSheet extends StatefulWidget {
  const ShowBottomSheet({super.key});

  @override
  State<ShowBottomSheet> createState() => _ShowBottomSheetState();
}

class _ShowBottomSheetState extends State<ShowBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: const Color.fromARGB(255, 40, 6, 97),
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Text(
            "Kesariya ('From Brahmastra')",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Text(
            "Arijith singh,Amithabh bhattacharya",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
    );
  }
}
