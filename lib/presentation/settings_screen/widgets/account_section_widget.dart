import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './settings_list_tile_widget.dart';

class AccountSectionWidget extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onSignOut;

  const AccountSectionWidget({
    Key? key,
    required this.isDarkMode,
    required this.onSignOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Text(
            'Account',
            style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
              color: isDarkMode
                  ? AppTheme.textSecondaryDark
                  : AppTheme.textSecondaryLight,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
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
          child: SettingsListTileWidget(
            isDarkMode: isDarkMode,
            leading: CustomIconWidget(
              iconName: 'logout',
              color: isDarkMode ? AppTheme.errorDark : AppTheme.errorLight,
              size: 20,
            ),
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            titleColor: isDarkMode ? AppTheme.errorDark : AppTheme.errorLight,
            onTap: onSignOut,
          ),
        ),
      ],
    );
  }
}
