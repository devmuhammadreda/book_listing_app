// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/colors_manager.dart';

class MainShimmerWidget extends StatelessWidget {
  const MainShimmerWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: ColorsManager.primary.withValues(alpha: .1),
      child: child,
    );
  }
}
