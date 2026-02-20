import 'package:autopill/implementations/repositories/auth_repository.dart';
import 'package:autopill/viewmodels/login/login_viewmodel.dart';

LoginViewModel buildLogin() {
  // Khởi tạo Repository (Mapper và Database đã được khởi tạo ngầm bên trong Repository rồi)
  final repo = AuthRepository();

  // Trả về ViewModel
  return LoginViewModel(repo);
}
