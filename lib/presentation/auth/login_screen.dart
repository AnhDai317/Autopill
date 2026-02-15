import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Hệ thống màu sắc trung tâm (AppColors) ---
class AppColors {
  static const Color primary = Color(0xFF137FEC);
  static const Color backgroundLight = Color(0xFFF6F7F8);
  static const Color textGray = Color(0xFF617589);
  static const Color border = Color(0xFFDBE0E6);
}

// --- Custom Button để thay thế ElevatedButton (Khắc phục lỗi undefined_method) ---
class AutoPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutlined;

  const AutoPillButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isOutlined ? Colors.transparent : AppColors.primary,
      borderRadius: BorderRadius.circular(16),
      elevation: isOutlined ? 0 : 4,
      shadowColor: AppColors.primary.withOpacity(0.3),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: isOutlined ? 56 : 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isOutlined
                ? Border.all(color: AppColors.primary, width: 2)
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.lexend(
              fontSize: isOutlined ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: isOutlined ? AppColors.primary : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// --- Màn hình Đăng Nhập hoàn thiện ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Đăng Nhập',
          style: GoogleFonts.lexend(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),

                // Logo Section
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.medical_services,
                      size: 60, color: AppColors.primary),
                ),
                const SizedBox(height: 16),
                Text(
                  'AutoPill',
                  style: GoogleFonts.lexend(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Chào mừng bác trở lại. Hãy đăng nhập để quản lý lịch uống thuốc.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lexend(
                      fontSize: 18, color: AppColors.textGray),
                ),
                const SizedBox(height: 32),

                // Input Fields
                _buildInputField(
                  label: 'Số điện thoại hoặc Email',
                  placeholder: 'Nhập thông tin',
                  controller: _identityController,
                  icon: Icons.person,
                ),
                const SizedBox(height: 20),
                _buildPasswordField(),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Quên mật khẩu?',
                      style: GoogleFonts.lexend(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Login Button (Sửa lỗi tại đây)
                AutoPillButton(
                  text: 'ĐĂNG NHẬP NGAY',
                  onPressed: () {
                    print(
                        "Đăng nhập cho AutoPill: ${_identityController.text}");
                  },
                ),

                const SizedBox(height: 40),

                // Register Option
                Text(
                  'Bạn chưa có tài khoản?',
                  style: GoogleFonts.lexend(color: AppColors.textGray),
                ),
                const SizedBox(height: 12),
                AutoPillButton(
                  text: 'Đăng ký tài khoản mới',
                  isOutlined: true,
                  onPressed: () {
                    // Chuyển sang màn hình đăng ký
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String placeholder,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:
                GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: GoogleFonts.lexend(fontSize: 18),
          decoration: InputDecoration(
            hintText: placeholder,
            suffixIcon: Icon(icon, color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mật khẩu',
            style:
                GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          style: GoogleFonts.lexend(fontSize: 18),
          decoration: InputDecoration(
            hintText: 'Nhập mật khẩu',
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(16),
            suffixIcon: IconButton(
              icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey),
              onPressed: () =>
                  setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
