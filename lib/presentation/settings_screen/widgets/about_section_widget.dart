import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import './settings_list_tile_widget.dart';

class AboutSectionWidget extends StatelessWidget {
  final bool isDarkMode;

  const AboutSectionWidget({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  void _showVersionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              isDarkMode ? AppTheme.dialogDark : AppTheme.dialogLight,
          title: Text(
            'ZenFlow Meditation',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: isDarkMode
                  ? AppTheme.textPrimaryDark
                  : AppTheme.textPrimaryLight,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Version 1.0.0',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Build 100',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Your journey to inner peace and mindfulness starts here.',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'OK',
                style: TextStyle(
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              isDarkMode ? AppTheme.dialogDark : AppTheme.dialogLight,
          title: Text(
            'Privacy Policy',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: isDarkMode
                  ? AppTheme.textPrimaryDark
                  : AppTheme.textPrimaryLight,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              'We respect your privacy and are committed to protecting your personal data. This privacy policy explains how we collect, use, and protect your information when you use ZenFlow Meditation.\n\nData Collection:\n• We collect minimal personal information necessary for app functionality\n• Meditation progress and preferences are stored locally on your device\n• No personal data is shared with third parties without your consent\n\nData Usage:\n• Your data is used solely to enhance your meditation experience\n• We may use anonymized usage statistics to improve the app\n\nData Protection:\n• All data is encrypted and securely stored\n• You can delete your account and data at any time',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: isDarkMode
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondaryLight,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextStyle(
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showTermsOfService(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              isDarkMode ? AppTheme.dialogDark : AppTheme.dialogLight,
          title: Text(
            'Terms of Service',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: isDarkMode
                  ? AppTheme.textPrimaryDark
                  : AppTheme.textPrimaryLight,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              'Welcome to ZenFlow Meditation. By using our app, you agree to these terms:\n\n1. Acceptance of Terms\nBy accessing and using this app, you accept and agree to be bound by the terms and provision of this agreement.\n\n2. Use License\nPermission is granted to temporarily use ZenFlow Meditation for personal, non-commercial transitory viewing only.\n\n3. Disclaimer\nThe materials in ZenFlow Meditation are provided on an \'as is\' basis. ZenFlow makes no warranties, expressed or implied.\n\n4. Limitations\nIn no event shall ZenFlow or its suppliers be liable for any damages arising out of the use or inability to use the materials on ZenFlow Meditation.\n\n5. Privacy\nYour privacy is important to us. Please review our Privacy Policy for information on how we collect and use your data.',
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: isDarkMode
                    ? AppTheme.textSecondaryDark
                    : AppTheme.textSecondaryLight,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextStyle(
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showContactSupport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor:
              isDarkMode ? AppTheme.dialogDark : AppTheme.dialogLight,
          title: Text(
            'Contact Support',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: isDarkMode
                  ? AppTheme.textPrimaryDark
                  : AppTheme.textPrimaryLight,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Need help? We\'re here for you!',
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: isDarkMode
                      ? AppTheme.textPrimaryDark
                      : AppTheme.textPrimaryLight,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Email: support@zenflow.com',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                'Response time: Within 24 hours',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'For immediate assistance, please include:\n• Your device model\n• App version\n• Description of the issue',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextStyle(
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          child: Text(
            'About',
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
                  iconName: 'info',
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                  size: 20,
                ),
                title: 'App Version',
                subtitle: 'Version 1.0.0',
                trailing: CustomIconWidget(
                  iconName: 'arrow_forward_ios',
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                  size: 16,
                ),
                onTap: () => _showVersionDialog(context),
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
                  iconName: 'privacy_tip',
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                  size: 20,
                ),
                title: 'Privacy Policy',
                subtitle: 'How we protect your data',
                trailing: CustomIconWidget(
                  iconName: 'arrow_forward_ios',
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                  size: 16,
                ),
                onTap: () => _showPrivacyPolicy(context),
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
                  iconName: 'description',
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                  size: 20,
                ),
                title: 'Terms of Service',
                subtitle: 'App usage terms',
                trailing: CustomIconWidget(
                  iconName: 'arrow_forward_ios',
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                  size: 16,
                ),
                onTap: () => _showTermsOfService(context),
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
                  iconName: 'support',
                  color:
                      isDarkMode ? AppTheme.primaryDark : AppTheme.primaryLight,
                  size: 20,
                ),
                title: 'Contact Support',
                subtitle: 'Get help and support',
                trailing: CustomIconWidget(
                  iconName: 'arrow_forward_ios',
                  color: isDarkMode
                      ? AppTheme.textSecondaryDark
                      : AppTheme.textSecondaryLight,
                  size: 16,
                ),
                onTap: () => _showContactSupport(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
