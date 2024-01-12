import 'package:flutter/material.dart';

class CustomScroll extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, child, details) {
    return child;
  }
}
