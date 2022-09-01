import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashDfault extends StatefulWidget {
  const SplashDfault({Key? key}) : super(key: key);

  @override
  State<SplashDfault> createState() => _SplashDfaultState();
}

class _SplashDfaultState extends State<SplashDfault> {
  late VideoPlayerController controller;

  @override
  void initState() {
    print('splash Screen initState');
    controller = VideoPlayerController.asset('assets/splashVideo.mp4');
    controller.initialize().then(
      (_) {
        controller.setVolume(0.0);
        controller.setLooping(true);
        controller.play();
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 500,
        width: 250,
        child: Center(
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}
