import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final ShapeBorder? shape;
  final BorderRadiusGeometry? borderRadius;
  final Clip clipBehavior;
  final EdgeInsetsGeometry margin;
  final bool semanticContainer;
  final LinearGradient? gradient;
  final Widget? child;
  final Color? color;
  final double? elevation;
  final Color? shadowColor;
  final List<BoxShadow>? boxShadow;

  const CustomCard({
    Key? key,
    this.color,
    this.shape,
    this.borderRadius,
    this.margin = const EdgeInsets.all(4),
    this.clipBehavior = Clip.none,
    this.gradient,
    this.child,
    this.elevation,
    this.shadowColor,
    this.boxShadow,
    this.semanticContainer = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: semanticContainer,
      explicitChildNodes: !semanticContainer,
      child: Material(
        type: MaterialType.card,
        color: Colors.transparent,
        shadowColor: shadowColor ?? Colors.transparent,
        borderOnForeground: false,
        elevation: elevation ?? 0,
        clipBehavior: clipBehavior,
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(10),
            boxShadow: boxShadow,
            color: color,
            gradient: gradient,
          ),
          child: child,
        ),
      ),
    );
  }
}
