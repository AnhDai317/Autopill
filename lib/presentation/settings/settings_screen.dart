import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF137FEC);
    const backgroundLight = Color(0xFFF6F7F8);
    const textColor = Color(0xFF111418);

    return SingleChildScrollView(
      child: Column(
        children: [
          // 1. Profile Header
          _buildProfileHeader(primaryColor, textColor),

          const SizedBox(height: 16),

          // 2. Settings Menu List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuTile(
                    icon: Icons.account_circle,
                    title: "Thông tin cá nhân",
                    primaryColor: primaryColor,
                    textColor: textColor,
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.notifications_active,
                    title: "Cài đặt thông báo",
                    primaryColor: primaryColor,
                    textColor: textColor,
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.help,
                    title: "Trợ giúp & Hỗ trợ",
                    primaryColor: primaryColor,
                    textColor: textColor,
                    onTap: () {},
                  ),
                  _buildDivider(),
                  _buildMenuTile(
                    icon: Icons.logout,
                    title: "Đăng xuất",
                    primaryColor: Colors.red,
                    textColor: Colors.red,
                    showArrow: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 100), // Khoảng trống cho Bottom Nav
        ],
      ),
    );
  }

  Widget _buildProfileHeader(Color primaryColor, Color textColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(Icons.person, size: 48, color: primaryColor),
          ),
          const SizedBox(height: 16),
          // Name & Email
          Text(
            'Bác Hùng',
            style: GoogleFonts.lexend(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            'bachung@email.com',
            style: GoogleFonts.lexend(
              fontSize: 14,
              color: const Color(0xFF617589),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required Color primaryColor,
    required Color textColor,
    bool showArrow = true,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
            if (showArrow)
              const Icon(
                Icons.chevron_right,
                color: Color(0xFFDBE0E6),
                size: 28,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 64, // Thụt lề để thẳng hàng với text
      color: Colors.grey[100],
    );
  }
}
