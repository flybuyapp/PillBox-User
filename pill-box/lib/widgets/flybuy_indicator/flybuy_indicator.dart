import 'package:flutter/material.dart';

import 'indicator_line.dart';

class FlybuyIndicator extends StatelessWidget {
  final double value;
  final Color? background;
  final Color? color;
  final double strokeWidth;

  const FlybuyIndicator({
    super.key,
    this.value = 1,
    this.color,
    this.background,
    this.strokeWidth = 6,
  })  : assert(value >= 0 && value <= 1),
        assert(strokeWidth > 0);

  const factory FlybuyIndicator.gradient({
    Key? key,
    double value,
    List<Color>? gradientColors,
    Color? background,
    double strokeWidth,
  }) = _FlybuyIndicatorGradient;

  const factory FlybuyIndicator.circle({
    Key? key,
    double value,
    Color? color,
    Color? background,
    double size,
    double strokeWidth,
  }) = _FlybuyIndicatorCircle;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return _ProgressIndicatorUi(
      value: value,
      buildChild: (value) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(strokeWidth / 2),
          child: SizedBox(
            height: strokeWidth,
            child: LinearProgressIndicatorGradientComponent(
              value: value,
              backgroundColor: background ?? theme.dividerColor,
              valueColors: color != null
                  ? [color!, color!]
                  : [theme.primaryColor, theme.primaryColor],
            ),
          ),
        );
      },
    );
  }
}

class _FlybuyIndicatorGradient extends FlybuyIndicator {
  final List<Color>? gradientColors;

  const _FlybuyIndicatorGradient({
    Key? key,
    double value = 1,
    Color? background,
    double strokeWidth = 5,
    this.gradientColors,
  })  : assert(value >= 0 && value <= 1),
        assert(strokeWidth > 0),
        super(
          key: key,
          value: value,
          background: background,
          strokeWidth: strokeWidth,
        );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return _ProgressIndicatorUi(
      value: value,
      buildChild: (value) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(strokeWidth / 2),
          child: SizedBox(
            height: strokeWidth,
            child: LinearProgressIndicatorGradientComponent(
              value: value,
              backgroundColor: background ?? theme.dividerColor,
              valueColors: gradientColors ??
                  [
                    theme.primaryColor,
                    theme.primaryColor.withOpacity(0.2),
                  ],
            ),
          ),
        );
      },
    );
  }
}

class _FlybuyIndicatorCircle extends FlybuyIndicator {
  final double size;

  const _FlybuyIndicatorCircle({
    Key? key,
    double value = 1,
    Color? background,
    Color? color,
    double strokeWidth = 5,
    this.size = 72,
  })  : assert(value >= 0 && value <= 1),
        assert(strokeWidth > 0),
        assert(size > strokeWidth),
        super(
          key: key,
          value: value,
          background: background,
          color: color,
          strokeWidth: strokeWidth,
        );

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return _ProgressIndicatorUi(
      value: value,
      buildChild: (value) {
        return SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            value: value,
            backgroundColor: background ?? theme.dividerColor,
            color: color ?? theme.primaryColor,
            strokeWidth: strokeWidth,
          ),
        );
      },
    );
  }
}

class _ProgressIndicatorUi extends StatefulWidget {
  final double value;
  final Widget Function(double value) buildChild;
  const _ProgressIndicatorUi({
    Key? key,
    required this.buildChild,
    this.value = 1,
  })  : assert(value >= 0 && value <= 1),
        super(key: key);

  @override
  State<_ProgressIndicatorUi> createState() => _IndicatorState();
}

class _IndicatorState extends State<_ProgressIndicatorUi> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.buildChild(widget.value);
  }
}
