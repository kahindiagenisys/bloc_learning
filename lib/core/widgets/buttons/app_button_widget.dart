import 'package:flutter/material.dart';
import 'package:health_booster/core/extensions/build_context_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

class AppButtonWidget extends StatefulWidget {
  const AppButtonWidget({
    this.childAlignment = Alignment.center,
    this.backgroundColor,
    this.showBackground = true,
    this.enableScaleAnimation,
    this.borderRadius = 8,
    this.enabled = true,
    this.height = 50,
    this.textStyle,
    this.textColor,
    this.padding,
    this.margin,
    this.onTap,
    this.child,
    this.text,
    super.key,
    this.width,
    this.isLoading = false,
    this.border,
  });

  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry childAlignment;
  final bool? enableScaleAnimation;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final bool showBackground;
  final double borderRadius;
  final Function()? onTap;
  final Color? textColor;
  final Widget? child;
  final double height;
  final double? width;
  final BoxBorder? border;
  final bool enabled;
  final bool isLoading;
  final String? text;

  @override
  State<AppButtonWidget> createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget>
    with SingleTickerProviderStateMixin {
  double _scale = 1.0;
  AnimationController? _controller;

  late Color textColor;

  @override
  void initState() {
    initAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.backgroundColor ?? context.colorScheme.primary;
    if (_controller != null && widget.enabled) {
      _scale = 1 - _controller!.value;
    }
    final bool isOnTapAvailable = widget.enabled && !widget.isLoading;
    if (isOnTapAvailable &&
        widget.enableScaleAnimation
            .validate(value: enableAppButtonScaleAnimationGlobal)) {
      return Listener(
        onPointerDown: (details) {
          _controller?.forward();
        },
        onPointerUp: (details) {
          _controller?.reverse();
        },
        child: Transform.scale(
          scale: _scale,
          child: buildButton(backgroundColor),
        ),
      );
    } else {
      return buildButton(backgroundColor);
    }
  }

  Widget buildButton(Color backgroundColor) {
    final bool isOnTapAvailable = widget.enabled && !widget.isLoading;
    textColor = widget.textColor ??
        (widget.showBackground
            ? context.colorScheme.onPrimary
            : context.colorScheme.primary);
    return Padding(
      padding: widget.margin ??
          const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 2,
          ),
      child: GestureDetector(
        onTap: isOnTapAvailable ? widget.onTap : null,
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.showBackground ? backgroundColor : null,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: widget.border,
          ),
          child: Align(
            alignment: widget.childAlignment,
            child: Padding(
              padding: buttonPadding(),
              child: centerWidgetBuild(),
            ),
          ),
        ),
      ),
    );
  }

  Widget centerWidgetBuild() {
    if (widget.isLoading) {
      return const CircularProgressIndicator(
        color: Colors.white,
        strokeAlign: -3,
      );
    }
    return widget.child ??
        Text(
          widget.text.validate(),
          style: widget.textStyle ?? boldTextStyle(color: textColor),
        );
  }

  EdgeInsetsGeometry buttonPadding() {
    if (widget.child == null && widget.text == null) {
      return EdgeInsets.zero;
    }

    return widget.padding ??
        const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  }

  void initAnimation() {
    if (widget.enableScaleAnimation
        .validate(value: enableAppButtonScaleAnimationGlobal)) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: appButtonScaleAnimationDurationGlobal ?? 50,
        ),
        lowerBound: 0.0,
        upperBound: 0.1,
      )..addListener(() {
          setState(() {});
        });
    }
  }
}
