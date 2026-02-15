import 'package:flutter/material.dart';
import 'main_screen.dart'; // Import file vừa tạo vào đây

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoPill',
      theme: ThemeData(useMaterial3: true),
      home:
          const MainScreen(), // Đổi từ LoginScreen hay ScheduleScreen thành MainScreen
    );
  }
}
