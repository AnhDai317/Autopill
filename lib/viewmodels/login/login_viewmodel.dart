import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Đảm bảo đường dẫn này trỏ đúng tới interface IAuthRepository của bác
import '../../interfaces/repositories/iauth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final IAuthRepository _authRepository;

  LoginViewModel(this._authRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Hàm gọi từ nút Đăng Nhập ở UI
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Báo cho UI hiện vòng xoay loading

    try {
      final user = await _authRepository.login(email, password);

      if (user != null) {
        // Đăng nhập thành công -> Lưu cờ đánh dấu đã đăng nhập vào SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userEmail', user.email);

        // Fix: Đề phòng user.id bị null
        await prefs.setInt('userId', user.id ?? 0);

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Email hoặc mật khẩu không chính xác!";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Lỗi hệ thống: $e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
