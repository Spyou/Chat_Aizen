import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:chat_ai/views/home_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => {
              Navigator.of(context).popUntil((route) => route.isFirst),
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage())),
            });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: content(),
    );
  }

  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/splash.jpeg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
