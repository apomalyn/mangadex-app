import 'package:flutter/material.dart';

class RoundedDivider extends StatefulWidget {
  final Color color;
  final double thickness;

  /// Set to null to ignore the animation
  final Duration? animationDuration;

  const RoundedDivider(
      {super.key,
      required this.color,
      required this.thickness,
      this.animationDuration});

  @override
  State<RoundedDivider> createState() => _RoundedDividerState();
}

class _RoundedDividerState extends State<RoundedDivider> with SingleTickerProviderStateMixin {
  double _progress = 0.0;
  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    if(widget.animationDuration != null) {
      _controller =
          AnimationController(duration: widget.animationDuration, vsync: this);

      _animation = Tween(begin: 0.0, end: 1.0).animate(_controller!)
        ..addListener(() {
          setState(() {
            _progress = _animation!.value;
          });
        });

      _controller?.forward();
    } else {
      _progress = 1.0;
    }
  }


  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => CustomPaint(
      painter: _RoundedDividerPainter(
          color: widget.color,
          progress: _progress,
          thickness: widget.thickness));
}

class _RoundedDividerPainter extends CustomPainter {
  late final Paint _paint;
  final Color color;

  final double _progress;

  _RoundedDividerPainter(
      {required this.color, double thickness = 4, required double progress})
      : _progress = progress {
    _paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final halfProgress = (size.width * _progress) / 2;
    final halfWidth = size.width / 2;

    canvas.drawLine(Offset(halfWidth - halfProgress, 0.0),
        Offset(halfWidth + halfProgress, 0.0), _paint);
  }

  @override
  bool shouldRepaint(_RoundedDividerPainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }
}
