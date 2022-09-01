import 'package:flutter/material.dart';
import 'package:video/controllers/splash_video_ctr.dart';
import 'package:video/views/main_view_page.dart';
import 'package:video/views/splash_page.dart';

class PreStart extends StatefulWidget {
  const PreStart({Key? key}) : super(key: key);
  static const routeName = '/PreStart';

  @override
  State<PreStart> createState() => _PreStartState();
}

class _PreStartState extends State<PreStart> {
  SplashVideoCtr splashVideoCtr = SplashVideoCtr();
  late Future<bool> check;

  @override
  void initState() {
    print('prescreeen 이닛');
    splashVideoCtr.splashVideoController();
    check = splashVideoCtr.checkDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('prescreeen 빌드');
    return FutureBuilder(
      future: check,
      builder: (context, snapshot) {
        print(snapshot.data.toString());
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data.toString());
          return Scaffold(
            body: Center(
                child: ElevatedButton(
              child: Text('로그인창'),
              onPressed: () {
                Navigator.pushNamed(context, MainViewPage.routeName);
              },
            )),
          );
        } else {
          return SplashPage();
        }
      },
    );
  }
}
