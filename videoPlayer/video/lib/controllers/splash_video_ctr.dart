import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class SplashVideoCtr {
  final prefs = SharedPreferences.getInstance();

  // 추후 url은 remoteconfig 에서 받아아오기
  static String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  static String videoUrl2 =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';
  static late VideoPlayerController controller;
  static late String? curentUrl;
  static late String filePath;
  static late File file;
  static late int sec;

  // 새로운 영상이 들어왔을 경우 처리
  reloadSplashVideo() async {
    late String currentUrl;
    print('reloadSplashVideo 시작');
    SharedPreferences pref = await prefs;
    currentUrl = pref.getString('splashUrl')!;
    // 리모트 컨피그 가져오기(Ex)
    videoUrl = videoUrl;
    if (videoUrl != currentUrl) {
      // 새로운 영상 다운 -> sharedPref 재설정 -> 기존 영상 삭제
      print('if문 진행');
      await deleteSplashVideo();
      await downLoadVideo();
    }
    print('그대로 진행');
  }

  // 비디오 url을 받아서 다운로드 영상 다운로드
  downLoadVideo() async {
    // 리모트 컨피그 가져오기
    // videoUrl = remoteconfig ~~~
    final _storage = await getApplicationDocumentsDirectory();
    final SharedPreferences sharedPreferences = await prefs;
    filePath = '${_storage.path}/$videoUrl';
    try {
      print('동영상 다운로드');
      print('$videoUrl');
      await Dio().download(
        videoUrl,
        filePath,
      );
      file = File(filePath);
      print('파일 확인 : ${file.existsSync()}');
      sharedPreferences.setString('splashUrl', videoUrl);
    } catch (e) {
      // 동영상 다운이 오류일 때 처리
      print('영상다운 에러, 파일존재여부 : ${file.existsSync()}');
    }
  }

  // 다운로드 된 기존 영상 파일 가져오기
  installSplashVideo() async {
    print('파일 가져오기');
    final _storage = await getApplicationDocumentsDirectory();
    final SharedPreferences sharedPreferences = await prefs;
    String? _videoUrl = sharedPreferences.getString('splashUrl');
    print(_videoUrl);
    filePath = '${_storage.path}/$_videoUrl';
    file = File(filePath);
  }

  deleteSplashVideo() async {
    print('deleteSplashVideo');
    final SharedPreferences sharedPreferences = await prefs;
    try {
      await File(filePath).delete();
      sharedPreferences.setString('splashUrl', '/splashEmpty');
      print('파일삭제됨');
    } catch (e) {
      print('파일 이미 삭제됨');
    }
  }

  // 스플레쉬 비디오컨트롤러 불러오기
  splashVideoController() {
    controller = VideoPlayerController.file(
      file,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
  }

  // 딜레이 시키는 부분 나중에 영상 재생후 화면전환으로
  Future<bool> checkDelay() async {
    final videoInfo = FlutterVideoInfo();
    if (file.existsSync()) {
      VideoPlayerController _controller = VideoPlayerController.file(file);
      await _controller.initialize();
      sec = _controller.value.duration.inMilliseconds;
      //sec = 1212121;
      print('checkDelay : $sec');
      await Future.delayed(Duration(milliseconds: sec));
      return true;
    } else {
      await Future.delayed(Duration(milliseconds: 4000));
      return true;
    }
  }

  Future downLoadFile() async {
    late final file;
    file = await Dio().download(
      videoUrl,
      filePath,
    );
    print((File(file).path).toString());
    print('다운로드 완료');
  }

  Future checkStorage() async {
    bool _exist = await file.exists();
    if (_exist) {
      OpenFile.open(file.path);
      print(file.path);
    } else {
      print('파일이 없습니다');
    }
  }

  Future deleteStorage() async {
    await file.delete();
    print(file.existsSync());
    print('삭제 완료');
  }

  Future compareStorage() async {
    bool _exist = await file.exists();
    if (_exist) {
      print('true');
      print(file.path);
    } else {
      print('false');
      // await downLoadFile();
      print(file.path);
    }
  }
}
