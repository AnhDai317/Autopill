import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import đúng link thư mục của project autopill
import 'package:autopill/di.dart'; // Import file di.dart ở trên
import 'package:autopill/presentation/auth/login_screen.dart'; // Gọi đúng LoginScreen
import 'package:autopill/main_screen.dart'; // Gọi đúng MainScreen (có Bottom Nav)

void main() async {
  // Bắt buộc gọi dòng này nếu muốn dùng SharedPreferences trước runApp
  WidgetsFlutterBinding.ensureInitialized();

  // Kiểm tra trạng thái đăng nhập từ trước
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        // Tiêm ViewModel vào toàn App thông qua DI
        ChangeNotifierProvider(
          create: (_) => buildLogin(),
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
      // ĐIỀU HƯỚNG THÔNG MINH:
      // Nếu isLoggedIn == true -> Bắt thẳng vào MainScreen (có 4 tab)
      // Nếu isLoggedIn == false -> Bắt ra LoginScreen
      home: isLoggedIn ? const MainScreen() : const LoginScreen(),
    );
  }
}
