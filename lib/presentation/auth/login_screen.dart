import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Lưu trạng thái đăng nhập

import '../../implementations/repositories/auth_repository.dart';
import '../../viewmodels/auth/register_viewmodel.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import '../../main_screen.dart'; // Trỏ về MainScreen để lấy Footer

class AppColors {
  static const Color primary = Color(0xFF0F66BD);
  static const Color backgroundLight = Color(0xFFF6F7F8);
  static const Color textGray = Color(0xFF4E5E71);
  static const Color dark = Color(0xFF111418);
  static const Color border = Color(0xFFDBE0E6);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;

  String? _emailError;
  String? _passwordError;

  // Validate Email
  String? _validateEmailLocal(String email) {
    if (email.isEmpty) return "Email không được để trống";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) return "Email không hợp lệ";
    return null;
  }

  // Validate Mật khẩu (Chỉ kiểm tra rỗng ở màn hình Login)
  String? _validatePasswordLocal(String password) {
    if (password.isEmpty) return "Mật khẩu không được để trống";
    return null;
  }

  void _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _emailError = _validateEmailLocal(email);
      _passwordError = _validatePasswordLocal(password);
    });

    if (_emailError != null || _passwordError != null) return;

    setState(() => _isLoading = true);

    final repo = AuthRepository();
    final user = await repo.login(email, password);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (user != null) {
      // 1. Lưu trạng thái đăng nhập vào máy để không bị bắt đăng nhập lại
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userName', user.fullName ?? 'Người dùng');
      await prefs.setString('userEmail', email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Chào mừng ${user.fullName} trở lại!")),
      );

      // 2. Điều hướng vào MainScreen để giữ lại thanh Footer dưới cùng
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
        (route) => false,
      );
    } else {
      // Báo lỗi CẢ 2 Ô khi sai thông tin
      setState(() {
        _emailError = "Email hoặc mật khẩu không chính xác";
        _passwordError = "Email hoặc mật khẩu không chính xác";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Icon(Icons.medication_liquid,
                      size: 60, color: Colors.white),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'AutoPill',
                  style: GoogleFonts.lexend(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Quản lý sức khỏe mỗi ngày',
                  style: GoogleFonts.lexend(
                      fontSize: 16, color: AppColors.textGray),
                ),
              ),
              const SizedBox(height: 48),
              _buildLabel('Email'),
              _buildTextField(
                  controller: _emailController,
                  hint: 'Nhập email của bạn',
                  icon: Icons.email_outlined,
                  errorText: _emailError,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (_) {
                    if (_emailError != null) setState(() => _emailError = null);
                  }),
              const SizedBox(height: 20),
              _buildLabel('Mật khẩu'),
              _buildPasswordField(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgotPasswordScreen()));
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: GoogleFonts.lexend(
                        color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildLoginButton(),
              const SizedBox(height: 32),
              _buildRegisterLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.lexend(
            fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.dark),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? errorText,
    TextInputType? keyboardType,
    Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        prefixIcon:
            Icon(icon, color: errorText != null ? Colors.red : Colors.grey),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: _isObscure,
      onChanged: (_) {
        if (_passwordError != null) setState(() => _passwordError = null);
      },
      decoration: InputDecoration(
        hintText: 'Nhập mật khẩu',
        errorText: _passwordError,
        prefixIcon: Icon(Icons.lock_outline,
            color: _passwordError != null ? Colors.red : Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility,
              color: _passwordError != null ? Colors.red : Colors.grey),
          onPressed: () => setState(() => _isObscure = !_isObscure),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      child: InkWell(
        onTap: _isLoading ? null : _handleLogin,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: 64,
          alignment: Alignment.center,
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text('ĐĂNG NHẬP',
                  style: GoogleFonts.lexend(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Chưa có tài khoản? ',
            style: GoogleFonts.lexend(color: AppColors.textGray)),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (_) => RegisterViewModel(),
                    child: const RegisterScreen(),
                  ),
                ));
          },
          child: Text(
            'Đăng ký ngay',
            style: GoogleFonts.lexend(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
