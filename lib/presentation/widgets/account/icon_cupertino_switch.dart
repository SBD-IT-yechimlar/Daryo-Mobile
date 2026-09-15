import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';

class IconCupertinoSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const IconCupertinoSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<IconCupertinoSwitch> createState() => _IconCupertinoSwitchState();
}

class _IconCupertinoSwitchState extends State<IconCupertinoSwitch> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 60,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.value ? Colors.blue : Colors.grey.shade300,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: widget.value
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Assets.images.icAccountSwitchIconSun.svg(),
                      ),
              ),
              !widget.value
                  ? Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Assets.images.icAccountSwitchMoon.svg(height: 12, width: 12),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      ),
    );
  }
}
