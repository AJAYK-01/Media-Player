import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Music extends StatefulWidget {
  @override 
  MusicState createState() => new MusicState();
}

class MusicState extends State<Music> {
  String path = 'default';
  var playpause = 0;
  var slidervalue = 0.0;
  var seekvalue = 0.0;
  var musiclen = 1.0;
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
    audioPlayer.onDurationChanged.listen((Duration dtn) {
          setState(() {
            musiclen = dtn.inMilliseconds.toDouble();
          }); 
        });
    if (rslt == 1) {
      setState(() {
        result = 1;
        playback = "Stop";
        picon = Icon(Icons.stop);
        result1 =0;
        playback1 = "Play CETalks";
        picon1 = Icon(Icons.play_arrow);
        
        audioPlayer.onAudioPositionChanged.listen((Duration pos) {
          setState(() {
            slidervalue = pos.inMilliseconds.toDouble();
          });
        });
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
           Container(
             child: musiclen != 0 ?
             Slider(value: slidervalue, min: 0.0, max: musiclen,// divisions: musiclen.round(),
                  onChanged: (double value) async {
                     setState(() async {
                       await audioPlayer.seek(Duration(milliseconds: value.round()));
                     }); 
                  }, 
            ) : Container(),
           )
      ]
    );
  }
  
}
