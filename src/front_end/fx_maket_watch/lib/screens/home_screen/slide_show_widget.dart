import 'package:flutter/material.dart';

class SlideShow extends StatelessWidget {
  const SlideShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg_2.jpeg"), fit: BoxFit.cover),
      ),
      child: const Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            "Best Free Price Alert server you can trust \n Wide Range of Alert Medium Available.",
            style: TextStyle(fontSize: 38.0, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
