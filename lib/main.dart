import 'package:flutter/material.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:provider/provider.dart';
import 'providers/manga_provider.dart';
import 'providers/theme_provider.dart';
import 'screen/main_wrapper.dart';

void main() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // Initialize FFI
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MangaProvider()..fetchManga()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.currentTheme,
      home: const MainWrapper(),
    );
  }
}
