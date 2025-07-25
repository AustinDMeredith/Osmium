import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'database/database_helper.dart';
import 'mainScaffold.dart';
import 'models/goalmanager.dart';
import 'models/taskmanager.dart';
import 'models/ProgressLogManager.dart';
import 'models/projectManager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize PostgreSQL database
  try {
    await DatabaseHelper.instance.initConnection();
    print('Database setup complete!');
  } catch (e) {
    print('Failed to initialize database: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GoalManager()),
        ChangeNotifierProvider(create: (_) => TaskManager()),
        ChangeNotifierProvider(create: (_) => ProgressLogManager()),
        ChangeNotifierProvider(create: (_) => ProjectManager()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xFF1E88E5),        // Blue accent
          onPrimary: Colors.white,           // Text/icons on primary
          secondary: Color(0xFF26C6DA),      // Cyan accent
          onSecondary: Colors.black,         // Text/icons on secondary
          error: Color(0xFFCF6679),          // Red for errors
          onError: Colors.black,             // Text/icons on error
          surface: Color(0xFF222222),        // Cards, sheets, etc.
          onSurface: Colors.white,           // Text/icons on surface
          scrim: Colors.indigo,
          outline: Color(0xFF181818),
        ),

        scaffoldBackgroundColor: const Color(0xFF121212),
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF181818),
          foregroundColor: Colors.white,
        ),
      ),

      debugShowCheckedModeBanner: false,
      home: MainScaffold(),
    );
  }
}