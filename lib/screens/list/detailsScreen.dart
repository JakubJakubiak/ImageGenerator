import 'dart:io';
import 'package:cat/screens/tab1.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../main.dart';
import '../background/home_page_background.dart';

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

import 'package:cat/screens/list/menuFood.dart';
// import 'menuDrinking.dart';

class DetailsScreen extends StatelessWidget {
  final int index;
  final dynamic detal;
  const DetailsScreen({Key? key, this.index = 0, this.detal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(detal[index].title),
        ),
        body: Stack(children: <Widget>[
          HomePageBackground(
              screenHeight: MediaQuery.of(context).size.height,
              key: const ObjectKey("background")),
          ListView(children: [
            Hero(
                tag: detal[index].id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.network(
                    detal[index].url,
                    fit: BoxFit.fill,
                  ),
                )),
            ClipRRect(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(90)),
                child: Card(
                    child: Column(children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.blueGrey, // background
                    ),
                    onPressed: () {},
                    child: Text(detal[index].description),
                  ),
                  Text('\n' + detal[index].description + '\n',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(detal[index].listDescription + '\n',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(detal[index].fullDescription + '\n',
                      style: const TextStyle(fontSize: 18, letterSpacing: 1.0)),
                ]))),
          ]),
        ]));
  }
}
