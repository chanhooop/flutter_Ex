import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: (){

                },
                child: Text('버튼1')),
            ElevatedButton(
                onPressed: (){

                },
                child: Text('버튼2')),
            ElevatedButton(
                onPressed: (){

                },
                child: Text('버튼2')),
          ],
        ),
      ),
    );
  }
}
