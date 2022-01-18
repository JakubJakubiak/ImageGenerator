import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'list/menuFood.dart';
import 'list/detailsScreen.dart';
import 'background/home_page_background.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tab1 extends StatefulWidget {
  final String detal;
  const Tab1({Key key, this.detal = 'locations'}) : super(key: key);

  Widget _buildListItem(BuildContext context, MockBandInfo bandInfo) {
    return ListTile(
      title: Row(children: [
        Expanded(
          child: Text(
            bandInfo.name,
            style: Theme.of(context).textTheme.heanStyle,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xffdddff),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            bandInfo.votes.toString(),
            style: Theme.of(context).textTheme.headline1,
          ),
        )
      ]),
      onTap: () {
        print("tekst taki fajny");
      },
    );
  }

  // @override
  // createState() => _ChooseLocationState();
}

// class _ChooseLocationState extends State<Tab1> {
// final detal title;

@override
Widget build(BuildContext context, DocumentSnapshot document) {
  return Scaffold(
      // appBar: AppBar(
      //   title: Text(title),
      // ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('Drinking').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('Loding...');
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data.document[index]),
            );
          }));
}
// }

// class Firestore {
// }












//Vesrion Orginal no Clud
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//             height: MediaQuery.of(context).size.height,
//             child: Stack(children: <Widget>[
//               HomePageBackground(
//                 screenHeight: MediaQuery.of(context).size.height,
//               ),
//               ListView.builder(
//                   itemCount: detal.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding:
//                           const EdgeInsets.only(left: 5, right: 5, top: 20),
//                       child: Card(
//                           child: Column(children: <Widget>[
//                         GestureDetector(
//                             onTap: () => {
//                                   Navigator.push(
//                                       context,
//                                       CupertinoPageRoute(
//                                           builder: (context) => DetailsScreen(
//                                               index: index, detal: detal))),
//                                 },
//                             child: Container(
//                                 height: 200,
//                                 child: Stack(children: <Widget>[
//                                   Hero(
//                                     tag: detal[index].id,
//                                     child: Image.network(detal[index].url ?? "",
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         height: 120,
//                                         fit: BoxFit.cover),
//                                   ),
//                                   Padding(
//                                       padding: const EdgeInsets.only(top: 120),
//                                       child: ListTile(
//                                         title: Text(detal[index].title ?? "",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18)),
//                                         subtitle: Text(
//                                             detal[index].description ?? ""),
//                                       )),
//                                 ])))
//                       ])),
//                     );
//                   }),
//             ])));
//   }
// }

//Version 3
//  DocumentReference linkRef;
//   final databaseReference = FirebaseFirestore.instance;

//   void getData() {
//     databaseReference
//         .collection('Drinking')
//         .get()
//         .then((QuerySnapshot snapshot) {
//       snapshot.docs.forEach((f) => print('${f.data}}'));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('Drinking').snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           print(FirebaseFirestore);
//           return PageView.builder(
//             itemCount: snapshot.data.docs.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Column(
//                 children: <Widget>[
//                   Image.network(snapshot.data.docs.elementAt(index)['url']),
//                 ],
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

//Version2

// stream:
//     FirebaseFirestore.instance.collection('drinking').snapshots(),
// builder:
//     (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//   return Container(
//       height: MediaQuery.of(context).size.height,
//       child: Stack(children: <Widget>[
//         HomePageBackground(
//           screenHeight: MediaQuery.of(context).size.height,
//         ),
//         ListView.builder(
//             itemCount: snapshot.data.docs.length,
//             // detal.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(
//                     left: 5, right: 5, top: 20),
//                 child: Card(
//                     child: Column(children: <Widget>[
//                   GestureDetector(
//                       onTap: () => {
//                             Navigator.push(
//                                 context,
//                                 CupertinoPageRoute(
//                                     builder: (context) =>
//                                         DetailsScreen(
//                                             index: index,
//                                             detal: detal))),
//                           },
//                       child: Container(
//                           height: 200,
//                           child: Stack(children: <Widget>[
//                             Hero(
//                               tag: detal[index].id,
//                               child: Image.network(
//                                   snapshot.data.docs
//                                       .elementAt(index)['url'],
//                                   // detal[index].url ?? "",
//                                   width: MediaQuery.of(context)
//                                       .size
//                                       .width,
//                                   height: 120,
//                                   fit: BoxFit.cover),
//                             ),
//                             Padding(
//                                 padding:
//                                     const EdgeInsets.only(top: 120),
//                                 child: ListTile(
//                                   title: Text(
//                                       detal[index].title ?? "",
//                                       style: TextStyle(
//                                           fontWeight:
//                                               FontWeight.bold,
//                                           fontSize: 18)),
//                                   subtitle: Text(
//                                       detal[index].description ??
//                                           ""),
//                                 )),
//                           ]))),
//                 ])),
//               );
//             }),
//       ]));
// }));
//   }
// }

// @override
// void initState() {
//   linkRef = FirebaseFirestore.instance.collection('drinking').doc();
//   super.initState();
//   getData();
//   print(linkRef);
// }

// void getData() {
//   databaseReference
//       .collection("drinking")
//       .get()
//       .then((QuerySnapshot snapshot) {
//     snapshot.docs.forEach((f) => print('${f.data}}'));
//   });
// }

// _addItemFuntion() async {
//   await linkRef.set({
//     _addItemController.text.toString(): _addItemController.text.toString()
//   }, SetOptions(merge: true));

//   setState(() {
//     videoID.add(_addItemController.text);
//   });
//   print('added');
//   FocusScope.of(this.context).unfocus();
//   _addItemController.clear();
// }

// getData() async {
//   await linkRef
//       .get()
//       .then((value) => value.data()?.forEach((key, value) {
//             if (!videoID.contains(value)) {
//               videoID.add(value);
//             }
//           }))
//       .whenComplete(() => setState(() {
//             videoID.shuffle();
//             // showItem = true;
//           }));
// }

// }
