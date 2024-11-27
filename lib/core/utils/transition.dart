import 'package:flutter/material.dart';

enum TransitionType { fade, scale, slide }

class TransitionUtil {
  static PageRouteBuilder buildPageRoute(
    Widget page,
    TransitionType transitionType,
  ) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        switch (transitionType) {
          case TransitionType.fade:
            return FadeTransition(opacity: animation, child: child);
          case TransitionType.scale:
            return ScaleTransition(scale: animation, child: child);
          case TransitionType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0), // Slide in from the right
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          default:
            return child;
        }
      },
    );
  }
}
