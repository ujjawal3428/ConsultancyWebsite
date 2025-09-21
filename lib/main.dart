import 'package:consultancy_website/screens/shop.dart' show ShopPage;
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
// import 'screens/events_page.dart';
// import 'screens/newsroom_page.dart';
// import 'screens/shop_page.dart';
// import 'screens/consult_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduConsult Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: const Color(0xFFD32F2F),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      // ✅ Define routes here
      routes: {
        '/': (context) => const HomeScreen(),
        // '/events': (context) => const even(),
        // '/newsroom': (context) => const NewsroomPage(),
        '/shop': (context) => const ShopPage(),
        // '/consult': (context) => const ConsultPage(),
      },

      initialRoute: '/', // ✅ App starts with HomeScreen
    );
  }
}
