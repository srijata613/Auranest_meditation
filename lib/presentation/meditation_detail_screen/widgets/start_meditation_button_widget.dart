import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StartMeditationButtonWidget extends StatelessWidget {
  final int selectedTabIndex;
  final VoidCallback onPressed;

  const StartMeditationButtonWidget({
    Key? key,
    required this.selectedTabIndex,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String buttonText =
        selectedTabIndex == 0 ? 'Start Meditation' : 'Begin Practice';
    final IconData buttonIcon =
        selectedTabIndex == 0 ? Icons.play_arrow : Icons.self_improvement;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: ElevatedButton(
            key: ValueKey(buttonText),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 4.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: AppTheme.lightTheme.colorScheme.primary
                  .withValues(alpha: 0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: buttonIcon == Icons.play_arrow
                      ? 'play_arrow'
                      : 'self_improvement',
                  color: Colors.white,
                  size: 6.w,
                ),
                SizedBox(width: 3.w),
                Text(
                  buttonText,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
