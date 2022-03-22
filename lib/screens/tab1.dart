import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'list/menuFood.dart';
import 'list/detailsScreen.dart';
import 'background/home_page_background.dart';

import 'package:wallpaper/wallpaper.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system = "System";

  Stream<String>? progressString;
  String? res;
  bool downloading = false;
  bool imageGalrys = false;

  List<String> images = [
    "https://images.pexels.com/photos/10069890/pexels-photo-10069890.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/7037125/pexels-photo-7037125.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/8803905/pexels-photo-8803905.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/9556451/pexels-photo-9556451.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/10050591/pexels-photo-10050591.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/9000160/pexels-photo-9000160.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/9676202/pexels-photo-9676202.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://images.pexels.com/photos/9308054/pexels-photo-9308054.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
  ];
  var result = "Waiting to set wallpaper";
  bool _isDisable = true;

  int nextImageID = 0;

  dynamic detal = locations;
  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: <Widget>[
              HomePageBackground(
                screenHeight: MediaQuery.of(context).size.height,
                key: const Key('backgkkround'),
              ),
              ListView.builder(
                  itemCount: detal.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 5, right: 5, top: 20),
                      child: Card(
                          child: Column(children: <Widget>[
                        GestureDetector(
                            onTap: () => {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              imageGalry(index: index))),
                                },
                            child: SizedBox(
                                height: 200,
                                child: Stack(children: <Widget>[
                                  Hero(
                                    tag: detal[index].id,
                                    child: Image.network(detal[index].url,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 120,
                                        fit: BoxFit.cover),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 120),
                                      child: ListTile(
                                        title: Text(detal[index].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                        subtitle:
                                            Text(detal[index].description),
                                      )),
                                ])))
                      ])),
                    );
                  }),
            ])));
  }

  Future<void> dowloadImage(BuildContext context) async {
    progressString = Wallpaper.imageDownloadProgress(images[nextImageID]);
    progressString?.listen((data) {
      setState(() {
        res = data;
        downloading = true;
      });
      print("DataReceived: " + data);
    }, onDone: () async {
      setState(() {
        downloading = false;

        _isDisable = false;
      });
      print("Task Done");
    }, onError: (error) {
      setState(() {
        downloading = false;
        _isDisable = true;
      });
      print("Some Error");
    });
  }

  Widget imageDownloadDialog() {
    return Container(
      height: 120.0,
      width: 200.0,
      child: Card(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 20.0),
            Text(
              "Downloading File : $res",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget imageGalry({required int index}) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(detal[index].title),
      ),
      body: Container(
          margin: const EdgeInsets.only(top: 20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                downloading
                    ? imageDownloadDialog()
                    : Hero(
                        tag: detal[index].id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            detal[index].url,
                            fit: BoxFit.fill,
                          ),
                        )),

                // ElevatedButton(
                //   onPressed: () async {
                //     setState(() {
                //       nextImageID = Random().nextInt(images.length);
                //       _isDisable = true;
                //     });
                //   },
                //   child:
                //    const Text("Get Random Image"),
                // ),
                ElevatedButton(
                  onPressed: () async {
                    return await dowloadImage(context);
                  },
                  child: const Text("please download the image"),
                ),
                ElevatedButton(
                  onPressed: _isDisable
                      ? null
                      : () async {
                          var width = MediaQuery.of(context).size.width;
                          var height = MediaQuery.of(context).size.height;
                          home = await Wallpaper.homeScreen(
                              options: RequestSizeOptions.RESIZE_FIT,
                              width: width,
                              height: height);
                          setState(() {
                            downloading = false;
                            home = home;
                          });
                          print("Task Done");
                        },
                  child: Text(home),
                ),
                ElevatedButton(
                  onPressed: _isDisable
                      ? null
                      : () async {
                          lock = await Wallpaper.lockScreen();
                          setState(() {
                            downloading = false;
                            lock = lock;
                          });
                          print("Task Done");
                        },
                  child: Text(lock),
                ),
                ElevatedButton(
                  onPressed: _isDisable
                      ? null
                      : () async {
                          both = await Wallpaper.bothScreen();
                          setState(() {
                            downloading = false;
                            both = both;
                          });
                          print("Task Done");
                        },
                  child: Text(both),
                ),
                ElevatedButton(
                  onPressed: _isDisable
                      ? null
                      : () async {
                          system = await Wallpaper.systemScreen();
                          setState(() {
                            downloading = false;
                            system = system;
                          });
                          print("Task Done");
                        },
                  child: Text(system),
                ),
              ],
            ),
          )),
    );
  }
}
