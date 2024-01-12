import 'package:flutter/material.dart';

class Fonts {
  TextStyle title = const TextStyle(
    fontSize: 17,
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  TextStyle body = const TextStyle(
    fontSize: 14,
    color: Colors.white,
  );

  TextStyle smallBody = const TextStyle(
    fontSize: 12,
    color: Colors.white,
  );

  TextStyle small = const TextStyle(
    fontSize: 10,
    color: Colors.white,
  );

  TextStyle button = const TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w600,
    letterSpacing: 2,
  );

  TextStyle huge = const TextStyle(
    fontSize: 40,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );

  TextStyle smallBodyUnderline = const TextStyle(
    decoration: TextDecoration.underline,
    fontSize: 12,
    color: Colors.white,
  );
}
