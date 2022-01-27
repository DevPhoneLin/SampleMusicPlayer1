import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sample_music_player_1/res/app_colors.dart' as AppColors;
import 'package:sample_music_player_1/ui/widgets/audio_file.dart';

class MusicDetailPage extends StatefulWidget {
  const MusicDetailPage({Key? key}) : super(key: key);

  @override
  _MusicState createState() => _MusicState();
}

class _MusicState extends State<MusicDetailPage> {

  late AudioPlayer audioPlayer;

  @override
  void initState(){
    super.initState();
    audioPlayer  = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(
                color: AppColors.audioBlueBackground,
              )),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {},
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ],
              )),
          Positioned(
              left: 4,
              right: 4,
              top: screenHeight * 0.2,
              height: screenHeight * 0.36,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Text(
                      "The Water",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Avenir"),
                    ),
                    Text(
                      "Martin Hyatt",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),

                    AudioFile(audioPlayer: audioPlayer,)

                  ],
                ),
              )),
          Positioned(
              height: screenHeight * 0.16,
              top: screenHeight * 0.12,
              left: (screenWidth - 130) / 2,
              right: (screenWidth - 130) / 2,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.audioGreyBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 5),
                        image: DecorationImage(
                            image: AssetImage("assets/images/pic-1.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
