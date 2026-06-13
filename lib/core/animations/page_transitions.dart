import 'package:flutter/material.dart';
import 'animation_durations.dart';
import 'animation_curves.dart';

class PageTransitions {
  PageTransitions._();

  // Slide from right (default)
  static Route slideFromRight(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AnimationDurations.pageTransition,
      reverseTransitionDuration: AnimationDurations.pageTransition,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: AnimationCurves.spring));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }

  // Slide from bottom (for detail screens)
  static Route slideFromBottom(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AnimationDurations.pageTransition,
      reverseTransitionDuration: AnimationDurations.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: AnimationCurves.silk));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  // Fade + Scale (for splash, onboarding)
  static Route fadeScale(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AnimationDurations.dramatic,
      reverseTransitionDuration: AnimationDurations.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: AnimationCurves.smooth));
        final scaleTween = Tween<double>(begin: 0.92, end: 1.0)
            .chain(CurveTween(curve: AnimationCurves.spring));
        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: ScaleTransition(
            scale: animation.drive(scaleTween),
            child: child,
          ),
        );
      },
    );
  }

  // Fade only (subtle)
  static Route fadeOnly(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AnimationDurations.medium,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation.drive(
            Tween<double>(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: AnimationCurves.standard)),
          ),
          child: child,
        );
      },
    );
  }

  // Slide + Fade combined (premium feel)
  static Route slideFade(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionDuration: AnimationDurations.pageTransition,
      reverseTransitionDuration: AnimationDurations.normal,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideTween = Tween(
          begin: const Offset(0.05, 0.0),
          end: Offset.zero,
        ).chain(CurveTween(curve: AnimationCurves.snap));
        final fadeTween = Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: AnimationCurves.enter));
        return SlideTransition(
          position: animation.drive(slideTween),
          child: FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          ),
        );
      },
    );
  }
}
