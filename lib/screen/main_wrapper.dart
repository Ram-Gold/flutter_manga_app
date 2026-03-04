import 'package:flutter/material.dart';
import 'browser_manga.dart';
import 'library_manga.dart';
import 'search_manga.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<Widget> screens = [
    const BrowserScreen(),
    LibraryManga(), // Siguraduhin na ang constructor ay tumatanggap ng walang parameters
     SearchManga(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // <--- ITO ANG KAILANGAN PARA HINDI MAG-ERROR
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        backgroundColor: const Color(0xFF0F0F1A), // Matches your other screens
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Browse'),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: 'Library'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
      ),
    );
  }
}