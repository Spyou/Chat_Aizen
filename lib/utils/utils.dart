import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils {
  static void flushBarMessage(String message, IconData icon, Color color,
      Color color1, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: color,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(
          icon,
          size: 22,
          color: color1,
        ),
      )..show(context),
    );
  }
}
