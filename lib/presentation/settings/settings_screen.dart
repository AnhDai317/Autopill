import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/login_screen.dart';

// THÊM 2 DÒNG IMPORT NÀY VÀO (trỏ đúng đường dẫn thư mục anh vừa tạo)
import 'profile_screen.dart';
import 'notification_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _userName = 'Đang tải...';
  String _userEmail = 'Đang tải...';

  final Color primaryColor = const Color(0xFF137FEC);
  final Color backgroundLight = const Color(0xFFF6F7F8);
  final Color textColor = const Color(0xFF111418);

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName') ?? 'Anh Đại';
      _userEmail = prefs.getString('userEmail') ?? 'anhdai.fpt@gmail.com';
    });
  }

  // CẬP NHẬT MỚI: Hàm chuyển sang màn hình Profile
  void _goToProfileScreen() async {
    // Chờ màn hình Profile trả kết quả về (khi pop)
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
    // Nếu có update dữ liệu thì load lại Profile
    if (result == true) {
      _loadUserProfile();
    }
  }

  // CẬP NHẬT MỚI: Hàm chuyển sang màn hình Thông báo
  void _goToNotificationSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const NotificationSettingsScreen()),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Xác nhận đăng xuất",
              style: GoogleFonts.lexend(fontWeight: FontWeight.bold)),
          content: Text("Bạn có chắc chắn muốn thoát khỏi tài khoản này?",
              style: GoogleFonts.lexend()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Đóng dialog
              child: Text("Hủy", style: GoogleFonts.lexend(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                // 1. Xóa dữ liệu đăng nhập trong SharedPreferences
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                // 2. Quay về màn hình Login và xóa sạch các màn hình trước đó
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                }
              },
              child: Text("Đăng xuất",
                  style: GoogleFonts.lexend(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 40),
              child: Column(
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: primaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                    ),
                    child: Icon(Icons.person, size: 48, color: primaryColor),
                  ),
                  const SizedBox(height: 16),
                  Text(_userName,
                      style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: textColor)),
                  Text(_userEmail,
                      style: GoogleFonts.lexend(
                          fontSize: 14, color: const Color(0xFF617589))),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Danh sách Menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    // Gắn hành động chuyển trang thật vào đây
                    _buildMenuItem(Icons.account_circle, "Thông tin cá nhân",
                        primaryColor, textColor, _goToProfileScreen),
                    const Divider(height: 1, indent: 64, endIndent: 20),

                    _buildMenuItem(
                        Icons.notifications_active,
                        "Cài đặt thông báo",
                        primaryColor,
                        textColor,
                        _goToNotificationSettings),
                    const Divider(height: 1, indent: 64, endIndent: 20),

                    _buildMenuItem(Icons.help, "Trợ giúp & Hỗ trợ",
                        primaryColor, textColor, () {}),
                    const Divider(height: 1, indent: 64, endIndent: 20),

                    _buildMenuItem(Icons.logout, "Đăng xuất", Colors.red,
                        Colors.red, _handleLogout,
                        showArrow: false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, Color iconColor,
      Color textColor, VoidCallback onTap,
      {bool showArrow = true}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(width: 16),
            Expanded(
                child: Text(title,
                    style: GoogleFonts.lexend(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: textColor))),
            if (showArrow)
              const Icon(Icons.chevron_right,
                  color: Color(0xFFDBE0E6), size: 28),
          ],
        ),
      ),
    );
  }
}
