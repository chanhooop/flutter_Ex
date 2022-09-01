import 'package:flutter/material.dart';
import 'package:video/controllers/is_first_load.dart';
import 'package:video/controllers/splash_video_ctr.dart';

class MainViewPage extends StatelessWidget {
  const MainViewPage({Key? key}) : super(key: key);
  static const routeName = '/MainViewPage';

  @override
  Widget build(BuildContext context) {
    // 리모트 컨피그와 현재 Url 비교 reload
    SplashVideoCtr().reloadSplashVideo();

    SplashVideoCtr splashVideoCtr = SplashVideoCtr();
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                print('버튼클릭');
                splashVideoCtr.downLoadFile();
              },
              child: Text('다운로드'),
            ),
            ElevatedButton(
              onPressed: () {
                splashVideoCtr.checkStorage();
              },
              child: Text('스토리지 확인'),
            ),
            ElevatedButton(
              onPressed: () async {
                await IsFirstLoad().reset();
                await IsFirstLoad().deleteSplashVideo();
                print(SplashVideoCtr.file.existsSync());
              },
              child: Text('최초시작 으로 만들기'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('테스트'),
            ),
          ],
        ),
      ),
    );
  }
}
