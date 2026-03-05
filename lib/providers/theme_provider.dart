import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1E1E1E),
    primaryColor: Colors.white,
    hintColor: const Color(0xFFA6A6BB),
    cardColor: const Color(0xFF323240),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
    ),
    // Custom colors for specific elements
    extensions: [
      MangaThemeColors(
        searchIcon: const Color(0xFFA6A6BB),
        searchBarBg: const Color(0xFF323240),
        searchBarPlaceholder: const Color(0xFFA6A6BB),
        genrePillBg: const Color(0xFF323240).withOpacity(0.3),
        genrePillText: Colors.white,
        headingTitle: Colors.white,
      ),
    ],
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.black,
    hintColor: const Color(0xFF666666),
    cardColor: const Color(0xFFF0F0F5),
    textTheme: const TextTheme(
      titleLarge: TextStyle(color: Color(0xFF1A1A1A)),
      bodyMedium: TextStyle(color: Colors.black),
    ),
    extensions: [
      MangaThemeColors(
        searchIcon: const Color(0xFF666666),
        searchBarBg: const Color(0xFFF0F0F5),
        searchBarPlaceholder: const Color(0xFF666666),
        genrePillBg: const Color(0xFFD2D2DC).withOpacity(0.4),
        genrePillText: const Color(0xFF2D2D2D),
        headingTitle: const Color(0xFF1A1A1A),
      ),
    ],
  );
}

class MangaThemeColors extends ThemeExtension<MangaThemeColors> {
  final Color? searchIcon;
  final Color? searchBarBg;
  final Color? searchBarPlaceholder;
  final Color? genrePillBg;
  final Color? genrePillText;
  final Color? headingTitle;

  MangaThemeColors({
    this.searchIcon,
    this.searchBarBg,
    this.searchBarPlaceholder,
    this.genrePillBg,
    this.genrePillText,
    this.headingTitle,
  });

  @override
  ThemeExtension<MangaThemeColors> copyWith({
    Color? searchIcon,
    Color? searchBarBg,
    Color? searchBarPlaceholder,
    Color? genrePillBg,
    Color? genrePillText,
    Color? headingTitle,
  }) {
    return MangaThemeColors(
      searchIcon: searchIcon ?? this.searchIcon,
      searchBarBg: searchBarBg ?? this.searchBarBg,
      searchBarPlaceholder: searchBarPlaceholder ?? this.searchBarPlaceholder,
      genrePillBg: genrePillBg ?? this.genrePillBg,
      genrePillText: genrePillText ?? this.genrePillText,
      headingTitle: headingTitle ?? this.headingTitle,
    );
  }

  @override
  ThemeExtension<MangaThemeColors> lerp(ThemeExtension<MangaThemeColors>? other, double t) {
    if (other is! MangaThemeColors) return this;
    return MangaThemeColors(
      searchIcon: Color.lerp(searchIcon, other.searchIcon, t),
      searchBarBg: Color.lerp(searchBarBg, other.searchBarBg, t),
      searchBarPlaceholder: Color.lerp(searchBarPlaceholder, other.searchBarPlaceholder, t),
      genrePillBg: Color.lerp(genrePillBg, other.genrePillBg, t),
      genrePillText: Color.lerp(genrePillText, other.genrePillText, t),
      headingTitle: Color.lerp(headingTitle, other.headingTitle, t),
    );
  }
}
