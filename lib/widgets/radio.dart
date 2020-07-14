import 'package:flutter/material.dart';

import '../main.dart';

class RadioPlayer extends StatefulWidget {
  @override
  RadioPlayerState createState() => new RadioPlayerState();
}

class RadioPlayerState extends State<RadioPlayer> {
  btnfn()   {if (result1 == 0) play();
  else pause();
  }
  play() async {
    pause();
    int rslt= await audioPlayer.play('https://s4.radio.co/sa825e656c/listen'); 
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