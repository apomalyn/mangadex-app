import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final bool isInteractionLimited;

  const Loading({super.key, this.isInteractionLimited = true});

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      if (isInteractionLimited)
        const Opacity(
          opacity: 0.5,
          child: ModalBarrier(dismissible: false, color: Colors.grey),
        ),
      const Center(child: CircularProgressIndicator())
    ],
  );
}