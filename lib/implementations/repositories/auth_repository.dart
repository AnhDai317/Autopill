import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import '../../data/dtos/auth/register_request_dto.dart';
import '../../data/dtos/login/user_dto.dart';
import '../local/app_database.dart';
import '../mapper/auth_mapper.dart';
import '../../interfaces/repositories/iauth_repository.dart';
import '../../domain/entities/user.dart';
import '../../core/utils/security_util.dart'; // File chứa hàm băm SHA-256

class AuthRepository implements IAuthRepository {
  final AppDatabase _db = AppDatabase.instance;
  final AuthMapper _mapper = AuthMapper();

  // --- 1. ĐĂNG KÝ (Có mã hóa mật khẩu) ---
  @override
  Future<bool> register(RegisterRequestDto request) async {
    final database = await _db.database;

    // Mã hóa mật khẩu trước khi đưa xuống DB
    final hashedPassword = SecurityUtil.hashPassword(request.password);

    final userDto = UserDto(
      fullName: request.fullName,
      email: request.email,
      password: hashedPassword,
      dob: request.dob,
    );

    try {
      // Check trùng email
      final existing = await database.query(
        'users',
        where: 'email = ?',
        whereArgs: [request.email],
      );
      if (existing.isNotEmpty) return false;

      final id = await database.insert('users', userDto.toMap());
      return id != -1;
    } catch (e) {
      print("Lỗi Register: $e");
      return false;
    }
  }

  // --- 2. ĐĂNG NHẬP (So sánh mật khẩu đã mã hóa) ---
  @override
  Future<User?> login(String email, String password) async {
    final database = await _db.database;

    // Phải mã hóa password nhập vào mới so khớp được với cái đã lưu trong DB
    final hashedInput = SecurityUtil.hashPassword(password);

    final maps = await database.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hashedInput],
    );

    if (maps.isNotEmpty) {
      final userDto = UserDto.fromMap(maps.first);
      return _mapper.toEntity(userDto);
    }
    return null;
  }

  // --- 3. QUÊN MẬT KHẨU (Gửi mail thật) ---
  @override
  Future<bool> forgotPassword(String email) async {
    final database = await _db.database;

    // Check xem email có trong máy không
    final users =
        await database.query('users', where: 'email = ?', whereArgs: [email]);
    if (users.isEmpty) return false;

    // Tạo mật khẩu mới ngẫu nhiên 6 số
    String newRawPassword =
        (100000 + (DateTime.now().millisecond % 900000)).toString();

    // Cập nhật pass mới đã mã hóa vào DB
    String hashedNewPass = SecurityUtil.hashPassword(newRawPassword);
    await database.update('users', {'password': hashedNewPass},
        where: 'email = ?', whereArgs: [email]);

    // --- CẤU HÌNH GỬI MAIL ---
    String senderEmail = 'emkobtchoiok@gmail.com';
    String appPassword =
        'qytn pnhq dwrv gzxy'; // Mã lấy từ link Google App Passwords

    final smtpServer = gmail(senderEmail, appPassword);

    final message = Message()
      ..from = Address(senderEmail, 'AutoPill Support')
      ..recipients.add(email)
      ..subject = '🔑 [AutoPill] Khôi phục mật khẩu thành công'
      ..html = """
        <div style='font-family: Arial, sans-serif; padding: 20px; border: 1px solid #eee;'>
          <h2 style='color: #0F66BD;'>Chào anh/chị,</h2>
          <p>Hệ thống AutoPill đã nhận được yêu cầu khôi phục mật khẩu của anh/chị.</p>
          <p>Mật khẩu mới để đăng nhập là: <b style='font-size: 24px; color: #0F66BD;'>$newRawPassword</b></p>
          <p style='color: red;'><i>Lưu ý: Hãy đổi lại mật khẩu ngay sau khi đăng nhập để đảm bảo an toàn.</i></p>
          <br>
          <p>Trân trọng,<br>Đội ngũ AutoPill.</p>
        </div>
      """;

    try {
      await send(message, smtpServer);
      return true;
    } catch (e) {
      print("Lỗi gửi mail: $e");
      return false;
    }
  }
}
