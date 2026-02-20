import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import các file cần thiết
import 'data/implementations/repositories/auth_repository.dart';
import 'viewmodels/login/login_viewmodel.dart';
import 'views/login_page.dart'; // Màn hình đăng nhập của bạn
import 'views/home_page.dart'; // Màn hình chính sau khi đăng nhập (hoặc dashboard_screen.dart)

void main() async {
  // Bắt buộc gọi dòng này nếu muốn dùng SharedPreferences trước runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Kiểm tra trạng thái đăng nhập từ trước
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        // Tiêm ViewModel vào toàn App (Dependency Injection cơ bản)
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(AuthRepository()),
        ),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoPill',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ĐIỀU HƯỚNG THÔNG MINH Ở ĐÂY
      // Nếu true -> Vào thẳng Home. Nếu false -> Bắt ra màn Login
      home: isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
