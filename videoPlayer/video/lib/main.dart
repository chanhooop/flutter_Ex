import 'package:flutter/material.dart';
import 'package:video/app/my_app.dart';
import 'package:video/controllers/is_first_load.dart';

void main() async {
  final bool isFirstCall;
  WidgetsFlutterBinding.ensureInitialized(); // 위젯 실행전 await 모두 실행시키고 실행
  IsFirstLoad isFirstLoad = IsFirstLoad();
  isFirstCall =
      await isFirstLoad.isFirstCallMethod(); // 앱이 최초 실행인지 확인, 최초실행시 true반환
  print('isFirstCall : $isFirstCall');
  if (isFirstCall) {
    await isFirstLoad.downLoadVideo(); // 최초 앱실행 : 영상 다운로드
  }
  await isFirstLoad.installSplashVideo(); // 기존 앱실행 : 기존 영상 파일 불러오기

  runApp(const MyApp());
}
