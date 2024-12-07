import 'package:flutter/material.dart';
import 'package:musicapp/showBottomSheet.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _bottomButton() {
    showModalBottomSheet(
      context: context,
      builder: (cxt) => ShowBottomSheet(),
      backgroundColor: const Color.fromARGB(255, 40, 6, 97),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          padding: EdgeInsets.all(20),
          width: double.infinity,
          height: double.infinity,
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
                    color: Colors.white, fontSize: 25, fontFamily: "Schyler"),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "WHAT YOU WANT TO HEAR TODAY?",
                style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: "Schyler"),
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
                  Container(
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
                child: TabBarView(controller: _tabController, children: [
                  Container(
                      child: Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "listen");
                            },
                            child: Container(
                                // padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(top: 15),
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                // color: Colors.black,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // SizedBox(
                                    //   height: 20,
                                    // ),
                                    Container(
                                      // padding: EdgeInsets.all(20),
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromARGB(
                                              193, 38, 13, 80)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
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
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Kesariya ('From Brahmastra')",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "Arijith singh,Amithabh bhattacharya",
                                          style: TextStyle(color: Colors.grey),
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
                        }),
                  )),
                  Container(
                    child: Center(
                      child: Text("data"),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("data"),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Text("data"),
                    ),
                  ),
                ]),
              ),
            ],
          )),
    );
  }
}
