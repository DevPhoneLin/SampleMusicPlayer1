import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer audioPlayer;

  const AudioFile({Key? key, required this.audioPlayer}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  final String audioPath =
      "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_1MG.mp3";
  Duration _duration = new Duration();
  Duration _position = new Duration();
  bool isPlaying = false;
  bool isPause = false;
  bool isLoop = false;
  bool isRepeat = false;
  Color color = Colors.black;
  final List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    widget.audioPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.audioPlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    widget.audioPlayer.setUrl(audioPath);
    widget.audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = const Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying = true;
        } else {
          isPlaying = false;
          isRepeat = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _position.toString().split(".")[0],
                style: TextStyle(fontSize: 16),
              ),
              Text(
                _duration.toString().split(".")[0],
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        slider(),
        loadAsset(),
      ],
    ));
  }


  Widget btnStart() {
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(_icons[0], size: 50, color: Colors.blue)
          : Icon(_icons[1], size: 50, color: Colors.blue),
      onPressed: () {
        if (isPlaying == false) {
          widget.audioPlayer.play(audioPath);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          widget.audioPlayer.pause();
          setState(() {
            isPlaying = false;
          });
        }
      },
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/forward.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.audioPlayer.setPlaybackRate(playbackRate: 1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/backword.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.audioPlayer.setPlaybackRate(playbackRate: 0.5);
      },
    );
  }

  Widget btnLoop() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/loop.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('assets/images/repeat.png'),
        size: 15,
        color:color,
      ),
      onPressed: (){
        if(isRepeat==false){
          this.widget.audioPlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat=true;
            color=Colors.blue;
          });
        }else if(isRepeat==true){
          this.widget.audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
          color=Colors.black;
          isRepeat=false;
        }
      },
    );
  }

  Widget slider() {
    return Slider(
        activeColor: Colors.red,
        inactiveColor: Colors.grey,
        value: _position.inSeconds.toDouble(),
        min: 0.0,
        max: _duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            changeToSecond(value.toInt());
            value = value;
          });
        });
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.audioPlayer.seek(newDuration);
  }

  Widget loadAsset() {
    return Container(
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              btnRepeat(),
              btnSlow(),
              btnStart(),
              btnFast(),
              btnLoop()
            ]));
  }
}
