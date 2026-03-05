import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'browser_manga.dart';
import 'library_manga.dart';
import 'search_manga.dart';

// Serves as the main layout container and manages navigation between the primary screens.
class MainWrapper extends StatefulWidget {
  final int initialIndex;
  const MainWrapper({super.key, this.initialIndex = 0});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  // Updates the active tab index when a bottom navigation icon is tapped.
  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      // Uses IndexedStack to preserve the scroll state of each tab when switching views.
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          BrowserScreen(),
          LibraryManga(),
          SearchManga(),
        ],
      ),
      // Provides a persistent navigation bar at the bottom for easy access to main features.
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        backgroundColor: isDark ? const Color(0xFF0F0F1A) : const Color(0xFFF0F0F5),
        selectedItemColor: const Color(0xFFFF8A71),
        unselectedItemColor: isDark ? Colors.grey : const Color(0xFF666666),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            activeIcon: Icon(Icons.grid_view_rounded),
            label: 'Browse'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline), 
            activeIcon: Icon(Icons.bookmark),
            label: 'Library'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search), 
            activeIcon: Icon(Icons.search),
            label: 'Search'
          ),
        ],
      ),
    );
  }
}
