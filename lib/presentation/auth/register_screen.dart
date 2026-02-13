import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Định nghĩa màu sắc từ thiết kế HTML
  final Color primaryColor = const Color(0xFF0F66BD);
  final Color backgroundLight = const Color(0xFFF6F7F8);
  final Color textGray = const Color(0xFF4E5E71);

  bool _isObscure = true;
  bool _isConfirmObscure = true;
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF111418),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Đăng Ký Tài Khoản',
          style: GoogleFonts.lexend(
            color: const Color(0xFF111418),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
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
              child: Icon(
                Icons.medical_services,
                size: 120,
                color: primaryColor,
              ),
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
                        color: const Color(0xFF111418),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Vui lòng điền thông tin bên dưới để bắt đầu quản lý lịch uống thuốc của bạn một cách dễ dàng.',
                      style: GoogleFonts.lexend(fontSize: 18, color: textGray),
                    ),
                    const SizedBox(height: 24),

                    // Input Fields
                    _buildLabel('Họ và tên'),
                    _buildTextField(hint: 'Ví dụ: Nguyễn Văn A'),

                    const SizedBox(height: 16),
                    _buildBirthDateSection(),

                    const SizedBox(height: 16),
                    _buildLabel('Số điện thoại'),
                    _buildTextField(
                      hint: 'Nhập số điện thoại của bạn',
                      keyboardType: TextInputType.phone,
                    ),

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
                        () => _isConfirmObscure = !_isConfirmObscure,
                      ),
                    ),

                    const SizedBox(height: 16),
                    // Terms and Conditions checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _agreeToTerms,
                            activeColor: primaryColor,
                            onChanged: (val) =>
                                setState(() => _agreeToTerms = val!),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: GoogleFonts.lexend(
                                color: textGray,
                                fontSize: 16,
                              ),
                              children: [
                                const TextSpan(text: 'Tôi đồng ý với các '),
                                TextSpan(
                                  text: 'Điều khoản sử dụng',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: ' và '),
                                TextSpan(
                                  text: 'Chính sách bảo mật',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),
                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      height: 64,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: primaryColor.withOpacity(0.3),
                        ),
                        child: Text(
                          'Tạo tài khoản',
                          style: GoogleFonts.lexend(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                    Center(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: RichText(
                          text: TextSpan(
                            style: GoogleFonts.lexend(
                              color: textGray,
                              fontSize: 18,
                            ),
                            children: [
                              const TextSpan(text: 'Bạn đã có tài khoản? '),
                              TextSpan(
                                text: 'Đăng nhập ngay',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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

  // Widget hỗ trợ: Label
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: GoogleFonts.lexend(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF111418),
        ),
      ),
    );
  }

  // Widget hỗ trợ: TextField thông thường
  Widget _buildTextField({required String hint, TextInputType? keyboardType}) {
    return TextField(
      keyboardType: keyboardType,
      style: GoogleFonts.lexend(fontSize: 20),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.lexend(color: const Color(0xFF617589)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDBE0E6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }

  // Widget hỗ trợ: PasswordField
  Widget _buildPasswordField({
    required String hint,
    required bool isObscure,
    required VoidCallback onToggle,
  }) {
    return TextField(
      obscureText: isObscure,
      style: GoogleFonts.lexend(fontSize: 20),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.lexend(color: const Color(0xFF617589)),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        suffixIcon: IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: onToggle,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFDBE0E6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }

  // Widget hỗ trợ: Birth Date Selector
  Widget _buildBirthDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabel('Ngày sinh'),
            Text(
              'Ví dụ: 01/01/1950',
              style: GoogleFonts.lexend(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primaryColor, width: 2),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
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
        const SizedBox(height: 4),
        Text(
          'Chọn ngày, tháng và năm sinh của bạn để chúng tôi hỗ trợ tốt nhất.',
          style: GoogleFonts.lexend(
            color: const Color(0xFF617589),
            fontSize: 14,
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
          Text(
            label.toUpperCase(),
            style: GoogleFonts.lexend(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  value,
                  style: GoogleFonts.lexend(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const Positioned(
                  right: 4,
                  child: Icon(Icons.unfold_more, size: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
