import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import bộ cuộn iOS
import 'package:google_fonts/google_fonts.dart';

import '../../data/dtos/auth/register_request_dto.dart';
import '../../implementations/repositories/auth_repository.dart';

// --- Hệ thống màu sắc trung tâm của AutoPill ---
class AppColors {
  static const Color primary = Color(0xFF0F66BD);
  static const Color backgroundLight = Color(0xFFF6F7F8);
  static const Color textGray = Color(0xFF4E5E71);
  static const Color dark = Color(0xFF111418);
  static const Color border = Color(0xFFDBE0E6);
}

// --- Custom Button (Có thêm vòng xoay loading) ---
class AutoPillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const AutoPillButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(16),
      elevation: 4,
      shadowColor: AppColors.primary.withOpacity(0.3),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: 64,
          alignment: Alignment.center,
          child: isLoading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 3),
                )
              : Text(
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
  bool _isLoading = false; // Trạng thái đang đăng ký

  DateTime? _selectedDate;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(); // Đổi thành Email
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Hàm mở bộ cuộn ngày tháng năm (Cupertino)
  void _showCupertinoDatePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext builder) {
        return Container(
          height: 300,
          padding: const EdgeInsets.only(top: 10),
          child: SafeArea(
            child: Column(
              children: [
                // Nút Xong để đóng cuộn
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Xong',
                        style: GoogleFonts.lexend(
                            fontSize: 18,
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode:
                        CupertinoDatePickerMode.date, // Chỉ cuộn ngày tháng năm
                    initialDateTime: _selectedDate ?? DateTime(2000, 1, 1),
                    minimumDate: DateTime(1900),
                    maximumDate: DateTime.now(),
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        _selectedDate = newDate;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Hàm xử lý Đăng ký lưu vào DB
  void _handleRegister() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Vui lòng điền đủ thông tin!")));
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Mật khẩu xác nhận không khớp!")));
      return;
    }
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Bạn cần đồng ý với điều khoản để tiếp tục!")));
      return;
    }

    setState(() => _isLoading = true);

    final repo = AuthRepository();
    final request = RegisterRequestDto(
      fullName: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      dob: _selectedDate != null ? _selectedDate!.toIso8601String() : null,
    );

    // Lưu vào Database
    bool success = await repo.register(request);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Đăng ký thành công! Hãy đăng nhập."),
            backgroundColor: Colors.green),
      );
      Navigator.pop(context); // Quay về màn Login
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Email này đã được sử dụng!"),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

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
                    _buildTextField(
                        controller: _nameController,
                        hint: 'Ví dụ: Nguyễn Văn A',
                        icon: Icons.person_outline),

                    const SizedBox(height: 16),
                    _buildBirthDateSection(),

                    const SizedBox(height: 16),
                    // ĐÃ ĐỔI THÀNH EMAIL Ở ĐÂY
                    _buildLabel('Email'),
                    _buildTextField(
                        controller: _emailController,
                        hint: 'Nhập địa chỉ Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress),

                    const SizedBox(height: 16),
                    _buildLabel('Mật khẩu'),
                    _buildPasswordField(
                      controller: _passwordController,
                      hint: 'Tạo mật khẩu bảo mật',
                      isObscure: _isObscure,
                      onToggle: () => setState(() => _isObscure = !_isObscure),
                    ),

                    const SizedBox(height: 16),
                    _buildLabel('Xác nhận mật khẩu'),
                    _buildPasswordField(
                      controller: _confirmPasswordController,
                      hint: 'Nhập lại mật khẩu',
                      isObscure: _isConfirmObscure,
                      onToggle: () => setState(
                          () => _isConfirmObscure = !_isConfirmObscure),
                    ),

                    const SizedBox(height: 16),
                    _buildTermsCheckbox(),

                    const SizedBox(height: 32),

                    // NÚT ĐĂNG KÝ GỌI HÀM VÀ HIỆN LOADING
                    AutoPillButton(
                      text: 'Tạo tài khoản',
                      isLoading: _isLoading,
                      onPressed: _handleRegister,
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

  Widget _buildTextField(
      {required String hint,
      required TextEditingController controller,
      IconData? icon,
      TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.lexend(fontSize: 18),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.lexend(color: const Color(0xFF617589), fontSize: 16),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
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
      required VoidCallback onToggle,
      required TextEditingController controller}) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      style: GoogleFonts.lexend(fontSize: 18),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.lexend(color: const Color(0xFF617589), fontSize: 16),
        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
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
    String dayStr = _selectedDate != null
        ? _selectedDate!.day.toString().padLeft(2, '0')
        : '--';
    String monthStr = _selectedDate != null
        ? _selectedDate!.month.toString().padLeft(2, '0')
        : '--';
    String yearStr =
        _selectedDate != null ? _selectedDate!.year.toString() : '----';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabel('Ngày sinh'),
            Text('Nhấp vào để chọn ngày',
                style: GoogleFonts.lexend(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 13)),
          ],
        ),
        // GẮN SỰ KIỆN MỞ CUỘN Ở ĐÂY
        GestureDetector(
          onTap: _showCupertinoDatePicker,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AppColors.primary.withOpacity(0.5), width: 1.5),
            ),
            child: Row(
              children: [
                _buildDateBox('Ngày', dayStr),
                const SizedBox(width: 8),
                _buildDateBox('Tháng', monthStr),
                const SizedBox(width: 8),
                _buildDateBox('Năm', yearStr, flex: 15),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateBox(String label, String value, {int flex = 10}) {
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
                    color: _selectedDate == null
                        ? Colors.grey
                        : AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
