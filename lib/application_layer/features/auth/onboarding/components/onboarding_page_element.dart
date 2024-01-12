import 'package:flutter/material.dart';

class OnBoardingPageElement extends StatefulWidget {
  final String imagePath;
  const OnBoardingPageElement({super.key, required this.imagePath});

  @override
  State<OnBoardingPageElement> createState() => _OnBoardingPageElementState();
}

class _OnBoardingPageElementState extends State<OnBoardingPageElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(widget.imagePath), fit: BoxFit.cover)),
      child: const Center(),
    );
  }
}
