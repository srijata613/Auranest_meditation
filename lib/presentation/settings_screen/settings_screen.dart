import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/about_section_widget.dart';
import './widgets/account_section_widget.dart';
import './widgets/notifications_section_widget.dart';
import './widgets/preferences_section_widget.dart';
import './widgets/profile_section_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  bool _dailyReminders = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);
  String _selectedFrequency = 'Daily';
  String _selectedSound = 'Gentle Bell';
  bool _quietHours = false;
  TimeOfDay _quietStart = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _quietEnd = const TimeOfDay(hour: 7, minute: 0);
  int _favoritesCount = 5;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
      _dailyReminders = prefs.getBool('dailyReminders') ?? true;
      final reminderHour = prefs.getInt('reminderHour') ?? 9;
      final reminderMinute = prefs.getInt('reminderMinute') ?? 0;
      _reminderTime = TimeOfDay(hour: reminderHour, minute: reminderMinute);
      _selectedFrequency = prefs.getString('reminderFrequency') ?? 'Daily';
      _selectedSound = prefs.getString('notificationSound') ?? 'Gentle Bell';
      _quietHours = prefs.getBool('quietHours') ?? false;
      final quietStartHour = prefs.getInt('quietStartHour') ?? 22;
      final quietStartMinute = prefs.getInt('quietStartMinute') ?? 0;
      _quietStart = TimeOfDay(hour: quietStartHour, minute: quietStartMinute);
      final quietEndHour = prefs.getInt('quietEndHour') ?? 7;
      final quietEndMinute = prefs.getInt('quietEndMinute') ?? 0;
      _quietEnd = TimeOfDay(hour: quietEndHour, minute: quietEndMinute);
      _favoritesCount = prefs.getInt('favoritesCount') ?? 5;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    await prefs.setBool('dailyReminders', _dailyReminders);
    await prefs.setInt('reminderHour', _reminderTime.hour);
    await prefs.setInt('reminderMinute', _reminderTime.minute);
    await prefs.setString('reminderFrequency', _selectedFrequency);
    await prefs.setString('notificationSound', _selectedSound);
    await prefs.setBool('quietHours', _quietHours);
    await prefs.setInt('quietStartHour', _quietStart.hour);
    await prefs.setInt('quietStartMinute', _quietStart.minute);
    await prefs.setInt('quietEndHour', _quietEnd.hour);
    await prefs.setInt('quietEndMinute', _quietEnd.minute);
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    _saveSettings();
  }

  void _toggleDailyReminders(bool value) {
    setState(() {
      _dailyReminders = value;
    });
    _saveSettings();
  }

  void _toggleQuietHours(bool value) {
    setState(() {
      _quietHours = value;
    });
    _saveSettings();
  }

  Future<void> _selectReminderTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      builder: (context, child) {
        return Theme(
          data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
          child: child!,
        );
      },
    );
    if (picked != null && picked != _reminderTime) {
      setState(() {
        _reminderTime = picked;
      });
      _saveSettings();
    }
  }

  Future<void> _selectQuietStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _quietStart,
      builder: (context, child) {
        return Theme(
          data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
          child: child!,
        );
      },
    );
    if (picked != null && picked != _quietStart) {
      setState(() {
        _quietStart = picked;
      });
      _saveSettings();
    }
  }

  Future<void> _selectQuietEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _quietEnd,
      builder: (context, child) {
        return Theme(
          data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
          child: child!,
        );
      },
    );
    if (picked != null && picked != _quietEnd) {
      setState(() {
        _quietEnd = picked;
      });
      _saveSettings();
    }
  }

  void _showFrequencySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          _isDarkMode ? AppTheme.surfaceDark : AppTheme.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reminder Frequency',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: _isDarkMode
                      ? AppTheme.textPrimaryDark
                      : AppTheme.textPrimaryLight,
                ),
              ),
              SizedBox(height: 2.h),
              ...['Daily', 'Weekdays', 'Weekends', 'Custom'].map((frequency) {
                return ListTile(
                  title: Text(
                    frequency,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: _isDarkMode
                          ? AppTheme.textPrimaryDark
                          : AppTheme.textPrimaryLight,
                    ),
                  ),
                  trailing: _selectedFrequency == frequency
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: _isDarkMode
                              ? AppTheme.primaryDark
                              : AppTheme.primaryLight,
                          size: 20,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedFrequency = frequency;
                    });
                    _saveSettings();
                    Navigator.pop(context);
                  },
                );
              }).toList(),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  void _showSoundSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          _isDarkMode ? AppTheme.surfaceDark : AppTheme.surfaceLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification Sound',
                style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  color: _isDarkMode
                      ? AppTheme.textPrimaryDark
                      : AppTheme.textPrimaryLight,
                ),
              ),
              SizedBox(height: 2.h),
              ...[
                'Gentle Bell',
                'Singing Bowl',
                'Nature Sounds',
                'Soft Chime',
                'Default'
              ].map((sound) {
                return ListTile(
                  title: Text(
                    sound,
                    style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                      color: _isDarkMode
                          ? AppTheme.textPrimaryDark
                          : AppTheme.textPrimaryLight,
                    ),
                  ),
                  trailing: _selectedSound == sound
                      ? CustomIconWidget(
                          iconName: 'check',
                          color: _isDarkMode
                              ? AppTheme.primaryDark
                              : AppTheme.primaryLight,
                          size: 20,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      _selectedSound = sound;
                    });
                    _saveSettings();
                    Navigator.pop(context);
                  },
                );
              }).toList(),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              _isDarkMode ? AppTheme.dialogDark : AppTheme.dialogLight,
          title: Text(
            'Sign Out',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: _isDarkMode
                  ? AppTheme.textPrimaryDark
                  : AppTheme.textPrimaryLight,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out? You will need to log in again to access your account.',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: _isDarkMode
                  ? AppTheme.textSecondaryDark
                  : AppTheme.textSecondaryLight,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: _isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login-screen',
                    (route) => false,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isDarkMode ? AppTheme.errorDark : AppTheme.errorLight,
              ),
              child: const Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: _isDarkMode
                  ? AppTheme.textPrimaryDark
                  : AppTheme.textPrimaryLight,
            ),
          ),
          backgroundColor:
              _isDarkMode ? AppTheme.backgroundDark : AppTheme.backgroundLight,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileSectionWidget(isDarkMode: _isDarkMode),
                SizedBox(height: 3.h),
                PreferencesSectionWidget(
                  isDarkMode: _isDarkMode,
                  onThemeToggle: _toggleTheme,
                  favoritesCount: _favoritesCount,
                ),
                SizedBox(height: 3.h),
                NotificationsSectionWidget(
                  isDarkMode: _isDarkMode,
                  dailyReminders: _dailyReminders,
                  reminderTime: _reminderTime,
                  selectedFrequency: _selectedFrequency,
                  selectedSound: _selectedSound,
                  quietHours: _quietHours,
                  quietStart: _quietStart,
                  quietEnd: _quietEnd,
                  onDailyRemindersToggle: _toggleDailyReminders,
                  onReminderTimeSelect: _selectReminderTime,
                  onFrequencySelect: _showFrequencySelector,
                  onSoundSelect: _showSoundSelector,
                  onQuietHoursToggle: _toggleQuietHours,
                  onQuietStartSelect: _selectQuietStartTime,
                  onQuietEndSelect: _selectQuietEndTime,
                ),
                SizedBox(height: 3.h),
                AboutSectionWidget(isDarkMode: _isDarkMode),
                SizedBox(height: 3.h),
                AccountSectionWidget(
                  isDarkMode: _isDarkMode,
                  onSignOut: _showSignOutDialog,
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
