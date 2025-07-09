import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/meditation_header_widget.dart';
import './widgets/meditation_tabs_widget.dart';
import './widgets/start_meditation_button_widget.dart';

class MeditationDetailScreen extends StatefulWidget {
  const MeditationDetailScreen({Key? key}) : super(key: key);

  @override
  State<MeditationDetailScreen> createState() => _MeditationDetailScreenState();
}

class _MeditationDetailScreenState extends State<MeditationDetailScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isFavorite = false;
  int _selectedTabIndex = 0;

  // Mock meditation data
  final Map<String, dynamic> _meditationData = {
    "id": 1,
    "title": "Mindful Breathing",
    "duration": "10 min",
    "difficulty": "Beginner",
    "rating": 4.8,
    "totalRatings": 1247,
    "description":
        """Discover the power of mindful breathing in this gentle introduction to meditation. This practice focuses on developing awareness of your natural breath rhythm while cultivating a sense of calm and presence.

Perfect for beginners and experienced practitioners alike, this meditation guides you through simple yet effective breathing techniques that can be used anywhere, anytime.""",
    "benefits": [
      "Reduces stress and anxiety",
      "Improves focus and concentration",
      "Promotes better sleep quality",
      "Enhances emotional regulation",
      "Increases self-awareness"
    ],
    "frequency": "Daily practice recommended",
    "instructions": [
      {
        "step": 1,
        "title": "Find Your Position",
        "description":
            "Sit comfortably with your back straight but not rigid. You can sit on a chair, cushion, or cross-legged on the floor. Rest your hands naturally on your knees or in your lap."
      },
      {
        "step": 2,
        "title": "Close Your Eyes",
        "description":
            "Gently close your eyes or soften your gaze downward. This helps minimize distractions and allows you to focus inward."
      },
      {
        "step": 3,
        "title": "Notice Your Breath",
        "description":
            "Begin to observe your natural breathing pattern. Don't try to change it - simply notice the sensation of air flowing in and out of your nostrils."
      },
      {
        "step": 4,
        "title": "Count Your Breaths",
        "description":
            "Count each exhale from 1 to 10, then start again at 1. If your mind wanders, gently return your attention to counting without judgment."
      },
      {
        "step": 5,
        "title": "Embrace Wandering Thoughts",
        "description":
            "When thoughts arise (and they will), acknowledge them kindly and return your focus to your breath. This is normal and part of the practice."
      },
      {
        "step": 6,
        "title": "End Mindfully",
        "description":
            "When ready to finish, take three deep breaths, wiggle your fingers and toes, and slowly open your eyes. Take a moment to notice how you feel."
      }
    ],
    "imageUrl":
        "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3"
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorite ? 'Added to favorites' : 'Removed from favorites',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
      ),
    );
  }

  void _shareMediation() {
    // Mock sharing functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sharing "${_meditationData["title"]}" meditation...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
      ),
    );
  }

  void _startMeditation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _selectedTabIndex == 0
              ? 'Starting meditation...'
              : 'Beginning practice...',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(4.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button, title, and action buttons
            MeditationHeaderWidget(
              meditationData: _meditationData,
              isFavorite: _isFavorite,
              onFavoriteToggle: _toggleFavorite,
              onShare: _shareMediation,
              onBack: () => Navigator.pop(context),
            ),

            // Tab content
            Expanded(
              child: MeditationTabsWidget(
                tabController: _tabController,
                meditationData: _meditationData,
              ),
            ),

            // Start meditation button
            StartMeditationButtonWidget(
              selectedTabIndex: _selectedTabIndex,
              onPressed: _startMeditation,
            ),
          ],
        ),
      ),
    );
  }
}
