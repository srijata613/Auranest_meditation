import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './settings_list_tile_widget.dart';

class PreferencesSectionWidget extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeToggle;
  final int favoritesCount;

  const PreferencesSectionWidget({
    Key? key,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.favoritesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Text(
            'Preferences',
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
          child: Column(
            children: [
              SettingsListTileWidget(
                isDarkMode: isDarkMode,
                leading: CustomIconWidget(
                  iconName: isDarkMode ? 'dark_mode' : 'light_mode',
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                  size: 20,
                ),
                title: 'Theme',
                subtitle: isDarkMode ? 'Dark Mode' : 'Light Mode',
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: onThemeToggle,
                  activeColor:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                ),
              ),
              Divider(
                color:
                    isDarkMode ? AppTheme.dividerDark : AppTheme.dividerLight,
                height: 1,
                indent: 16,
                endIndent: 16,
              ),
              SettingsListTileWidget(
                isDarkMode: isDarkMode,
                leading: CustomIconWidget(
                  iconName: 'favorite',
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                  size: 20,
                ),
                title: 'My Favorites',
                subtitle: '$favoritesCount saved meditations',
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 0.5.h),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? AppTheme.primaryDark.withValues(alpha: 0.2)
                            : AppTheme.primaryLight.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$favoritesCount',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: isDarkMode
                              ? AppTheme.primaryDark
                              : AppTheme.primaryLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    CustomIconWidget(
                      iconName: 'arrow_forward_ios',
                      color: isDarkMode
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondaryLight,
                      size: 16,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/favorites-screen');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
