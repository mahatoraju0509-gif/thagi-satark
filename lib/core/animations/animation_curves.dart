import 'package:flutter/material.dart';

class AnimationCurves {
  AnimationCurves._();

  // Standard
  static const Curve standard = Curves.easeInOut;
  static const Curve enter = Curves.easeOut;
  static const Curve exit = Curves.easeIn;

  // Bouncy
  static const Curve bounce = Curves.elasticOut;
  static const Curve bounceIn = Curves.elasticIn;
  static const Curve spring = Curves.fastOutSlowIn;
  static const Curve overshoot = Curves.fastLinearToSlowEaseIn;

  // Smooth
  static const Curve smooth = Curves.decelerate;
  static const Curve silk = Curves.easeInOutCubic;
  static const Curve snap = Curves.easeInOutQuart;
  static const Curve flow = Curves.easeInOutSine;

  // Dramatic
  static const Curve dramatic = Curves.easeInOutExpo;
  static const Curve explosive = Curves.easeOutBack;
  static const Curve suck = Curves.easeInBack;
  static const Curve sharp = Curves.easeInOutQuint;

  // Linear
  static const Curve linear = Curves.linear;
  static const Curve pulse = Curves.easeInOut;
}
