import 'package:flutter/material.dart';

class NotificationBadege extends StatelessWidget {
  // also take a total notification value
  final int totalNotification;
  const NotificationBadege({Key? key, required this.totalNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _totalNotification = totalNotification.toString();
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            _totalNotification,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
