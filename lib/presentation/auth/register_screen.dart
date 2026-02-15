import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Hệ thống màu sắc trung tâm của AutoPill ---
class AppColors {
  static const Color primary = Color(0xFF0F66BD);
  static const Color backgroundLight = Color(0xFFF6F7F8);
  static const Color textGray = Color(0xFF4E5E71);
  static const Color dark = Color(0xFF111418);
  static const Color border = Color(0xFFDBE0E6);
}

// --- Custom Button để tránh lỗi Analyzer và tiết kiệm RAM ---
class AutoPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AutoPillButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      shadowColor: AppColors.primary.withOpacity(0.3),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: 64,
          alignment: Alignment.center,
          child: Text(
            text,
            style: GoogleFonts.lexend(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscure = true;
  bool _isConfirmObscure = true;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back_ios, color: AppColors.dark, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Đăng Ký Tài Khoản',
          style: GoogleFonts.lexend(
              color: AppColors.dark, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[200], height: 1.0),
        ),
      ),
      body: Stack(
        children: [
          // Decorative background icon
          Positioned(
            bottom: 16,
            right: 16,
            child: Opacity(
              opacity: 0.05,
              child: Icon(Icons.medical_services,
                  size: 120, color: AppColors.primary),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 480),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text(
                      'Tham gia cùng chúng tôi',
                      style: GoogleFonts.lexend(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.dark),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Vui lòng điền thông tin bên dưới để bắt đầu quản lý lịch uống thuốc của bạn.',
                      style: GoogleFonts.lexend(
                          fontSize: 16, color: AppColors.textGray),
                    ),
                    const SizedBox(height: 24),

                    _buildLabel('Họ và tên'),
                    _buildTextField(hint: 'Ví dụ: Nguyễn Văn A'),

                    const SizedBox(height: 16),
                    _buildBirthDateSection(),

                    const SizedBox(height: 16),
                    _buildLabel('Số điện thoại'),
                    _buildTextField(
                        hint: 'Nhập số điện thoại của bạn',
                        keyboardType: TextInputType.phone),

                    const SizedBox(height: 16),
                    _buildLabel('Mật khẩu'),
                    _buildPasswordField(
                      hint: 'Tạo mật khẩu bảo mật',
                      isObscure: _isObscure,
                      onToggle: () => setState(() => _isObscure = !_isObscure),
                    ),

                    const SizedBox(height: 16),
                    _buildLabel('Xác nhận mật khẩu'),
                    _buildPasswordField(
                      hint: 'Nhập lại mật khẩu',
                      isObscure: _isConfirmObscure,
                      onToggle: () => setState(
                          () => _isConfirmObscure = !_isConfirmObscure),
                    ),

                    const SizedBox(height: 16),
                    _buildTermsCheckbox(),

                    const SizedBox(height: 32),
                    // Nút Đăng ký (Đã sửa lỗi)
                    AutoPillButton(
                      text: 'Tạo tài khoản',
                      onPressed: () {
                        if (_agreeToTerms) {
                          print("Đang tạo tài khoản...");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Bạn cần đồng ý với điều khoản để tiếp tục")),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 32),
                    _buildLoginLink(),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.lexend(
            fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.dark),
      ),
    );
  }

  Widget _buildTextField({required String hint, TextInputType? keyboardType}) {
    return TextField(
      keyboardType: keyboardType,
      style: GoogleFonts.lexend(fontSize: 18),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.lexend(color: const Color(0xFF617589), fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2)),
      ),
    );
  }

  Widget _buildPasswordField(
      {required String hint,
      required bool isObscure,
      required VoidCallback onToggle}) {
    return TextField(
      obscureText: isObscure,
      style: GoogleFonts.lexend(fontSize: 18),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.lexend(color: const Color(0xFF617589), fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2)),
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _agreeToTerms,
            activeColor: AppColors.primary,
            onChanged: (val) => setState(() => _agreeToTerms = val!),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style:
                  GoogleFonts.lexend(color: AppColors.textGray, fontSize: 14),
              children: const [
                TextSpan(text: 'Tôi đồng ý với các '),
                TextSpan(
                    text: 'Điều khoản sử dụng',
                    style: TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.bold)),
                TextSpan(text: ' và '),
                TextSpan(
                    text: 'Chính sách bảo mật',
                    style: TextStyle(
                        color: AppColors.primary, fontWeight: FontWeight.bold)),
                TextSpan(text: '.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginLink() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: RichText(
          text: TextSpan(
            style: GoogleFonts.lexend(color: AppColors.textGray, fontSize: 16),
            children: const [
              TextSpan(text: 'Bạn đã có tài khoản? '),
              TextSpan(
                text: 'Đăng nhập ngay',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBirthDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabel('Ngày sinh'),
            Text('Ví dụ: 01/01/1950',
                style: GoogleFonts.lexend(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: AppColors.primary.withOpacity(0.5), width: 1.5),
          ),
          child: Row(
            children: [
              _buildDateDropdown('Ngày', '01'),
              const SizedBox(width: 8),
              _buildDateDropdown('Tháng', '01'),
              const SizedBox(width: 8),
              _buildDateDropdown('Năm', '1950', flex: 15),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateDropdown(String label, String value, {int flex = 10}) {
    return Expanded(
      flex: flex,
      child: Column(
        children: [
          Text(label.toUpperCase(),
              style: GoogleFonts.lexend(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          const SizedBox(height: 4),
          Container(
            height: 48,
            decoration: BoxDecoration(
                color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
            alignment: Alignment.center,
            child: Text(value,
                style: GoogleFonts.lexend(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
