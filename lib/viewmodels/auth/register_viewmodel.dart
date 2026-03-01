import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  // Validate Email
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return "Email không được để trống";
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) return "Email không đúng định dạng";
    return null;
  }

  // Validate Mật khẩu
  String? validatePassword(String? pass) {
    if (pass == null || pass.isEmpty) return "Mật khẩu không được để trống";
    if (pass.length < 6) return "Mật khẩu tối thiểu 6 ký tự";
    return null;
  }

  // Validate Ngày sinh (Cái bác đang cần)
  String? validateDob(DateTime? dob) {
    if (dob == null) return "Vui lòng chọn ngày sinh";
    if (dob.isAfter(DateTime.now())) {
      return "Ngày sinh không thể lớn hơn ngày hôm nay";
    }
    return null;
  }
}
