// https://github.com/miguelpruivo/flutter_file_picker/wiki/api#filepickergetfilepath  File Picker
// https://pub.dev/packages/audioplayers                                               AudioPlayer

import 'package:audioplayers/audioplayers.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'widgets/music.dart';
import 'widgets/radio.dart';


void main() => runApp(MyApp());

AudioPlayer audioPlayer = AudioPlayer();
String playback = "Browse and Play";
Icon picon = Icon(Icons.play_circle_outline);
String playback1 = "Play CETalks";
Icon picon1 = Icon(Icons.play_arrow);
var result1 = 0;
var result = 0;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     title: "MediaPlayer",
     home: DefaultTabController(length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: Text("MediaPlayer"),
          bottom: TabBar(tabs: <Widget>[
            Tab(icon: Icon(Icons.radio)),
            Tab(icon: Icon(Icons.library_music)),
          ],
          )
        ),
        body: TabBarView(children: <Widget>[
          RadioPlayer(),
          Music(),
        ]),
      )
      ),
    );
  }
  
}