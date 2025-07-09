import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/favorite_meditation_card_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredFavorites = [];
  bool _isLoading = false;

  // Mock favorites data
  final List<Map<String, dynamic>> _favoritesMeditations = [
    {
      "id": 1,
      "title": "Morning Mindfulness",
      "duration": "10 min",
      "lastPracticed": "2 days ago",
      "thumbnail":
          "https://images.pexels.com/photos/3822622/pexels-photo-3822622.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "description":
          "Start your day with peaceful awareness and gentle breathing exercises.",
      "category": "Morning",
      "isFavorite": true,
    },
    {
      "id": 2,
      "title": "Stress Relief",
      "duration": "15 min",
      "lastPracticed": "1 day ago",
      "thumbnail":
          "https://images.pixabay.com/photo/2016/11/29/05/45/astronomy-1867616_1280.jpg",
      "description":
          "Release tension and find calm through guided relaxation techniques.",
      "category": "Stress Relief",
      "isFavorite": true,
    },
    {
      "id": 3,
      "title": "Deep Sleep",
      "duration": "20 min",
      "lastPracticed": "3 days ago",
      "thumbnail":
          "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      "description":
          "Drift into peaceful slumber with soothing sounds and gentle guidance.",
      "category": "Sleep",
      "isFavorite": true,
    },
    {
      "id": 4,
      "title": "Focus & Concentration",
      "duration": "12 min",
      "lastPracticed": "5 days ago",
      "thumbnail":
          "https://images.pexels.com/photos/1051838/pexels-photo-1051838.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "description":
          "Enhance mental clarity and improve concentration through mindful practices.",
      "category": "Focus",
      "isFavorite": true,
    },
    {
      "id": 5,
      "title": "Anxiety Relief",
      "duration": "8 min",
      "lastPracticed": "1 week ago",
      "thumbnail":
          "https://images.pixabay.com/photo/2017/08/06/12/06/people-2591874_1280.jpg",
      "description":
          "Find peace and calm your anxious thoughts with gentle breathing exercises.",
      "category": "Anxiety",
      "isFavorite": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredFavorites = List.from(_favoritesMeditations);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterFavorites(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredFavorites = List.from(_favoritesMeditations);
      } else {
        _filteredFavorites = _favoritesMeditations
            .where((meditation) =>
                (meditation["title"] as String)
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                (meditation["category"] as String)
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _removeFromFavorites(int meditationId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.lightTheme.dialogBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            'Remove from Favorites',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Are you sure you want to remove this meditation from your favorites?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style:
                    TextStyle(color: AppTheme.lightTheme.colorScheme.primary),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _favoritesMeditations
                      .removeWhere((item) => item["id"] == meditationId);
                  _filteredFavorites
                      .removeWhere((item) => item["id"] == meditationId);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Removed from favorites'),
                    backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              child: Text(
                'Remove',
                style: TextStyle(color: AppTheme.lightTheme.colorScheme.error),
              ),
            ),
          ],
        );
      },
    );
  }

  void _shareMeditation(Map<String, dynamic> meditation) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing "${meditation["title"]}"...'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  void _playMeditation(Map<String, dynamic> meditation) {
    Navigator.pushNamed(
      context,
      '/meditation-detail-screen',
      arguments: meditation,
    );
  }

  Future<void> _refreshFavorites() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      _isLoading = false;
      _filteredFavorites = List.from(_favoritesMeditations);
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageWidget(
              imageUrl:
                  "https://images.pexels.com/photos/3822622/pexels-photo-3822622.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              width: 40.w,
              height: 25.h,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 3.h),
            Text(
              'No Favorites Yet',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              'Start building your personal collection of favorite meditations',
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home-screen');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Browse Meditations',
                style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
        ),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _filterFavorites,
        decoration: InputDecoration(
          hintText: 'Search favorites...',
          hintStyle: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(3.w),
            child: CustomIconWidget(
              iconName: 'search',
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _searchController.clear();
                    _filterFavorites('');
                  },
                  icon: CustomIconWidget(
                    iconName: 'clear',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Text(
              'My Favorites',
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 2.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_filteredFavorites.length}',
                style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _refreshFavorites,
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
      body: _favoritesMeditations.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                _buildSearchBar(),
                Expanded(
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _refreshFavorites,
                          color: AppTheme.lightTheme.colorScheme.primary,
                          child: _filteredFavorites.isEmpty
                              ? Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomIconWidget(
                                          iconName: 'search_off',
                                          color: AppTheme.lightTheme.colorScheme
                                              .onSurfaceVariant,
                                          size: 48,
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          'No results found',
                                          style: AppTheme
                                              .lightTheme.textTheme.titleMedium
                                              ?.copyWith(
                                            color: AppTheme.lightTheme
                                                .colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Text(
                                          'Try searching with different keywords',
                                          style: AppTheme
                                              .lightTheme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: AppTheme.lightTheme
                                                .colorScheme.onSurfaceVariant,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ReorderableListView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4.w, vertical: 1.h),
                                  itemCount: _filteredFavorites.length,
                                  onReorder: (oldIndex, newIndex) {
                                    setState(() {
                                      if (newIndex > oldIndex) {
                                        newIndex -= 1;
                                      }
                                      final item =
                                          _filteredFavorites.removeAt(oldIndex);
                                      _filteredFavorites.insert(newIndex, item);
                                    });
                                  },
                                  itemBuilder: (context, index) {
                                    final meditation =
                                        _filteredFavorites[index];
                                    return FavoriteMeditationCardWidget(
                                      key: ValueKey(meditation["id"]),
                                      meditation: meditation,
                                      onRemove: () => _removeFromFavorites(
                                          meditation["id"]),
                                      onShare: () =>
                                          _shareMeditation(meditation),
                                      onPlay: () => _playMeditation(meditation),
                                    );
                                  },
                                ),
                        ),
                ),
              ],
            ),
    );
  }
}
