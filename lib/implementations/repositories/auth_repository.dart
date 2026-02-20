import '../../data/dtos/auth/register_request_dto.dart';
import '../../data/dtos/login/user_dto.dart';

import '../local/app_database.dart';
import '../mapper/auth_mapper.dart';
import '../../interfaces/repositories/iauth_repository.dart';
import '../../domain/entities/user.dart';

class AuthRepository implements IAuthRepository {
  final AppDatabase _db = AppDatabase.instance;
  final AuthMapper _mapper = AuthMapper();

  @override
  Future<bool> register(RegisterRequestDto request) async {
    final database = await _db.database;

    // Đúc data từ Request vào DTO để lưu DB
    final userDto = UserDto(
      fullName: request.fullName,
      email: request.email,
      password: request.password,
      dob: request.dob,
    );

    try {
      final id = await database.insert('users', userDto.toMap());
      return id != -1; // Thành công nếu ID khác -1
    } catch (e) {
      print("Lỗi register: $e");
      return false; // Trùng email hoặc lỗi DB
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    final database = await _db.database;

    // 1. Query Database (trả về List<Map>)
    final maps = await database.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      // 2. Map sang DTO
      final userDto = UserDto.fromMap(maps.first);
      // 3. Map DTO sang Entity và trả về cho UI
      return _mapper.toEntity(userDto);
    }

    return null; // Sai email/pass
  }
}
