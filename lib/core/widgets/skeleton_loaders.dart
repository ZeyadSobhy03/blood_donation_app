import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Collection of reusable skeleton loaders for common UI patterns

/// Skeleton loader for list tiles
class SkeletonListTile extends StatelessWidget {
  final double height;
  final EdgeInsets padding;

  const SkeletonListTile({
    super.key,
    this.height = 80,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            SizedBox(width: 12),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 14.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    height: 12.h,
                    width: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

/// Skeleton loader for cards
class SkeletonCard extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsets padding;
  final BorderRadius borderRadius;

  const SkeletonCard({
    super.key,
    this.height = 200,
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(16),
    BorderRadius? borderRadius,
  }) : borderRadius = borderRadius ?? const BorderRadius.all(Radius.circular(12));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

/// Skeleton loader for header/stats
class SkeletonHeader extends StatelessWidget {
  final double height;
  final EdgeInsets padding;

  const SkeletonHeader({
    super.key,
    this.height = 100,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 24.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            height: 20.h,
            width: 100.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 16.h,
            width: 200.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

/// Skeleton loader for a grid of items
class SkeletonGridItem extends StatelessWidget {
  final double size;
  final EdgeInsets padding;

  const SkeletonGridItem({
    super.key,
    this.size = 150,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

/// Skeleton loader for circular avatar
class SkeletonCircleAvatar extends StatelessWidget {
  final double radius;
  final EdgeInsets padding;

  const SkeletonCircleAvatar({
    super.key,
    this.radius = 24,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

/// Skeleton loader for text lines
class SkeletonTextLine extends StatelessWidget {
  final double height;
  final double? width;
  final EdgeInsets padding;

  const SkeletonTextLine({
    super.key,
    this.height = 14,
    this.width,
    this.padding = const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        height: height.h,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

/// Wrapper for enabling/disabling skeletonizer on any widget
class SkeletonizerWrapper extends StatelessWidget {
  final bool enabled;
  final Widget child;
  final Widget loadingChild;

  const SkeletonizerWrapper({
    super.key,
    required this.enabled,
    required this.child,
    required this.loadingChild,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      child: enabled ? loadingChild : child,
    );
  }
}

