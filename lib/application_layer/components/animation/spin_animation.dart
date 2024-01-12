/* Spin animation widget */

import 'package:flutter/material.dart';

class SpinAnimation extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  const SpinAnimation({super.key, required this.child, this.duration = const Duration(milliseconds: 850)});

  @override
  State<SpinAnimation> createState() => _SpinAnimationState();
}

class _SpinAnimationState extends State<SpinAnimation> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      _animation = CurvedAnimation(parent: _controller!, curve: Curves.linear);
      _controller?.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller?.repeat();
        } else if (status == AnimationStatus.dismissed) {
          _controller?.forward();
        }
      });

      _controller?.addStatusListener((status) {
        setState(() {});
      });

      _controller?.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  double get _rotation {
    return _animation.value * 2 * 3.14;
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null
        ? Container()
        : RotationTransition(
            turns: _animation,
            child: widget.child,
          );
  }
}
