import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './settings_list_tile_widget.dart';

class NotificationsSectionWidget extends StatelessWidget {
  final bool isDarkMode;
  final bool dailyReminders;
  final TimeOfDay reminderTime;
  final String selectedFrequency;
  final String selectedSound;
  final bool quietHours;
  final TimeOfDay quietStart;
  final TimeOfDay quietEnd;
  final Function(bool) onDailyRemindersToggle;
  final VoidCallback onReminderTimeSelect;
  final VoidCallback onFrequencySelect;
  final VoidCallback onSoundSelect;
  final Function(bool) onQuietHoursToggle;
  final VoidCallback onQuietStartSelect;
  final VoidCallback onQuietEndSelect;

  const NotificationsSectionWidget({
    Key? key,
    required this.isDarkMode,
    required this.dailyReminders,
    required this.reminderTime,
    required this.selectedFrequency,
    required this.selectedSound,
    required this.quietHours,
    required this.quietStart,
    required this.quietEnd,
    required this.onDailyRemindersToggle,
    required this.onReminderTimeSelect,
    required this.onFrequencySelect,
    required this.onSoundSelect,
    required this.onQuietHoursToggle,
    required this.onQuietStartSelect,
    required this.onQuietEndSelect,
  }) : super(key: key);

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour == 0 ? 12 : hour}:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Text(
            'Notifications',
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
                  iconName: 'notifications',
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                  size: 20,
                ),
                title: 'Daily Reminders',
                subtitle: dailyReminders ? 'Enabled' : 'Disabled',
                trailing: Switch(
                  value: dailyReminders,
                  onChanged: onDailyRemindersToggle,
                  activeColor:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                ),
              ),
              if (dailyReminders) ...[
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
                    iconName: 'schedule',
                    color: isDarkMode
                        ? AppTheme.primaryDark
                        : AppTheme.primaryLight,
                    size: 20,
                  ),
                  title: 'Reminder Time',
                  subtitle: _formatTime(reminderTime),
                  trailing: CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: isDarkMode
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondaryLight,
                    size: 16,
                  ),
                  onTap: onReminderTimeSelect,
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
                    iconName: 'repeat',
                    color: isDarkMode
                        ? AppTheme.primaryDark
                        : AppTheme.primaryLight,
                    size: 20,
                  ),
                  title: 'Frequency',
                  subtitle: selectedFrequency,
                  trailing: CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: isDarkMode
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondaryLight,
                    size: 16,
                  ),
                  onTap: onFrequencySelect,
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
                    iconName: 'volume_up',
                    color: isDarkMode
                        ? AppTheme.primaryDark
                        : AppTheme.primaryLight,
                    size: 20,
                  ),
                  title: 'Notification Sound',
                  subtitle: selectedSound,
                  trailing: CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: isDarkMode
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondaryLight,
                    size: 16,
                  ),
                  onTap: onSoundSelect,
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
                    iconName: 'do_not_disturb',
                    color: isDarkMode
                        ? AppTheme.primaryDark
                        : AppTheme.primaryLight,
                    size: 20,
                  ),
                  title: 'Quiet Hours',
                  subtitle: quietHours
                      ? '${_formatTime(quietStart)} - ${_formatTime(quietEnd)}'
                      : 'Disabled',
                  trailing: Switch(
                    value: quietHours,
                    onChanged: onQuietHoursToggle,
                    activeColor: isDarkMode
                        ? AppTheme.primaryDark
                        : AppTheme.primaryLight,
                  ),
                ),
                if (quietHours) ...[
                  Divider(
                    color: isDarkMode
                        ? AppTheme.dividerDark
                        : AppTheme.dividerLight,
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  SettingsListTileWidget(
                    isDarkMode: isDarkMode,
                    leading: CustomIconWidget(
                      iconName: 'bedtime',
                      color: isDarkMode
                          ? AppTheme.primaryDark
                          : AppTheme.primaryLight,
                      size: 20,
                    ),
                    title: 'Quiet Start Time',
                    subtitle: _formatTime(quietStart),
                    trailing: CustomIconWidget(
                      iconName: 'arrow_forward_ios',
                      color: isDarkMode
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondaryLight,
                      size: 16,
                    ),
                    onTap: onQuietStartSelect,
                  ),
                  Divider(
                    color: isDarkMode
                        ? AppTheme.dividerDark
                        : AppTheme.dividerLight,
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  SettingsListTileWidget(
                    isDarkMode: isDarkMode,
                    leading: CustomIconWidget(
                      iconName: 'wb_sunny',
                      color: isDarkMode
                          ? AppTheme.primaryDark
                          : AppTheme.primaryLight,
                      size: 20,
                    ),
                    title: 'Quiet End Time',
                    subtitle: _formatTime(quietEnd),
                    trailing: CustomIconWidget(
                      iconName: 'arrow_forward_ios',
                      color: isDarkMode
                          ? AppTheme.textSecondaryDark
                          : AppTheme.textSecondaryLight,
                      size: 16,
                    ),
                    onTap: onQuietEndSelect,
                  ),
                ],
              ],
            ],
          ),
        ),
      ],
    );
  }
}
