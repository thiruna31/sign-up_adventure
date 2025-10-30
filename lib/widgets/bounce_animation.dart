import 'package:flutter/material.dart';

class BounceWidget extends StatefulWidget {
  final Widget child;
  final bool bounce;
  const BounceWidget({super.key, required this.child, required this.bounce});

  @override
  State<BounceWidget> createState() => _BounceWidgetState();
}

class _BounceWidgetState extends State<BounceWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 350), vsync: this);
    _scale = Tween<double>(begin: 1, end: 1.08).chain(CurveTween(curve: Curves.elasticOut)).animate(_controller);
  }

  @override
  void didUpdateWidget(BounceWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.bounce && !oldWidget.bounce) {
      _controller.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scale,
      builder: (context, child) {
        return Transform.scale(
          scale: _scale.value,
          child: widget.child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
