import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AboutTabWidget extends StatelessWidget {
  final Map<String, dynamic> meditationData;

  const AboutTabWidget({
    Key? key,
    required this.meditationData,
  }) : super(key: key);

  void _showBenefitDetails(BuildContext context, String benefit) {
    final Map<String, String> benefitDetails = {
      "Reduces stress and anxiety":
          "Regular meditation practice activates the parasympathetic nervous system, helping to lower cortisol levels and reduce overall stress response.",
      "Improves focus and concentration":
          "Mindfulness training strengthens attention span and cognitive control, making it easier to maintain focus on tasks.",
      "Promotes better sleep quality":
          "Meditation helps calm the mind and relax the body, leading to improved sleep patterns and deeper rest.",
      "Enhances emotional regulation":
          "Practice develops awareness of emotions and provides tools to respond rather than react to challenging situations.",
      "Increases self-awareness":
          "Regular meditation cultivates deeper understanding of thoughts, feelings, and behavioral patterns."
    };

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 12.w,
                height: 1.w,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 4.w),
            Text(
              benefit,
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 3.w),
            Text(
              benefitDetails[benefit] ??
                  "This benefit supports overall wellness and mental health.",
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            SizedBox(height: 4.w),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> benefits =
        (meditationData["benefits"] as List?)?.cast<String>() ?? [];

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description section
          Text(
            "Description",
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 3.w),
          Text(
            meditationData["description"] ?? "A peaceful meditation practice.",
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              height: 1.6,
            ),
          ),

          SizedBox(height: 6.w),

          // Benefits section
          Text(
            "Key Benefits",
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 3.w),

          Wrap(
            spacing: 2.w,
            runSpacing: 2.w,
            children: benefits.map((benefit) {
              return GestureDetector(
                onLongPress: () => _showBenefitDetails(context, benefit),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.secondary
                          .withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'check_circle',
                        color: AppTheme.lightTheme.colorScheme.secondary,
                        size: 4.w,
                      ),
                      SizedBox(width: 2.w),
                      Flexible(
                        child: Text(
                          benefit,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme.lightTheme.colorScheme.secondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),

          SizedBox(height: 6.w),

          // Frequency section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.tertiary
                    .withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'schedule',
                      color: AppTheme.lightTheme.colorScheme.tertiary,
                      size: 5.w,
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      "Recommended Frequency",
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.tertiary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.w),
                Text(
                  meditationData["frequency"] ??
                      "Practice regularly for best results",
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onTertiaryContainer,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 6.w),

          // Ratings section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User Ratings",
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 3.w),
                Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        final rating = meditationData["rating"] ?? 4.8;
                        return CustomIconWidget(
                          iconName: index < rating.floor()
                              ? 'star'
                              : index < rating
                                  ? 'star_half'
                                  : 'star_border',
                          color: Colors.amber,
                          size: 5.w,
                        );
                      }),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      "${meditationData["rating"] ?? 4.8}",
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "(${meditationData["totalRatings"] ?? 1247} reviews)",
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(height: 20.w), // Extra space for bottom button
        ],
      ),
    );
  }
}
