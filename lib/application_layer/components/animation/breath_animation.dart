import 'package:flutter/material.dart';
import 'package:kindergarden_mobile/service_layer/logger/logger.dart';

class BreathAnimation extends StatefulWidget {
  final Widget child;
  final Duration? duration;
  const BreathAnimation({super.key, required this.child, this.duration = const Duration(milliseconds: 750)});

  @override
  State<BreathAnimation> createState() => _BreathAnimationState();
}

class _BreathAnimationState extends State<BreathAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _breath = 0.0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller = AnimationController(vsync: this, duration: widget.duration);
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

      _controller.addStatusListener((status) {
        setState(() => _breath = _controller.value);
        Logger.instance.log("BreathAnimation ::: Breath value: $_breath");
      });
      _controller.forward();
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = 220.0 - 20.0 * _breath;
    return AnimatedContainer(
      duration: widget.duration!,
      width: size,
      height: size,
      child: widget.child,
    );
  }
}
