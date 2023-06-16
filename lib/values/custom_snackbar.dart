import 'package:flutter/material.dart';

class CustomSnackbar{
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 10.0),
            Text(message, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}