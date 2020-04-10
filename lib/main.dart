// https://github.com/miguelpruivo/flutter_file_picker/wiki/api#filepickergetfilepath  File Picker
// https://pub.dev/packages/audioplayers                                               AudioPlayer

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
          Radio(),
          Music(),
        ]),
      )
      ),
    );
  }
  
}

class Radio extends StatefulWidget {
  @override
  RadioState createState() => new RadioState();
}

class RadioState extends State<Radio> {
  //AudioPlayer audioPlayer = AudioPlayer();
  btnfn()   {if (result1 == 0) play();
  else pause();
  }
  play() async {
    pause();
    int rslt = await audioPlayer.play('https://streaming.radio.co/s8c7294f48/listen');
    if (rslt == 1) {
      setState(() {
        result1 = 1;
        playback1 = "Pause";
        picon1 = Icon(Icons.pause);
        result =0;
        playback = "Browse and Play";
        picon = Icon(Icons.play_circle_outline);
      });
    }
  }
  pause() async {
    int rslt = await audioPlayer.pause();
    if (rslt == 1)  {
      setState(() {
      result1 =0;
      playback1 = "Play CETalks";
      picon1 = Icon(Icons.play_arrow);  
      });
      }
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          child: RaisedButton.icon(onPressed: btnfn, icon: picon1, label: Text(playback1)),
        )
      ]
    );
  }
  
}

class Music extends StatefulWidget {
  @override 
  MusicState createState() => new MusicState();
}

class MusicState extends State<Music> {
 // AudioPlayer audioPlayer = AudioPlayer();
  String path = 'default';
  var playpause = 0;
  btnfn()   {if (result == 0) browse();
  else stop();
  }
  browse() async {
    String filePath;
    filePath = await FilePicker.getFilePath(type: FileType.audio);
    path = filePath;
    play();
  }
  play() async {
    stop();
    int rslt = await audioPlayer.play(path, isLocal: true);
    if (rslt == 1) {
      setState(() {
        result = 1;
        playback = "Stop";
        picon = Icon(Icons.stop);
        result1 =0;
        playback1 = "Play CETalks";
        picon1 = Icon(Icons.play_arrow);
      });
    }
    completion();
  }
  stop() async {
    int rslt = await audioPlayer.stop();
    if (rslt == 1)  {
      setState(() {
      result =0;
      playback = "Browse and Play";
      picon = Icon(Icons.play_circle_outline);  
      });
      }
   
  }


  completion() async {
    audioPlayer.onPlayerCompletion.listen((event) {
    stop();
  });
  
  }
  pause() async{
    if (playpause == 0) { await audioPlayer.pause(); playpause = 1; }
    else                { await audioPlayer.resume(); playpause = 0; completion(); }
    
    }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
         Container(
           child: RaisedButton.icon(onPressed: btnfn, icon: picon, label: Text(playback)),
           ),
           Container(
             child: RaisedButton.icon(onPressed: pause, icon: Icon(Icons.pause_circle_filled), label: Text("")),
           ),
      ]
    );
  }
  
}























