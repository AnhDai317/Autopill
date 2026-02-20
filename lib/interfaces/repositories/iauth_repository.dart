import 'package:autopill/data/dtos/auth/register_request_dto.dart';

import '../../../domain/entities/user.dart';

abstract class IAuthRepository {
  Future<User?> login(String email, String password);
  Future<bool> register(RegisterRequestDto request);
}
