import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video/controllers/splash_video_ctr.dart';
import 'package:video/views/splash_dfault.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = '/SplashPage';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    print('splash Screen initState');
    controller = SplashVideoCtr.controller;
    controller.initialize().then(
      (_) {
        controller.setVolume(0.0);
        controller.setLooping(true);
        controller.play();
        print('컨트롤러 이니셜라이즈 확인 : ${controller.value.isInitialized}');
        print('듀레이션 : ${controller.value.duration.inMilliseconds}');
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('파일 존재 여부 ${SplashVideoCtr.file.existsSync()}');
    print('splash Screen build');
    return SplashVideoCtr.file.existsSync()
        ? Scaffold(
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
          )
        : SplashDfault();
  }

  // @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
