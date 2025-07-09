import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/daily_quote_card_widget.dart';
import './widgets/meditation_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isRefreshing = false;

  // Mock data for daily quote
  final Map<String, dynamic> dailyQuote = {
    "quote": "Peace comes from within. Do not seek it without.",
    "author": "Buddha",
    "date": "Today"
  };

  // Mock data for popular meditations
  final List<Map<String, dynamic>> popularMeditations = [
    {
      "id": 1,
      "title": "Morning Mindfulness",
      "duration": "10 min",
      "difficulty": "Beginner",
      "description":
          "Start your day with clarity and focus through gentle breathing exercises.",
      "benefits": ["Stress Relief", "Better Focus"],
      "imageUrl":
          "https://images.pexels.com/photos/3822622/pexels-photo-3822622.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "isFavorite": false
    },
    {
      "id": 2,
      "title": "Deep Sleep Meditation",
      "duration": "20 min",
      "difficulty": "Intermediate",
      "description":
          "Drift into peaceful sleep with calming visualizations and body relaxation.",
      "benefits": ["Better Sleep", "Relaxation"],
      "imageUrl":
          "https://images.pexels.com/photos/3771069/pexels-photo-3771069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "isFavorite": true
    },
    {
      "id": 3,
      "title": "Anxiety Relief",
      "duration": "15 min",
      "difficulty": "Beginner",
      "description":
          "Find calm in moments of stress with proven anxiety-reducing techniques.",
      "benefits": ["Stress Relief", "Emotional Balance"],
      "imageUrl":
          "https://images.pexels.com/photos/4056723/pexels-photo-4056723.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "isFavorite": false
    },
    {
      "id": 4,
      "title": "Focus & Concentration",
      "duration": "12 min",
      "difficulty": "Intermediate",
      "description":
          "Enhance your mental clarity and concentration for better productivity.",
      "benefits": ["Better Focus", "Mental Clarity"],
      "imageUrl":
          "https://images.pexels.com/photos/3822622/pexels-photo-3822622.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "isFavorite": false
    },
    {
      "id": 5,
      "title": "Loving Kindness",
      "duration": "18 min",
      "difficulty": "Advanced",
      "description":
          "Cultivate compassion and love for yourself and others through guided practice.",
      "benefits": ["Emotional Balance", "Self-Love"],
      "imageUrl":
          "https://images.pexels.com/photos/3771069/pexels-photo-3771069.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "isFavorite": true
    }
  ];

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Already on home screen
        break;
      case 1:
        Navigator.pushNamed(context, '/favorites-screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/settings-screen');
        break;
    }
  }

  void _onMeditationTap(Map<String, dynamic> meditation) {
    Navigator.pushNamed(context, '/meditation-detail-screen');
  }

  void _onMeditationLongPress(Map<String, dynamic> meditation) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4,
              margin: EdgeInsets.only(top: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: meditation["isFavorite"] == true
                    ? 'favorite'
                    : 'favorite_border',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              title: Text(
                meditation["isFavorite"] == true
                    ? 'Remove from Favorites'
                    : 'Add to Favorites',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle favorite toggle
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              title: Text(
                'Share',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle share
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'explore',
                color: AppTheme.lightTheme.primaryColor,
                size: 24,
              ),
              title: Text(
                'Similar Meditations',
                style: AppTheme.lightTheme.textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.pop(context);
                // Handle similar meditations
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, Sarah',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              DateTime.now().toString().split(' ')[0],
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settings-screen'),
            icon: CustomIconWidget(
              iconName: 'settings',
              color: AppTheme.lightTheme.primaryColor,
              size: 24,
            ),
          ),
          SizedBox(width: 2.w),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppTheme.lightTheme.primaryColor,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2.h),

              // Daily Quote Card
              DailyQuoteCardWidget(
                quote: dailyQuote["quote"] as String,
                author: dailyQuote["author"] as String,
                onShare: () {
                  // Handle share functionality
                },
              ),

              SizedBox(height: 4.h),

              // Popular Meditations Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Meditations',
                    style:
                        AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate to explore all meditations
                    },
                    child: Text(
                      'Explore All',
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Meditation Cards List
              _isRefreshing
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: CircularProgressIndicator(
                          color: AppTheme.lightTheme.primaryColor,
                        ),
                      ),
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: popularMeditations.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 2.h),
                      itemBuilder: (context, index) {
                        final meditation = popularMeditations[index];
                        return MeditationCardWidget(
                          title: meditation["title"] as String,
                          duration: meditation["duration"] as String,
                          difficulty: meditation["difficulty"] as String,
                          description: meditation["description"] as String,
                          benefits:
                              (meditation["benefits"] as List).cast<String>(),
                          imageUrl: meditation["imageUrl"] as String,
                          isFavorite: meditation["isFavorite"] as bool,
                          onTap: () => _onMeditationTap(meditation),
                          onLongPress: () => _onMeditationLongPress(meditation),
                          onFavoriteToggle: () {
                            setState(() {
                              meditation["isFavorite"] =
                                  !(meditation["isFavorite"] as bool);
                            });
                          },
                        );
                      },
                    ),

              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
        selectedLabelStyle:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedLabelStyle,
        unselectedLabelStyle:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedLabelStyle,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home',
              color: _currentIndex == 0
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'favorite',
              color: _currentIndex == 1
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'settings',
              color: _currentIndex == 2
                  ? AppTheme.lightTheme.primaryColor
                  : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 24,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
