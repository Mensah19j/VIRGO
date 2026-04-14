import 'package:flutter/material.dart';
import 'package:virgo/core/utils/theme_extensions.dart';

class AnimatedAvatar extends StatefulWidget {
  final String name;
  final double radius;
  final bool animate;

  const AnimatedAvatar({
    super.key,
    required this.name,
    this.radius = 24.0,
    this.animate = false,
  });

  @override
  State<AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<AnimatedAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    if (widget.animate) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant AnimatedAvatar oldWidget) {
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get _initials {
    if (widget.name.isEmpty) return '?';
    final parts = widget.name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return widget.name[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(
      width: widget.radius * 2,
      height: widget.radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            context.appColors.wineLight,
            context.appColors.wine,
          ],
        ),
        boxShadow: widget.animate
            ? [
                BoxShadow(
                  color: context.appColors.wine.withValues(alpha: 0.4),
                  blurRadius: 16,
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Center(
        child: Text(
          _initials,
          style: TextStyle(
            color: context.colorScheme.onPrimary,
            fontSize: widget.radius * 0.8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    if (widget.animate) {
      return AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: avatar,
      );
    }

    return avatar;
  }
}

