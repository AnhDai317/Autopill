import 'package:flutter/material.dart';
import 'package:autopill/presentation/dashboard/dashboard_screen.dart'; // Import trang home của bạn

void main() {
  // Nếu bạn dùng GetIt (di.dart), hãy khởi tạo ở đây
  // setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoPill',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      // Thay đổi ở đây: Trỏ về DashboardScreen
      home: const DashboardScreen(),
    );
  }
}
