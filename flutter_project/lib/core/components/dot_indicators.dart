import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

const Duration defaultDuration = Duration(milliseconds: 300);

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = mainColor,
  });

  final bool isActive;

  final Color? inActiveColor, activeColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultDuration,
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? mainColor.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
