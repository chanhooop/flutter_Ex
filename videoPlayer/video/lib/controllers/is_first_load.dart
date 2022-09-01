import 'package:shared_preferences/shared_preferences.dart';
import 'package:video/controllers/splash_video_ctr.dart';

class IsFirstLoad extends SplashVideoCtr {
// 최초 앱시동 확인 메서드
  Future<bool> isFirstCallMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstCall;
    try {
      firstCall = prefs.getBool('firstStart') ?? true;
    } on Exception {
      firstCall = true;
    }
    await prefs.setBool('firstStart', false);

    return firstCall;
  }

// 최초 앱시동 리셋 메서드
  Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstStart', true);
    prefs.setBool('firstStart', true);
  }
}
