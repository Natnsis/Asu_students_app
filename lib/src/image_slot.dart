import 'package:flutter/material.dart';
import 'theme.dart';

/// Flutter stand-in for the design's `<image-slot>` web component — a
/// user-fillable image placeholder. Here it renders as a labelled tinted box.
class ImageSlot extends StatelessWidget {
  const ImageSlot({
    super.key,
    this.width,
    this.height,
    this.radius = 12,
    this.circle = false,
    this.tint,
    this.label = 'Image',
  });

  final double? width;
  final double? height;
  final double radius;
  final bool circle;
  final Color? tint;
  final String label;

  @override
  Widget build(BuildContext context) {
    final shape = circle
        ? BoxDecoration(color: tint ?? const Color(0xFFE7EFE0), shape: BoxShape.circle)
        : BoxDecoration(
            color: tint ?? const Color(0xFFE7EFE0),
            borderRadius: BorderRadius.circular(radius),
          );
    return Container(
      width: width,
      height: height,
      decoration: shape.copyWith(
        border: Border.all(color: const Color(0x221B231F)),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.image_outlined, size: 18, color: kMuted),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: body(10, color: kMuted, weight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
