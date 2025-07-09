import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ProfileSectionWidget extends StatelessWidget {
  final bool isDarkMode;

  const ProfileSectionWidget({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: isDarkMode ? AppTheme.cardDark : AppTheme.cardLight,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDarkMode ? AppTheme.shadowDark : AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 15.w,
            height: 15.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDarkMode
                  ? AppTheme.primaryDark.withValues(alpha: 0.2)
                  : AppTheme.primaryLight.withValues(alpha: 0.2),
            ),
            child: CustomIconWidget(
              iconName: 'person',
              color: isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
              size: 8.w,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: isDarkMode
                        ? AppTheme.textPrimaryDark
                        : AppTheme.textPrimaryLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'john.doe@example.com',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: isDarkMode
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              // Edit profile functionality
            },
            child: Text(
              'Edit Profile',
              style: TextStyle(
                color:
                    isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
