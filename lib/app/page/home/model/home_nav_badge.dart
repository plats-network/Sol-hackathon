// Badge model for further use
import 'package:flutter/widgets.dart';

class NavBadge {
  final Color? color;
  final Color? badgeColor;
  final EdgeInsets? padding;
  final double? borderRadius;
  final String text;

  const NavBadge(
    this.text, {
    this.color,
    this.badgeColor,
    this.padding,
    this.borderRadius,
  });
}
