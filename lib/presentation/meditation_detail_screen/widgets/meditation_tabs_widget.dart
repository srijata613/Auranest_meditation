import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';
import './about_tab_widget.dart';
import './instructions_tab_widget.dart';

class MeditationTabsWidget extends StatelessWidget {
  final TabController tabController;
  final Map<String, dynamic> meditationData;

  const MeditationTabsWidget({
    Key? key,
    required this.tabController,
    required this.meditationData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tab bar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TabBar(
            controller: tabController,
            indicator: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(1.w),
            labelColor: Colors.white,
            unselectedLabelColor:
                AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            labelStyle: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle:
                AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w400,
            ),
            tabs: const [
              Tab(text: 'About'),
              Tab(text: 'Instructions'),
            ],
          ),
        ),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              AboutTabWidget(meditationData: meditationData),
              InstructionsTabWidget(meditationData: meditationData),
            ],
          ),
        ),
      ],
    );
  }
}
